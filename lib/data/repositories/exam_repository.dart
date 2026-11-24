import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/app_database.dart';
import '../../domain/exam_generator.dart';
import '../../domain/grade.dart';
import '../models/catalog_models.dart';
import 'catalog_repository.dart';
import 'progress_repository.dart';

const _uuid = Uuid();

// Kiểu đề
const examModeMock = 'mock'; // đề ngẫu nhiên đúng cấu trúc đề thật
const examModeReview = 'review'; // đề lấy từ sổ câu sai

// Bài thi đang làm (đọc từ bảng exam_sessions)
class ExamSessionData {
  const ExamSessionData({
    required this.id,
    required this.licenseClass,
    required this.mode,
    required this.questionIds,
    required this.answers,
    required this.passScore,
    required this.startedAt,
    required this.deadlineAt,
  });

  final String id;
  final String licenseClass;
  final String mode;
  final List<String> questionIds;
  final Map<String, String> answers; // { id câu: đáp án đã chọn }
  final int passScore;
  final DateTime startedAt;
  final DateTime deadlineAt; // hết giờ lúc nào

  factory ExamSessionData.fromRow(ExamSession row) {
    return ExamSessionData(
      id: row.id,
      licenseClass: row.licenseClass,
      mode: row.mode,
      questionIds: (jsonDecode(row.questionIdsJson) as List).cast<String>(),
      answers: Map<String, String>.from(jsonDecode(row.answersJson) as Map),
      passScore: row.passScore,
      startedAt: row.startedAt,
      deadlineAt: row.deadlineAt,
    );
  }
}

// 1 câu trong bài đã nộp. Lưu luôn nội dung câu lúc thi,
// sau này câu hỏi bị sửa thì xem lại vẫn đúng đề cũ.
class AttemptItem {
  const AttemptItem({
    required this.questionId,
    required this.number,
    required this.content,
    required this.imageRef,
    required this.options,
    required this.correctKey,
    required this.selectedKey,
    required this.isCritical,
    required this.explanation,
  });

  final String questionId;
  final int number;
  final String content;
  final String? imageRef;
  final List<QuestionOption> options;
  final String correctKey;
  final String? selectedKey; // null = bỏ trống
  final bool isCritical;
  final String? explanation;

  bool get isRight => selectedKey != null && selectedKey == correctKey;

  factory AttemptItem.fromJson(Map<String, dynamic> json) {
    return AttemptItem(
      questionId: json['questionId'] as String,
      number: json['number'] as int,
      content: json['content'] as String,
      imageRef: json['imageRef'] as String?,
      options: (json['options'] as List)
          .map((o) => QuestionOption.fromJson(Map<String, dynamic>.from(o)))
          .toList(),
      correctKey: json['correctKey'] as String,
      selectedKey: json['selectedKey'] as String?,
      isCritical: json['isCritical'] as bool,
      explanation: json['explanation'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'questionId': questionId,
    'number': number,
    'content': content,
    'imageRef': imageRef,
    'options': options.map((o) => o.toJson()).toList(),
    'correctKey': correctKey,
    'selectedKey': selectedKey,
    'isCritical': isCritical,
    'explanation': explanation,
  };
}

// Bài thi đã nộp (1 dòng lịch sử thi)
class AttemptData {
  const AttemptData({
    required this.id,
    required this.licenseClass,
    required this.mode,
    required this.items,
    required this.correctCount,
    required this.total,
    required this.passScore,
    required this.passed,
    required this.failedByCritical,
    required this.durationSec,
    required this.submittedAt,
  });

  final String id;
  final String licenseClass;
  final String mode;
  final List<AttemptItem> items;
  final int correctCount;
  final int total;
  final int passScore;
  final bool passed;
  final bool failedByCritical;
  final int durationSec;
  final DateTime submittedAt;

  factory AttemptData.fromRow(ExamAttempt row) {
    return AttemptData(
      id: row.clientId,
      licenseClass: row.licenseClass,
      mode: row.mode,
      items: (jsonDecode(row.itemsJson) as List)
          .map((i) => AttemptItem.fromJson(Map<String, dynamic>.from(i)))
          .toList(),
      correctCount: row.correctCount,
      total: row.total,
      passScore: row.passScore,
      passed: row.passed,
      failedByCritical: row.failedByCritical,
      durationSec: row.durationSec,
      submittedAt: row.submittedAt,
    );
  }
}

// Thi thử: tạo đề, lưu đáp án từng câu, nộp bài, xem lịch sử.
// Bài đang làm lưu trong SQLite nên thoát app vào lại vẫn làm tiếp được.
class ExamRepository {
  ExamRepository(
    this.db,
    this.catalog,
    this.progress, {
    DateTime Function()? clock,
    this.fixedRandom,
  }) : _now = clock ?? DateTime.now;

  final AppDatabase db;
  final CatalogRepository catalog;
  final ProgressRepository progress;
  final DateTime Function() _now;
  final double Function()? fixedRandom; // test truyền vào để đề luôn giống nhau

  // ---------------------------------------------------------------
  // Bắt đầu bài thi
  // ---------------------------------------------------------------

  // Tạo đề mới và lưu thành bài đang làm. Có bài dở thì bỏ bài đó.
  // Trả về null nếu không đủ câu để tạo đề (vd sổ câu sai đang trống).
  Future<ExamSessionData?> start({
    required String licenseClass,
    required String mode,
  }) async {
    final info = await catalog.licenseClass(licenseClass);
    if (info == null) return null;
    final config = info.config;
    final all = await catalog.questionsForClass(licenseClass);

    // mỗi đề 1 seed khác nhau -> mỗi lần thi ra đề khác
    final random =
        fixedRandom ?? seededRandom(_now().millisecondsSinceEpoch & 0xFFFFFFFF);

    List<String> ids;
    if (mode == examModeReview) {
      // đề ôn câu sai: lấy các câu trong sổ câu sai, xáo trộn, tối đa bằng số câu đề thật
      final wrongIds = await progress.watchWrongBookIds(licenseClass).first;
      if (wrongIds.isEmpty) return null;
      final shuffled = List<String>.of(wrongIds);
      for (var i = shuffled.length - 1; i > 0; i--) {
        final j = (random() * (i + 1)).floor();
        final tmp = shuffled[i];
        shuffled[i] = shuffled[j];
        shuffled[j] = tmp;
      }
      ids = shuffled.take(config.totalQuestions).toList();
    } else {
      // đề thường: sinh đề theo cấu trúc (bao nhiêu câu mỗi phần, 1 câu điểm liệt)
      final exam = generateExam(all, config, licenseClass, random);
      ids = exam.questions.map((q) => q.id).toList();
    }
    if (ids.isEmpty) return null;

    // đề ôn câu sai ít câu hơn thì điểm đậu tính theo tỉ lệ của đề thật
    final passScore = ids.length == config.totalQuestions
        ? config.passScore
        : (ids.length * config.passScore / config.totalQuestions).ceil();

    final startedAt = _now().toUtc();
    final session = ExamSessionData(
      id: _uuid.v4(),
      licenseClass: licenseClass,
      mode: mode,
      questionIds: ids,
      answers: const {},
      passScore: passScore,
      startedAt: startedAt,
      deadlineAt: startedAt.add(Duration(minutes: config.durationMinutes)),
    );

    await db.transaction(() async {
      // chỉ giữ 1 bài đang làm
      await db.delete(db.examSessions).go();
      await db
          .into(db.examSessions)
          .insert(
            ExamSessionsCompanion.insert(
              id: session.id,
              licenseClass: licenseClass,
              mode: mode,
              questionIdsJson: jsonEncode(ids),
              answersJson: jsonEncode({}),
              passScore: passScore,
              startedAt: session.startedAt,
              deadlineAt: session.deadlineAt,
              status: 'in_progress',
            ),
          );
    });
    return session;
  }

  // ---------------------------------------------------------------
  // Bài đang làm
  // ---------------------------------------------------------------

  Future<ExamSessionData?> session(String id) async {
    final row = await (db.select(
      db.examSessions,
    )..where((s) => s.id.equals(id))).getSingleOrNull();
    return row == null ? null : ExamSessionData.fromRow(row);
  }

  // Bài đang làm dở của hạng này (để hiện nút "Làm tiếp")
  Stream<ExamSessionData?> watchActive(String licenseClass) {
    return (db.select(
      db.examSessions,
    )..where((s) => s.licenseClass.equals(licenseClass))).watch().map(
      (rows) => rows.isEmpty ? null : ExamSessionData.fromRow(rows.first),
    );
  }

  // Lưu đáp án 1 câu ngay khi chọn (tắt app giữa chừng cũng không mất)
  Future<void> saveAnswer(
    String sessionId,
    String questionId,
    String key,
  ) async {
    final current = await session(sessionId);
    if (current == null) return;
    final answers = Map<String, String>.of(current.answers);
    answers[questionId] = key;
    await (db.update(db.examSessions)..where((s) => s.id.equals(sessionId)))
        .write(ExamSessionsCompanion(answersJson: Value(jsonEncode(answers))));
  }

  // Bỏ bài đang làm
  Future<void> cancel(String sessionId) async {
    await (db.delete(
      db.examSessions,
    )..where((s) => s.id.equals(sessionId))).go();
  }

  // ---------------------------------------------------------------
  // Nộp bài
  // ---------------------------------------------------------------

  // Chấm điểm, lưu vào lịch sử, ghi từng câu vào tiến độ học. Trả về id bài đã nộp.
  Future<String?> submit(String sessionId) async {
    final s = await session(sessionId);
    if (s == null) return null;

    final questions = await catalog.questionsByIds(s.questionIds);
    final items = [
      for (final q in questions)
        AttemptItem(
          questionId: q.id,
          number: q.number,
          content: q.content,
          imageRef: q.imageRef,
          options: q.options,
          correctKey: q.correctKey,
          selectedKey: s.answers[q.id],
          isCritical: q.isCritical,
          explanation: q.explanation,
        ),
    ];

    // chấm bằng hàm grade() trong domain (bỏ trống = sai, sai câu điểm liệt = trượt)
    final result = grade([
      for (final item in items)
        GradeItem(
          correctKey: item.correctKey,
          selectedKey: item.selectedKey,
          isCritical: item.isCritical,
        ),
    ], s.passScore);

    // nộp sau khi hết giờ thì thời gian làm bài tính tối đa bằng thời gian đề
    var submittedAt = _now().toUtc();
    if (submittedAt.isAfter(s.deadlineAt)) submittedAt = s.deadlineAt;
    final attemptId = _uuid.v4();

    await db.transaction(() async {
      // câu trả lời trong bài thi cũng tính vào tiến độ học (sai thì vào sổ câu sai)
      for (final q in questions) {
        await progress.recordAnswer(
          question: q,
          selectedKey: s.answers[q.id],
          responseMs: null,
          source: 'exam',
        );
      }

      await db
          .into(db.examAttempts)
          .insert(
            ExamAttemptsCompanion.insert(
              clientId: attemptId,
              licenseClass: s.licenseClass,
              mode: s.mode,
              itemsJson: jsonEncode(items.map((i) => i.toJson()).toList()),
              correctCount: result.correctCount,
              total: result.total,
              passScore: s.passScore,
              passed: result.passed,
              failedByCritical: result.failedByCritical,
              durationSec: submittedAt.difference(s.startedAt).inSeconds,
              startedAt: s.startedAt,
              submittedAt: submittedAt,
              deviceId: await db.getMeta('deviceId') ?? '',
            ),
          );
      await cancel(sessionId); // nộp xong thì xóa bài đang làm
    });
    return attemptId;
  }

  // ---------------------------------------------------------------
  // Lịch sử thi
  // ---------------------------------------------------------------

  Future<AttemptData?> attempt(String id) async {
    final row = await (db.select(
      db.examAttempts,
    )..where((a) => a.clientId.equals(id))).getSingleOrNull();
    return row == null ? null : AttemptData.fromRow(row);
  }

  // Các bài đã nộp của hạng này, bài mới nhất lên đầu
  Stream<List<AttemptData>> watchHistory(String licenseClass) {
    return (db.select(db.examAttempts)
          ..where((a) => a.licenseClass.equals(licenseClass))
          ..orderBy([
            (a) => OrderingTerm(
              expression: a.submittedAt,
              mode: OrderingMode.desc,
            ),
          ]))
        .watch()
        .map((rows) => rows.map(AttemptData.fromRow).toList());
  }
}
