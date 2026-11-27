// Test tính giờ nhắc học kế tiếp (theo giờ Việt Nam)
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/notifications/reminder_service.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

void main() {
  late tz.Location vn;

  setUpAll(() {
    tz_data.initializeTimeZones();
    vn = tz.getLocation('Asia/Ho_Chi_Minh');
  });

  test('giờ nhắc chưa tới thì nhắc ngay trong hôm nay', () {
    final now = tz.TZDateTime(vn, 2026, 11, 28, 7, 30); // 7:30 sáng
    final next = nextReminderTime(now, 20, 0);
    expect(next, tz.TZDateTime(vn, 2026, 11, 28, 20, 0));
  });

  test('giờ nhắc đã qua thì sang ngày mai, kể cả qua tháng', () {
    final now = tz.TZDateTime(vn, 2026, 11, 30, 21, 0); // 21:00 ngày 30/11
    final next = nextReminderTime(now, 20, 0);
    expect(next, tz.TZDateTime(vn, 2026, 12, 1, 20, 0));
  });

  test('đúng bằng giờ nhắc thì cũng hẹn sang ngày mai', () {
    final now = tz.TZDateTime(vn, 2026, 11, 28, 20, 0);
    final next = nextReminderTime(now, 20, 0);
    expect(next, tz.TZDateTime(vn, 2026, 11, 29, 20, 0));
  });
}