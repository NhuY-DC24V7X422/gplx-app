import '../core/utils/vn_date.dart';
import 'sm2.dart';

// Port từ gplx-api/src/domain/replay.ts.

// Một lần trả lời của người dùng
class ReplayEvent {
  const ReplayEvent({
    required this.clientEventId,
    required this.isCorrect,
    required this.responseMs,
    required this.answeredAt,
  });

  final String clientEventId;
  final bool isCorrect;
  final int? responseMs;
  final DateTime answeredAt;
}

// Tiến độ của một câu hỏi
class ProgressState {
  const ProgressState({
    this.correctCount = 0,
    this.wrongCount = 0,
    this.consecutiveCorrect = 0,
    this.inWrongBook = false,
    this.ef = 2.5,
    this.interval = 0,
    this.reps = 0,
    this.dueDate,
    this.lastAnsweredAt,
  });

  final int correctCount;
  final int wrongCount;
  final int consecutiveCorrect; // số lần đúng liên tiếp gần nhất
  final bool inWrongBook; // đang nằm trong sổ câu sai
  final double ef;
  final int interval;
  final int reps;
  final String? dueDate; // ngày cần ôn lại 'YYYY-MM-DD'
  final DateTime? lastAnsweredAt;
}

// Tính lại tiến độ một câu từ toàn bộ lịch sử trả lời.
// Kết quả không phụ thuộc thứ tự danh sách đầu vào vì mình tự sắp xếp theo thời gian.
// answerChangedAt: nếu admin đã đổi đáp án đúng thì bỏ các lần trả lời trước đó.
ProgressState replay(List<ReplayEvent> events, DateTime? answerChangedAt) {
  // bỏ các lần trả lời trước khi đổi đáp án
  final sorted = events
      .where(
        (e) =>
            answerChangedAt == null || !e.answeredAt.isBefore(answerChangedAt),
      )
      .toList();

  // sắp xếp theo thời gian, cùng lúc thì xếp theo id
  sorted.sort((a, b) {
    final byTime = a.answeredAt.compareTo(b.answeredAt);
    if (byTime != 0) return byTime;
    return a.clientEventId.compareTo(b.clientEventId);
  });

  var correctCount = 0;
  var wrongCount = 0;
  var consecutiveCorrect = 0;
  var inWrongBook = false;
  var sm2 = Sm2State.initial;
  String? dueDate;
  String? lastSm2Day;
  DateTime? lastAnsweredAt;

  for (final e in sorted) {
    if (e.isCorrect) {
      correctCount++;
      consecutiveCorrect++;
      // đúng 3 lần liên tiếp thì ra khỏi sổ câu sai
      if (consecutiveCorrect >= 3) inWrongBook = false;
    } else {
      wrongCount++;
      consecutiveCorrect = 0;
      inWrongBook = true;
    }

    // SM-2 chỉ tính 1 lần mỗi ngày (theo giờ VN), trả lời nhiều lần trong ngày không tính thêm
    final day = vnDay(e.answeredAt);
    if (day != lastSm2Day) {
      sm2 = applySm2(sm2, qualityOf(e.isCorrect, e.responseMs));
      dueDate = addDays(day, sm2.interval);
      lastSm2Day = day;
    }

    lastAnsweredAt = e.answeredAt;
  }

  return ProgressState(
    correctCount: correctCount,
    wrongCount: wrongCount,
    consecutiveCorrect: consecutiveCorrect,
    inWrongBook: inWrongBook,
    ef: sm2.ef,
    interval: sm2.interval,
    reps: sm2.reps,
    dueDate: dueDate,
    lastAnsweredAt: lastAnsweredAt,
  );
}
