// Xử lý ngày theo giờ Việt Nam (UTC+7, không có giờ mùa hè).
// Viết giống hệt gplx-api/src/domain/vn-date.ts để app và server tính cùng 1 ngày.

const _vnOffset = Duration(hours: 7);

// đổi DateTime thành chuỗi 'YYYY-MM-DD'
String _format(DateTime d) {
  final y = d.year.toString().padLeft(4, '0');
  final m = d.month.toString().padLeft(2, '0');
  final day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

// đọc 'YYYY-MM-DD' thành 0 giờ UTC của ngày đó
DateTime _parseDay(String day) => DateTime.parse('${day}T00:00:00Z');

// Lấy ngày theo giờ Việt Nam, dạng 'YYYY-MM-DD'
// vd: 2026-10-20 18:00 UTC là 01:00 sáng 21/10 ở VN -> '2026-10-21'
String vnDay(DateTime time) {
  return _format(time.toUtc().add(_vnOffset));
}

// Cộng n ngày vào 'YYYY-MM-DD' (n âm thì là trừ)
String addDays(String day, int n) {
  return _format(_parseDay(day).add(Duration(days: n)));
}

// Số ngày từ a đến b (b - a)
int diffDays(String a, String b) {
  return _parseDay(b).difference(_parseDay(a)).inDays;
}
