// Test phần thi thử: tạo đề, lưu đáp án, nộp bài, chấm điểm liệt, lịch sử.
// Dùng database trong RAM và đồng hồ giả.
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/models/catalog_models.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/exam_repository.dart';
import 'package:gplx_app/data/repositories/progress_repository.dart';
import 'package:gplx_app/domain/exam_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late CatalogRepository catalog;
  late ProgressRepository progress;
  late ExamRepository exam;
  var now = DateTime.utc(2026, 10, 20, 1);

  setUp(() async {
    now = DateTime.utc(2026, 10, 20, 1);
    db = AppDatabase(NativeDatabase.memory());
    catalog = CatalogRepository(db);
    await SyncService(catalog: catalog).ensureBundledCatalog();
    progress = ProgressRepository(db, clock: () => now);
    exam = ExamRepository(
      db,
      catalog,
      progress,
      clock: () => now,
      fixedRandom: seededRandom(42), // cố định seed để đề luôn giống nhau
    );
  });

  tearDown(() => db.close());

  // Chọn đáp án cho mọi câu trong bài: đúng hết, riêng các câu trong [wrongIds] thì chọn sai
  Future<List<QuestionItem>> answerAll(
    ExamSessionData s, {
    Set<String> wrongIds = const {},
  }) async {
    final questions = await catalog.questionsByIds(s.questionIds);
    for (final q in questions) {
      final key = wrongIds.contains(q.id)
          ? q.options.firstWhere((o) => o.key != q.correctKey).key
          : q.correctKey;
      await exam.saveAnswer(s.id, q.id, key);
    }
    return questions;
  }

  test('đề A1 có 25 câu, đúng 1 câu điểm liệt, hạn nộp sau 19 phút', () async {
    final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
    expect(s, isNotNull);
    expect(s!.questionIds.length, 25);
    expect(s.questionIds.toSet().length, 25); // không trùng câu
    expect(s.passScore, 21);
    expect(s.deadlineAt.difference(s.startedAt), const Duration(minutes: 19));

    final questions = await catalog.questionsByIds(s.questionIds);
    expect(questions.where((q) => q.isCritical).length, 1);
  });

  test('đề hạng B có 30 câu, cần đúng 27', () async {
    final s = await exam.start(licenseClass: 'B', mode: examModeMock);
    expect(s!.questionIds.length, 30);
    expect(s.passScore, 27);
  });

  test('đáp án được lưu lại, mở lại bài vẫn còn (làm tiếp bài dở)', () async {
    final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
    await exam.saveAnswer(s!.id, s.questionIds[0], '1');
    await exam.saveAnswer(s.id, s.questionIds[1], '2');
    await exam.saveAnswer(s.id, s.questionIds[0], '3'); // đổi đáp án câu 1

    final again = await exam.session(s.id);
    expect(again!.answers, {s.questionIds[0]: '3', s.questionIds[1]: '2'});

    final active = await exam.watchActive('A1').first;
    expect(active!.id, s.id);
  });

  test('tạo đề mới thì bài dở cũ bị bỏ (chỉ giữ 1 bài đang làm)', () async {
    final first = await exam.start(licenseClass: 'A1', mode: examModeMock);
    final second = await exam.start(licenseClass: 'A1', mode: examModeMock);
    expect(await exam.session(first!.id), isNull);
    expect(await exam.session(second!.id), isNotNull);
  });

  test('làm đúng hết thì đậu, nộp xong bài dở bị xóa', () async {
    final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
    await answerAll(s!);
    now = now.add(const Duration(minutes: 10));

    final id = await exam.submit(s.id);
    final attempt = await exam.attempt(id!);
    expect(attempt!.passed, isTrue);
    expect(attempt.correctCount, 25);
    expect(attempt.durationSec, 600);
    expect(await exam.session(s.id), isNull);
  });

  test('sai câu điểm liệt thì trượt dù đúng 24/25', () async {
    final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
    final questions = await catalog.questionsByIds(s!.questionIds);
    final critical = questions.firstWhere((q) => q.isCritical);
    await answerAll(s, wrongIds: {critical.id});

    final attempt = await exam.attempt((await exam.submit(s.id))!);
    expect(attempt!.correctCount, 24);
    expect(attempt.passed, isFalse);
    expect(attempt.failedByCritical, isTrue);
  });

  test('sai 5 câu thường thì trượt vì thiếu điểm (20 < 21)', () async {
    final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
    final questions = await catalog.questionsByIds(s!.questionIds);
    final normalIds = questions
        .where((q) => !q.isCritical)
        .take(5)
        .map((q) => q.id)
        .toSet();
    await answerAll(s, wrongIds: normalIds);

    final attempt = await exam.attempt((await exam.submit(s.id))!);
    expect(attempt!.correctCount, 20);
    expect(attempt.passed, isFalse);
    expect(attempt.failedByCritical, isFalse);
  });

  test(
    'hết giờ mới nộp: câu bỏ trống tính sai, thời gian tính tối đa 19 phút',
    () async {
      final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
      await exam.saveAnswer(s!.id, s.questionIds[0], '1');
      now = now.add(const Duration(minutes: 30)); // quá hạn 11 phút

      final attempt = await exam.attempt((await exam.submit(s.id))!);
      expect(attempt!.durationSec, 19 * 60);
      expect(attempt.passed, isFalse);
      expect(attempt.items.where((i) => i.selectedKey == null).length, 24);
    },
  );

  test('câu sai trong bài thi được đưa vào sổ câu sai', () async {
    final s = await exam.start(licenseClass: 'A1', mode: examModeMock);
    final wrongId = s!.questionIds[3];
    await answerAll(s, wrongIds: {wrongId});
    await exam.submit(s.id);

    final wrongBook = await progress.watchWrongBookIds('A1').first;
    expect(wrongBook, [wrongId]);
  });

  test('đề ôn câu sai: trống thì không tạo được, có câu sai thì lấy đúng các câu đó', () async {
    expect(await exam.start(licenseClass: 'A1', mode: examModeReview), isNull);

    final a1 = await catalog.questionsForClass('A1');
    for (final q in a1.take(3)) {
      final wrongKey = q.options.firstWhere((o) => o.key != q.correctKey).key;
      await progress.recordAnswer(
        question: q,
        selectedKey: wrongKey,
        responseMs: 5000,
        source: 'study',
      );
    }

    final s = await exam.start(licenseClass: 'A1', mode: examModeReview);
    expect(s!.questionIds.toSet(), a1.take(3).map((q) => q.id).toSet());
    expect(s.passScore, 3); // 3 * 21 / 25 = 2.52 -> làm tròn lên 3
  });

  test(
    'lịch sử thi: bài mới nhất lên đầu, xem lại vẫn có nội dung câu',
    () async {
      final s1 = await exam.start(licenseClass: 'A1', mode: examModeMock);
      final id1 = await exam.submit(s1!.id);
      now = now.add(const Duration(hours: 1));
      final s2 = await exam.start(licenseClass: 'A1', mode: examModeMock);
      await answerAll(s2!);
      final id2 = await exam.submit(s2.id);

      final history = await exam.watchHistory('A1').first;
      expect(history.map((a) => a.id).toList(), [id2, id1]);
      expect(history.first.items.length, 25);
      expect(history.first.items.first.content, isNotEmpty);
      expect(await exam.watchHistory('B').first, isEmpty);
    },
  );
}
