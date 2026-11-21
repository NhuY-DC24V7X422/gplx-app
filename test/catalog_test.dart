// Test nạp gói đóng kèm vào SQLite.
// Dùng database trong RAM (NativeDatabase.memory) nên chạy nhanh, không để lại file.
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/domain/exam_generator.dart';

void main() {
  // cần để đọc được file assets trong test
  TestWidgetsFlutterBinding.ensureInitialized();
  // mỗi test tạo 1 database mới, tắt cảnh báo "mở nhiều database" của drift
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late CatalogRepository catalog;
  late SyncService sync;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    catalog = CatalogRepository(db);
    sync = SyncService(catalog: catalog);
  });

  tearDown(() => db.close());

  test('lần đầu mở app nạp được 56 câu từ gói đóng kèm', () async {
    expect(await catalog.catalogVersion(), 0); // chưa có gì

    final loaded = await sync.ensureBundledCatalog();

    expect(loaded, isTrue);
    expect(await catalog.catalogVersion(), 1);
    expect(await catalog.countQuestions(), 56);
    expect((await catalog.categories()).length, 6);
    expect((await catalog.licenseClasses()).map((l) => l.code), [
      'A1',
      'A',
      'B',
    ]);
  });

  test('mở app lần 2 thì không nạp lại', () async {
    await sync.ensureBundledCatalog();
    expect(await sync.ensureBundledCatalog(), isFalse);
    expect(await catalog.countQuestions(), 56);
  });

  test('câu hỏi đọc ra đúng dữ liệu (đáp án, ảnh, hạng bằng)', () async {
    await sync.ensureBundledCatalog();

    // câu 34 trong gói mẫu là câu có ảnh biển báo
    final q = await catalog.questionById('000000000000000000000022');
    expect(q, isNotNull);
    expect(q!.number, 34);
    expect(q.options.length, 3);
    expect(q.correctKey, '1');
    expect(q.imageRef, 'asset:images/q_34.png');
    expect(q.licenseClasses, ['A1', 'A', 'B']);
  });

  test('lọc câu theo hạng: hạng A1 không có câu chỉ dành cho hạng B', () async {
    await sync.ensureBundledCatalog();

    final a1 = await catalog.questionsForClass('A1');
    final b = await catalog.questionsForClass('B');
    expect(a1.every((q) => q.licenseClasses.contains('A1')), isTrue);
    // giống API: GET /questions?licenseClass=A1 trả 52 câu
    expect(a1.length, 52);
    expect(b.length, greaterThan(0));
  });

  test('sinh được đề thi A1 từ dữ liệu trong máy', () async {
    await sync.ensureBundledCatalog();

    final a1 = (await catalog.licenseClass('A1'))!;
    final questions = await catalog.questionsForClass('A1');
    final exam = generateExam(questions, a1.config, 'A1', seededRandom(1));

    expect(exam.questions.length, a1.config.totalQuestions); // 25 câu
    expect(
      exam.questions.where((q) => q.isCritical).length,
      greaterThanOrEqualTo(1),
    );
  });
}
