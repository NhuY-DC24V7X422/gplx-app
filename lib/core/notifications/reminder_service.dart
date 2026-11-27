import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

// Lần nhắc kế tiếp: hôm nay lúc hour:minute, nếu giờ đó đã qua thì sang ngày mai.
// Tách thành hàm riêng để viết test được (không cần điện thoại).
tz.TZDateTime nextReminderTime(tz.TZDateTime now, int hour, int minute) {
  var next = tz.TZDateTime(
    now.location,
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  if (!next.isAfter(now)) next = next.add(const Duration(days: 1));
  return next;
}

// Nhắc học mỗi ngày bằng thông báo cục bộ:
// chính điện thoại hẹn giờ và hiện thông báo nên không cần mạng.
class ReminderService {
  ReminderService([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;

  static const _id = 1; // app chỉ có 1 lịch nhắc nên dùng 1 mã cố định
  bool _ready = false;

  // Chuẩn bị 1 lần: nạp dữ liệu múi giờ, đặt giờ Việt Nam, khởi tạo thư viện
  Future<void> _init() async {
    if (_ready) return;
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    _ready = true;
  }

  // Bật nhắc học lúc hour:minute mỗi ngày.
  // Trả về false nếu người dùng không cho phép hiện thông báo.
  Future<bool> turnOn(int hour, int minute) async {
    await _init();

    // Android 13 trở lên phải xin quyền hiện thông báo
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final allowed = await android?.requestNotificationsPermission() ?? true;
    if (!allowed) return false;

    await _plugin.cancel(id: _id); // xóa lịch cũ (nếu có) rồi đặt lịch mới
    await _plugin.zonedSchedule(
      id: _id,
      title: 'Đến giờ ôn thi rồi!',
      body: 'Vào học vài câu để giữ chuỗi ngày học nhé.',
      scheduledDate: nextReminderTime(
        tz.TZDateTime.now(tz.local),
        hour,
        minute,
      ),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder',
          'Nhắc học hằng ngày',
          channelDescription: 'Thông báo nhắc ôn thi vào giờ bạn chọn',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      // nhắc đúng giờ, kể cả khi máy đang ở chế độ nghỉ
      // (cần quyền USE_EXACT_ALARM khai báo trong AndroidManifest.xml)
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // chỉ so giờ và phút -> lặp lại mỗi ngày
      matchDateTimeComponents: DateTimeComponents.time,
    );
    return true;
  }

  // Tắt nhắc học
  Future<void> turnOff() async {
    await _init();
    await _plugin.cancel(id: _id);
  }
}