import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../core/utils/vn_date.dart';
import '../../domain/replay.dart';
import '../../domain/weak_topics.dart';
import '../models/catalog_models.dart';

const _uuid = Uuid();

// Tiến độ học của 1 chủ đề (để hiện ở tab Học)
class TopicProgress {
  const TopicProgress({
    required this.code,
    required this.name,
    required this.total,
    required this.answered,
    required this.correct,
    required this.wrong,
  });

  final String code;
  final String name;
  final int total; // số câu của chủ đề (theo hạng đang chọn)
  final int answered; // số câu đã làm ít nhất 1 lần
  final int correct; // tổng số lần trả lời đúng
  final int wrong; // tổng số lần trả lời sai

  // tỉ lệ câu đã học, từ 0 đến 1
  double get progress => total == 0 ? 0 : answered / total;

  // tỉ lệ đúng, null nếu chưa trả lời lần nào
  double? get accuracy {
    final all = correct + wrong;
    return all == 0 ? null : correct / all;
  }
}

// Ghi lại từng lần trả lời và tính lại tiến độ của câu.
// Tiến độ (bảng question_progress) luôn được tính từ lịch sử (bảng answer_events)
// bằng hàm replay(), không cộng dồn tay -> số liệu luôn đúng.
class ProgressRepository {
  ProgressRepository(this.db, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final AppDatabase db;

  // hàm lấy giờ hiện tại. Test truyền hàm giả để điều khiển thời gian.
  final DateTime Function() _now;

  // ---------------------------------------------------------------
  // Ghi câu trả lời
  // ---------------------------------------------------------------

  // source: học theo chủ đề ('study'), ôn câu điểm liệt ('critical'), ôn sổ câu sai ('review')...
  Future<ProgressState> recordAnswer({
    required QuestionItem question,
    required String? selectedKey,
    required int? responseMs,
    required String source,
  }) async {
    final isCorrect = selectedKey != null && selectedKey == question.correctKey;
    late ProgressState state;

    // transaction: ghi lịch sử và cập nhật tiến độ cùng lúc, lỗi thì hủy cả hai
    await db.transaction(() async {
      await db
          .into(db.answerEvents)
          .insert(
            AnswerEventsCompanion.insert(
              clientEventId: _uuid.v4(), // mã riêng, không bao giờ trùng
              questionId: question.id,
              questionNumber: question.number,
              selectedKey: Value(selectedKey),
              isCorrect: isCorrect,
              responseMs: Value(responseMs),
              source: source,
              answeredAt: _now().toUtc(),
              deviceId: await _deviceId(),
            ),
          );
      state = await _replayQuestion(question.id);
    });
    return state;
  }

  // Tính lại tiến độ 1 câu từ toàn bộ lịch sử trả lời của câu đó rồi lưu lại
  Future<ProgressState> _replayQuestion(String questionId) async {
    final rows = await (db.select(
      db.answerEvents,
    )..where((e) => e.questionId.equals(questionId))).get();
    final question = await (db.select(
      db.questions,
    )..where((q) => q.id.equals(questionId))).getSingleOrNull();

    final events = rows
        .map(
          (e) => ReplayEvent(
            clientEventId: e.clientEventId,
            isCorrect: e.isCorrect,
            responseMs: e.responseMs,
            answeredAt: e.answeredAt,
          ),
        )
        .toList();
    final s = replay(events, question?.answerChangedAt);

    await db
        .into(db.questionProgress)
        .insertOnConflictUpdate(
          QuestionProgressCompanion.insert(
            questionId: questionId,
            ef: s.ef,
            interval: s.interval,
            reps: s.reps,
            dueDate: Value(s.dueDate),
            correctCount: s.correctCount,
            wrongCount: s.wrongCount,
            consecutiveCorrect: s.consecutiveCorrect,
            inWrongBook: s.inWrongBook,
            lastAnsweredAt: Value(s.lastAnsweredAt),
          ),
        );
    return s;
  }

  // Mã của điện thoại này: tạo 1 lần rồi lưu trong bảng meta
  Future<String> _deviceId() async {
    final saved = await db.getMeta('deviceId');
    if (saved != null) return saved;
    final id = _uuid.v4();
    await db.setMeta('deviceId', id);
    return id;
  }

  // ---------------------------------------------------------------
  // Đọc tiến độ (dạng stream: dữ liệu đổi thì màn hình tự cập nhật)
  // ---------------------------------------------------------------

  // Tiến độ của mọi câu đã học: { id câu: tiến độ }
  Stream<Map<String, ProgressRow>> watchProgressMap() {
    return db
        .select(db.questionProgress)
        .watch()
        .map((rows) => {for (final r in rows) r.questionId: r});
  }

  // Tiến độ của 6 chủ đề theo hạng bằng đang chọn
  Stream<List<TopicProgress>> watchTopicProgress(String licenseClass) {
    return watchProgressMap().asyncMap((progress) async {
      final categories = await (db.select(
        db.categories,
      )..orderBy([(c) => OrderingTerm(expression: c.sortOrder)])).get();
      final questions =
          await (db.select(db.questions)..where(
                (q) =>
                    q.status.equals('active') &
                    q.licenseClasses.like('%,$licenseClass,%'),
              ))
              .get();

      return [
        for (final c in categories)
          _topicOf(
            c,
            questions.where((q) => q.categoryCode == c.code),
            progress,
          ),
      ];
    });
  }

  TopicProgress _topicOf(
    Category category,
    Iterable<Question> questions,
    Map<String, ProgressRow> progress,
  ) {
    var answered = 0;
    var correct = 0;
    var wrong = 0;
    for (final q in questions) {
      final p = progress[q.id];
      if (p == null) continue; // câu chưa học
      answered++;
      correct += p.correctCount;
      wrong += p.wrongCount;
    }
    return TopicProgress(
      code: category.code,
      name: category.name,
      total: questions.length,
      answered: answered,
      correct: correct,
      wrong: wrong,
    );
  }

  // Các câu đang nằm trong sổ câu sai (theo hạng), xếp theo số câu
  Stream<List<String>> watchWrongBookIds(String licenseClass) {
    return db
        .customSelect(
          'SELECT p.question_id AS id FROM question_progress p '
          'JOIN questions q ON q.id = p.question_id '
          "WHERE q.status = 'active' AND q.license_classes LIKE ? "
          'AND p.in_wrong_book = 1 ORDER BY q.number',
          variables: [Variable.withString('%,$licenseClass,%')],
          readsFrom: {db.questionProgress, db.questions},
        )
        .watch()
        .map((rows) => rows.map((r) => r.read<String>('id')).toList());
  }

  // ---------------------------------------------------------------
  // Số liệu cho Trang chủ và Thống kê
  // ---------------------------------------------------------------

  // Số câu đã trả lời mỗi ngày (ngày theo giờ VN), vd { '2026-10-20': 15 }
  // Dùng để tính chuỗi ngày học.
  Future<Map<String, int>> dayCounts() async {
    final events = await db.select(db.answerEvents).get();
    final counts = <String, int>{};
    for (final e in events) {
      final day = vnDay(e.answeredAt);
      counts[day] = (counts[day] ?? 0) + 1;
    }
    return counts;
  }

  // Các câu đến hạn ôn (hạn <= hôm nay) của hạng này, câu quá hạn lâu nhất đứng trước
  Future<List<String>> dueQuestionIds(String licenseClass, String today) async {
    final rows = await db
        .customSelect(
          'SELECT p.question_id AS id FROM question_progress p '
          'JOIN questions q ON q.id = p.question_id '
          "WHERE q.status = 'active' AND q.license_classes LIKE ? "
          'AND p.due_date IS NOT NULL AND p.due_date <= ? '
          'ORDER BY p.due_date, q.number',
          variables: [
            Variable.withString('%,$licenseClass,%'),
            Variable.withString(today),
          ],
        )
        .get();
    return rows.map((r) => r.read<String>('id')).toList();
  }

  // Lịch sử trả lời kèm chủ đề của từng câu (của hạng này), để tìm chủ đề yếu
  Future<List<TopicEvent>> topicEvents(String licenseClass) async {
    final query =
        db.select(db.answerEvents).join([
          innerJoin(
            db.questions,
            db.questions.id.equalsExp(db.answerEvents.questionId),
          ),
        ])..where(
          db.questions.status.equals('active') &
              db.questions.licenseClasses.like('%,$licenseClass,%'),
        );

    final rows = await query.get();
    return [
      for (final r in rows)
        TopicEvent(
          categoryCode: r.readTable(db.questions).categoryCode,
          isCorrect: r.readTable(db.answerEvents).isCorrect,
          answeredAt: r.readTable(db.answerEvents).answeredAt,
        ),
    ];
  }

  // ---------------------------------------------------------------
  // Câu đã lưu (đánh dấu)
  // ---------------------------------------------------------------

  Stream<bool> watchBookmarked(String questionId) {
    return (db.select(db.bookmarks)
          ..where((b) => b.questionId.equals(questionId)))
        .watchSingleOrNull()
        .map((b) => b?.bookmarked ?? false);
  }

  Stream<List<String>> watchBookmarkIds(String licenseClass) {
    return db
        .customSelect(
          'SELECT b.question_id AS id FROM bookmarks b '
          'JOIN questions q ON q.id = b.question_id '
          "WHERE b.bookmarked = 1 AND q.status = 'active' AND q.license_classes LIKE ? "
          'ORDER BY q.number',
          variables: [Variable.withString('%,$licenseClass,%')],
          readsFrom: {db.bookmarks, db.questions},
        )
        .watch()
        .map((rows) => rows.map((r) => r.read<String>('id')).toList());
  }

  // Bỏ lưu thì giữ dòng với bookmarked = false (không xóa) để sau này đồng bộ được
  Future<void> setBookmark(String questionId, bool value) async {
    await db
        .into(db.bookmarks)
        .insertOnConflictUpdate(
          BookmarksCompanion.insert(
            questionId: questionId,
            bookmarked: value,
            clientUpdatedAt: _now().toUtc(),
          ),
        );
  }
}
