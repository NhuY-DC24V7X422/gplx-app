// Test ghi câu trả lời, sổ câu sai, tiến độ chủ đề và câu đã lưu.
// Dùng database trong RAM, và đồng hồ giả để điều khiển "hôm nay là ngày nào".
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/models/catalog_models.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/progress_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late CatalogRepository catalog;
  late ProgressRepository progress;
  late List<QuestionItem> a1Questions;

  // đồng hồ giả: 01:00 UTC = 08:00 sáng giờ Việt Nam của ngày đã đặt
  var now = DateTime.utc(2026, 10, 20, 1);

  setUp(() async {
    now = DateTime.utc(2026, 10, 20, 1);
    db = AppDatabase(NativeDatabase.memory());
    catalog = CatalogRepository(db);
    await SyncService(catalog: catalog).ensureBundledCatalog();
    progress = ProgressRepository(db, clock: () => now);
    a1Questions = await catalog.questionsForClass('A1');
  });

  tearDown(() => db.close());

  // Trả lời 1 câu vào ngày [day] của tháng 10/2026 (đúng hoặc sai)
  Future<void> answer(QuestionItem q, {required bool right, int day = 20}) {
    now = DateTime.utc(2026, 10, day, 1);
    // chọn đáp án khác đáp án đúng để cố tình trả lời sai
    final wrongKey = q.options.firstWhere((o) => o.key != q.correctKey).key;
    return progress.recordAnswer(
      question: q,
      selectedKey: right ? q.correctKey : wrongKey,
      responseMs: 15000, // chậm hơn 10 giây nên q = 4
      source: 'study',
    );
  }

  group('recordAnswer', () {
    test('trả lời sai: câu vào sổ câu sai', () async {
      final q = a1Questions.first;
      await answer(q, right: false);

      final wrongIds = await progress.watchWrongBookIds('A1').first;
      expect(wrongIds, [q.id]);
    });

    test('bỏ trống (không chọn đáp án) tính là sai', () async {
      final q = a1Questions.first;
      final state = await progress.recordAnswer(
        question: q,
        selectedKey: null,
        responseMs: null,
        source: 'study',
      );
      expect(state.wrongCount, 1);
      expect(state.inWrongBook, isTrue);
    });

    test(
      'sai rồi đúng 3 ngày liên tiếp: ra khỏi sổ câu sai, có lịch ôn',
      () async {
        final q = a1Questions.first;
        await answer(q, right: false, day: 20);
        await answer(q, right: true, day: 21);
        await answer(q, right: true, day: 22);

        // mới đúng 2 lần liên tiếp: vẫn còn trong sổ
        expect(await progress.watchWrongBookIds('A1').first, [q.id]);

        await answer(q, right: true, day: 23);

        // đúng 3 lần liên tiếp: ra khỏi sổ
        expect(await progress.watchWrongBookIds('A1').first, isEmpty);

        // SM-2: 1 ngày -> 1 ngày -> 6 ngày -> 12 ngày, hạn ôn 23/10 + 12 ngày
        final row = (await progress.watchProgressMap().first)[q.id]!;
        expect(row.correctCount, 3);
        expect(row.wrongCount, 1);
        expect(row.reps, 3);
        expect(row.interval, 12);
        expect(row.dueDate, '2026-11-04');
      },
    );

    test('trả lời 3 lần trong cùng 1 ngày: SM-2 chỉ tính 1 lần', () async {
      final q = a1Questions.first;
      await answer(q, right: true);
      await answer(q, right: true);
      await answer(q, right: true);

      final row = (await progress.watchProgressMap().first)[q.id]!;
      expect(row.correctCount, 3);
      expect(row.reps, 1);
      expect(row.dueDate, '2026-10-21');
    });

    test('mỗi lần trả lời ghi 1 dòng lịch sử, mã thiết bị không đổi', () async {
      await answer(a1Questions[0], right: true);
      await answer(a1Questions[1], right: false);

      final events = await db.select(db.answerEvents).get();
      expect(events.length, 2);
      expect(events.map((e) => e.isCorrect), [true, false]);
      expect(events.map((e) => e.source).toSet(), {'study'});
      expect(events[0].deviceId, events[1].deviceId);
      expect(events[0].clientEventId, isNot(events[1].clientEventId));
    });
  });

  group('sổ câu sai theo hạng', () {
    test('câu chỉ dành cho hạng B không hiện ở sổ câu sai hạng A1', () async {
      final onlyB = (await catalog.questionsForClass('B'))
          .firstWhere((q) => !q.licenseClasses.contains('A1'));
      await answer(onlyB, right: false);

      expect(await progress.watchWrongBookIds('A1').first, isEmpty);
      expect(await progress.watchWrongBookIds('B').first, [onlyB.id]);
    });
  });

  group('tiến độ theo chủ đề', () {
    test('chưa làm câu nào: 0 câu đã học, chưa có tỉ lệ đúng', () async {
      final topics = await progress.watchTopicProgress('A1').first;

      expect(topics.length, 6);
      expect(topics.every((t) => t.answered == 0), isTrue);
      expect(topics.every((t) => t.accuracy == null), isTrue);
      // tổng số câu 6 chủ đề cộng lại bằng số câu của hạng A1
      expect(
        topics.fold<int>(0, (sum, t) => sum + t.total),
        a1Questions.length,
      );
    });

    test('làm 2 câu (1 đúng, 1 sai) thì chủ đề đó đúng 50%', () async {
      final rules = a1Questions
          .where((q) => q.categoryCode == 'RULES')
          .toList();
      await answer(rules[0], right: true);
      await answer(rules[1], right: false);

      final topics = await progress.watchTopicProgress('A1').first;
      final t = topics.firstWhere((t) => t.code == 'RULES');
      expect(t.answered, 2);
      expect(t.correct, 1);
      expect(t.wrong, 1);
      expect(t.accuracy, 0.5);
      expect(t.progress, closeTo(2 / t.total, 1e-9));

      // chủ đề khác không bị ảnh hưởng
      final others = topics.where((t) => t.code != 'RULES');
      expect(others.every((t) => t.answered == 0), isTrue);
    });
  });

  group('câu đã lưu', () {
    test('lưu rồi bỏ lưu', () async {
      final q = a1Questions.first;
      expect(await progress.watchBookmarked(q.id).first, isFalse);

      await progress.setBookmark(q.id, true);
      expect(await progress.watchBookmarked(q.id).first, isTrue);
      expect(await progress.watchBookmarkIds('A1').first, [q.id]);

      await progress.setBookmark(q.id, false);
      expect(await progress.watchBookmarked(q.id).first, isFalse);
      expect(await progress.watchBookmarkIds('A1').first, isEmpty);
    });

    test('danh sách câu đã lưu xếp theo số câu', () async {
      final q1 = a1Questions[0];
      final q2 = a1Questions[1];
      await progress.setBookmark(q2.id, true); // lưu câu sau trước
      await progress.setBookmark(q1.id, true);

      expect(await progress.watchBookmarkIds('A1').first, [q1.id, q2.id]);
    });
  });

  group('questionsByIds', () {
    test('giữ đúng thứ tự danh sách và bỏ qua id không có', () async {
      final ids = [a1Questions[5].id, 'khong-co-cau-nay', a1Questions[2].id];
      final result = await catalog.questionsByIds(ids);

      expect(result.map((q) => q.id), [a1Questions[5].id, a1Questions[2].id]);
    });

    test('danh sách rỗng trả về rỗng', () async {
      expect(await catalog.questionsByIds([]), isEmpty);
    });
  });
}
