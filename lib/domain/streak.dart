import '../core/utils/vn_date.dart';

// Chuỗi ngày học liên tiếp. Port từ gplx-api/src/domain/streak.ts.

// Một ngày chỉ được tính vào chuỗi khi trả lời ít nhất 10 câu
const streakMinAnswers = 10;

class StreakResult {
  const StreakResult({required this.current, required this.longest});

  final int current; // chuỗi hiện tại
  final int longest; // chuỗi dài nhất từ trước tới nay
}

// dayCounts: số câu đã trả lời mỗi ngày
StreakResult computeStreak(Map<String, int> dayCounts, String today) {
  // gom các ngày đủ số câu
  final days = <String>{};
  dayCounts.forEach((day, count) {
    if (count >= streakMinAnswers) days.add(day);
  });

  // chuỗi hiện tại: đếm lùi từ hôm nay (hôm nay chưa học thì bắt đầu từ hôm qua)
  var cursor = days.contains(today) ? today : addDays(today, -1);
  var current = 0;
  while (days.contains(cursor)) {
    current++;
    cursor = addDays(cursor, -1);
  }

  // chuỗi dài nhất: chỉ đếm từ ngày đầu của mỗi chuỗi
  var longest = 0;
  for (final day in days) {
    if (days.contains(addDays(day, -1))) continue; // không phải ngày đầu chuỗi
    var length = 1;
    while (days.contains(addDays(day, length))) {
      length++;
    }
    if (length > longest) longest = length;
  }

  return StreakResult(current: current, longest: longest);
}
