// Test số liệu cho Trang chủ và Thống kê: số câu mỗi ngày, câu đến hạn ôn,
// lịch sử trả lời theo chủ đề. Dùng database trong RAM và đồng hồ giả.
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/models/catalog_models.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/progress_repository.dart';
import 'package:gplx_app/domain/streak.dart';
import 'package:gplx_app/domain/weak_topics.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late CatalogRepository catalog;
  late ProgressRepository progress;
  late List<QuestionItem> a1;
  var now = DateTime.utc(2026, 10, 20, 1);

  setUp(() async {
    now = DateTime.utc(2026, 10, 20, 1);
    db = AppDatabase(NativeDatabase.memory());
    catalog = CatalogRepository(db);
    await SyncService(catalog: catalog).ensureBundledCatalog();
    progress = ProgressRepository(db, clock: () => now);
    a1 = await catalog.questionsForClass('A1');
  });

  tearDown(() => db.close());

  // Trả lời 1 câu tại thời điểm [time] (giờ UTC)
  Future<void> answer(QuestionItem q, DateTime time, {bool right = true}) {
    now = time;
    final wrongKey = q.options.firstWhere((o) => o.key != q.correctKey).key;
    return progress.recordAnswer(
      question: q,
      selectedKey: right ? q.correctKey : wrongKey,
      responseMs: 15000,
      source: 'study',
    );
  }

  group('dayCounts', () {
    test('chưa trả lời câu nào thì rỗng', () async {
      expect(await progress.dayCounts(), isEmpty);
    });

    test('đếm theo ngày giờ Việt Nam', () async {
      // 16:00 UTC ngày 20 = 23:00 ngày 20 ở VN
      await answer(a1[0], DateTime.utc(2026, 10, 20, 16));
      // 18:00 UTC ngày 20 = 01:00 ngày 21 ở VN
      await answer(a1[1], DateTime.utc(2026, 10, 20, 18));
      await answer(a1[2], DateTime.utc(2026, 10, 21, 2));

      expect(await progress.dayCounts(), {'2026-10-20': 1, '2026-10-21': 2});
    });

    test('đủ 10 câu trong ngày thì được tính vào chuỗi', () async {
      for (var i = 0; i < 10; i++) {
        await answer(a1[i], DateTime.utc(2026, 10, 20, 1));
      }
      final result = computeStreak(await progress.dayCounts(), '2026-10-20');
      expect(result.current, 1);
      expect(result.longest, 1);
    });
  });

  group('dueQuestionIds', () {
    test('câu mới trả lời hôm nay thì chưa đến hạn, mai mới đến hạn', () async {
      await answer(a1[0], DateTime.utc(2026, 10, 20, 1));

      expect(await progress.dueQuestionIds('A1', '2026-10-20'), isEmpty);
      expect(await progress.dueQuestionIds('A1', '2026-10-21'), [a1[0].id]);
    });

    test('câu quá hạn lâu hơn đứng trước', () async {
      await answer(a1[0], DateTime.utc(2026, 10, 22, 1)); // hạn 23/10
      await answer(a1[1], DateTime.utc(2026, 10, 20, 1)); // hạn 21/10

      expect(await progress.dueQuestionIds('A1', '2026-10-25'), [
        a1[1].id,
        a1[0].id,
      ]);
    });

    test('không lấy câu của hạng khác', () async {
      final onlyB = (await catalog.questionsForClass('B'))
          .firstWhere((q) => !q.licenseClasses.contains('A1'));
      await answer(onlyB, DateTime.utc(2026, 10, 20, 1));

      expect(await progress.dueQuestionIds('A1', '2026-10-25'), isEmpty);
      expect(await progress.dueQuestionIds('B', '2026-10-25'), [onlyB.id]);
    });
  });

  group('topicEvents', () {
    test('mỗi lần trả lời là 1 dòng, có đúng mã chủ đề', () async {
      final q = a1.firstWhere((q) => q.categoryCode == 'SIGNS');
      await answer(q, DateTime.utc(2026, 10, 20, 1));
      await answer(q, DateTime.utc(2026, 10, 20, 2), right: false);

      final events = await progress.topicEvents('A1');
      expect(events.length, 2);
      expect(events.every((e) => e.categoryCode == 'SIGNS'), isTrue);
      expect(events.where((e) => e.isCorrect).length, 1);
    });

    test('đúng dưới 80% (đã đủ 10 lần) thì là chủ đề yếu', () async {
      final rules = a1.where((q) => q.categoryCode == 'RULES').toList();
      // 10 câu quy tắc: đúng 7, sai 3 -> 70%
      for (var i = 0; i < 10; i++) {
        await answer(rules[i], DateTime.utc(2026, 10, 20, 1), right: i < 7);
      }

      final stats = analyzeTopics(['RULES'], await progress.topicEvents('A1'));
      expect(stats['RULES']!.accuracy, 0.7);
      expect(stats['RULES']!.weak, isTrue);
    });
  });
}
