import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/app_database.dart';
import '../core/sync/sync_service.dart';
import '../data/models/catalog_models.dart';
import '../data/repositories/catalog_repository.dart';
import '../data/repositories/settings_repository.dart';

// Riverpod "provider" = nơi tạo và cung cấp một đối tượng cho cả app.
// Màn hình lấy đối tượng bằng ref.read(...) hoặc ref.watch(...),
// không cần truyền qua constructor từ màn hình này sang màn hình khác.

// Database: tạo trong main() rồi "override" vào đây.
// Khi test thì override bằng database trong RAM.
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider phải được override trong main()');
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepository(ref.watch(databaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(catalog: ref.watch(catalogRepositoryProvider));
});

// Cài đặt hiện tại. StreamProvider: cài đặt đổi thì màn hình đang watch tự vẽ lại.
final settingsProvider = StreamProvider<AppSettings>((ref) {
  return ref.watch(settingsRepositoryProvider).watch();
});

// Hạng bằng đang chọn (chưa tải xong cài đặt thì tạm coi là A1)
final licenseClassProvider = Provider<String>((ref) {
  return ref.watch(settingsProvider).valueOrNull?.licenseClass ?? 'A1';
});

// Danh sách hạng bằng A1, A, B (đọc từ SQLite) để hiện ở màn hình chọn hạng
final licenseClassesProvider = FutureProvider<List<LicenseClassInfo>>((ref) {
  return ref.watch(catalogRepositoryProvider).licenseClasses();
});
