// Test phần Tra cứu: tìm kiếm không dấu, định dạng tiền,
// đọc biển báo / mức phạt từ gói đóng kèm, lưu biển "đã nhớ".
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/core/utils/format_money.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/progress_repository.dart';
import 'package:gplx_app/domain/search.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('matchesSearch', () {
    const text = 'Biển báo cấm P.102 Cấm đi ngược chiều';

    test('gõ không dấu, viết hoa thường đều được', () {
      expect(matchesSearch(text, 'bien bao cam'), isTrue);
      expect(matchesSearch(text, 'Ngược Chiều'), isTrue);
      expect(matchesSearch(text, 'p.102'), isTrue);
    });

    test('các từ không cần nằm liền nhau', () {
      expect(matchesSearch(text, 'bien cam'), isTrue);
    });

    test('thiếu 1 từ thì không khớp', () {
      expect(matchesSearch(text, 'cam re trai'), isFalse);
    });

    test('ô tìm kiếm trống thì khớp tất cả', () {
      expect(matchesSearch(text, '   '), isTrue);
    });
  });

  test('formatMoney thêm dấu chấm hàng nghìn', () {
    expect(formatMoney(500), '500 đ');
    expect(formatMoney(400000), '400.000 đ');
    expect(formatMoney(18000000), '18.000.000 đ');
  });

  group('dữ liệu tra cứu', () {
    late AppDatabase db;

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      await SyncService(catalog: CatalogRepository(db)).ensureBundledCatalog();
    });

    tearDown(() => db.close());

    test('đọc được biển báo (xếp theo mã) và mức phạt', () async {
      final signs = await CatalogRepository(db).trafficSigns();
      final codes = signs.map((s) => s.code).toList();
      expect(codes, isNotEmpty);
      expect(codes, [...codes]..sort());
      expect(signs.every((s) => s.localImagePath != null), isTrue);

      final penalties = await CatalogRepository(db).penalties();
      final redLight = penalties.where(
        (p) => matchesSearch(p.searchText, 'den do'),
      );
      expect(redLight.map((p) => p.vehicleType), ['MOTORBIKE', 'CAR']);
    });

    test('đánh dấu và bỏ đánh dấu biển đã nhớ', () async {
      final repo = ProgressRepository(db);
      expect(await repo.watchRememberedSigns().first, isEmpty);

      await repo.setSignRemembered('a', true);
      await repo.setSignRemembered('a', true); // bấm 2 lần không bị trùng
      await repo.setSignRemembered('b', true);
      expect(await repo.watchRememberedSigns().first, {'a', 'b'});

      await repo.setSignRemembered('a', false);
      expect(await repo.watchRememberedSigns().first, {'b'});
    });

    test('xóa dữ liệu cá nhân thì xóa cả biển đã nhớ', () async {
      final repo = ProgressRepository(db);
      await repo.setSignRemembered('a', true);
      await db.clearPersonalData();
      expect(await repo.watchRememberedSigns().first, isEmpty);
    });
  });
}
