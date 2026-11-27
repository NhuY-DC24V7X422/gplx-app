import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/database/app_database.dart';
import '../core/notifications/reminder_service.dart';
import '../core/sync/sync_service.dart';
import '../data/models/catalog_models.dart';
import '../data/repositories/catalog_repository.dart';
import '../data/repositories/exam_repository.dart';
import '../data/repositories/progress_repository.dart';
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
  return SyncService(
    catalog: ref.watch(catalogRepositoryProvider),
    progress: ref.watch(progressRepositoryProvider),
  );
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

// ----- Tiến độ học -----

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return ProgressRepository(ref.watch(databaseProvider));
});

// Tiến độ 6 chủ đề của hạng đang chọn (đổi hạng thì tự tính lại)
final topicProgressProvider = StreamProvider<List<TopicProgress>>((ref) {
  final licenseClass = ref.watch(licenseClassProvider);
  return ref.watch(progressRepositoryProvider).watchTopicProgress(licenseClass);
});

// Id các câu trong sổ câu sai
final wrongBookIdsProvider = StreamProvider<List<String>>((ref) {
  final licenseClass = ref.watch(licenseClassProvider);
  return ref.watch(progressRepositoryProvider).watchWrongBookIds(licenseClass);
});

// Id các câu đã lưu
final bookmarkIdsProvider = StreamProvider<List<String>>((ref) {
  final licenseClass = ref.watch(licenseClassProvider);
  return ref.watch(progressRepositoryProvider).watchBookmarkIds(licenseClass);
});

// Tất cả câu hỏi của hạng đang chọn (dùng để lọc câu điểm liệt, câu theo chủ đề)
final classQuestionsProvider = FutureProvider<List<QuestionItem>>((ref) {
  final licenseClass = ref.watch(licenseClassProvider);
  return ref.watch(catalogRepositoryProvider).questionsForClass(licenseClass);
});

// Tiến độ từng câu { id câu: tiến độ }
final progressMapProvider = StreamProvider<Map<String, ProgressRow>>((ref) {
  return ref.watch(progressRepositoryProvider).watchProgressMap();
});

// Câu có đang được lưu không. family: mỗi id câu có 1 provider riêng.
final bookmarkedProvider = StreamProvider.family<bool, String>((
  ref,
  questionId,
) {
  return ref.watch(progressRepositoryProvider).watchBookmarked(questionId);
});

// ----- Thi thử -----

final examRepositoryProvider = Provider<ExamRepository>((ref) {
  return ExamRepository(
    ref.watch(databaseProvider),
    ref.watch(catalogRepositoryProvider),
    ref.watch(progressRepositoryProvider),
  );
});

// Bài thi đang làm dở của hạng đang chọn (null = không có)
final activeExamProvider = StreamProvider<ExamSessionData?>((ref) {
  final licenseClass = ref.watch(licenseClassProvider);
  return ref.watch(examRepositoryProvider).watchActive(licenseClass);
});

// Lịch sử thi của hạng đang chọn
final examHistoryProvider = StreamProvider<List<AttemptData>>((ref) {
  final licenseClass = ref.watch(licenseClassProvider);
  return ref.watch(examRepositoryProvider).watchHistory(licenseClass);
});

// ----- Tra cứu -----

final trafficSignsProvider = FutureProvider<List<TrafficSign>>((ref) {
  return ref.watch(catalogRepositoryProvider).trafficSigns();
});

final penaltiesProvider = FutureProvider<List<Penalty>>((ref) {
  return ref.watch(catalogRepositoryProvider).penalties();
});

// Id các biển đã đánh dấu "đã nhớ" ở thẻ ghi nhớ
final rememberedSignsProvider = StreamProvider<Set<String>>((ref) {
  return ref.watch(progressRepositoryProvider).watchRememberedSigns();
});
// Phiên bản bộ dữ liệu đang có trong máy (hiện ở tab Cá nhân)
final catalogVersionProvider = FutureProvider<int>((ref) {
  return ref.watch(catalogRepositoryProvider).catalogVersion();
});
// Nhắc học bằng thông báo cục bộ
final reminderServiceProvider = Provider<ReminderService>((ref) {
  return ReminderService();
});