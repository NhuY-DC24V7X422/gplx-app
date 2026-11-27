import '../../core/database/app_database.dart';

// Các lựa chọn của người học, lưu trong bảng meta của SQLite (không cần mạng).
class AppSettings {
  const AppSettings({
    required this.onboarded,
    required this.licenseClass,
    required this.examDate,
    required this.dailyNewGoal,
    required this.reminderTime,
  });

  final bool onboarded; // đã qua màn hình thiết lập ban đầu chưa
  final String licenseClass; // 'A1' | 'A' | 'B'
  final String? examDate; // ngày thi 'YYYY-MM-DD', null = chưa chọn
  final int dailyNewGoal; // số câu mới muốn học mỗi ngày (khi chưa có ngày thi)
  final String? reminderTime; // giờ nhắc học 'HH:mm', null = tắt nhắc học

  // giá trị mặc định khi mới cài app
  static const defaults = AppSettings(
    onboarded: false,
    licenseClass: 'A1',
    examDate: null,
    dailyNewGoal: 20,
    reminderTime: null, // thời gian nhắc học, null = chưa chọn
  );
}

class SettingsRepository {
  SettingsRepository(this.db);

  final AppDatabase db;

  // các key trong bảng meta mà màn hình cài đặt dùng
  static const _keys = [
    'onboarded',
    'licenseClass',
    'examDate',
    'dailyNewGoal',
    'reminderTime',
  ];

  // đọc 1 lần
  Future<AppSettings> load() async {
    final rows = await (db.select(
      db.meta,
    )..where((m) => m.key.isIn(_keys))).get();
    return _parse(rows);
  }

  // "theo dõi": mỗi lần bảng meta đổi thì phát ra cài đặt mới,
  // nhờ vậy màn hình tự cập nhật (vd: đổi hạng thì Trang chủ đổi theo)
  Stream<AppSettings> watch() {
    return (db.select(
      db.meta,
    )..where((m) => m.key.isIn(_keys))).watch().map(_parse);
  }

  // đổi các dòng key-value thành object AppSettings
  AppSettings _parse(List<MetaRow> rows) {
    final m = {for (final r in rows) r.key: r.value};
    const d = AppSettings.defaults;
    return AppSettings(
      onboarded: m['onboarded'] == '1',
      licenseClass: m['licenseClass'] ?? d.licenseClass,
      examDate: m['examDate'],
      dailyNewGoal: int.tryParse(m['dailyNewGoal'] ?? '') ?? d.dailyNewGoal,
      reminderTime: m['reminderTime'],
    );
  }

  Future<void> setOnboarded(bool value) =>
      db.setMeta('onboarded', value ? '1' : '0');

  Future<void> setLicenseClass(String value) =>
      db.setMeta('licenseClass', value);

  // null = xóa ngày thi
  Future<void> setExamDate(String? value) => db.setMeta('examDate', value);

  Future<void> setDailyNewGoal(int value) =>
      db.setMeta('dailyNewGoal', '$value');


    // null = tắt nhắc học
  Future<void> setReminderTime(String? value) =>
      db.setMeta('reminderTime', value);
}
