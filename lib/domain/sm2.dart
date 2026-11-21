// Thuật toán SM-2: quyết định bao lâu nữa thì ôn lại một câu hỏi.
// Port từ gplx-api/src/domain/sm2.ts.

class Sm2State {
  const Sm2State({
    required this.ef,
    required this.interval,
    required this.reps,
  });

  final double ef; // độ dễ của câu (thấp nhất 1.3)
  final int interval; // số ngày đến lần ôn kế tiếp
  final int reps; // số lần đúng liên tiếp

  // trạng thái của câu mới học lần đầu
  static const initial = Sm2State(ef: 2.5, interval: 0, reps: 0);
}

// Điểm chất lượng q: sai = 1, đúng nhanh (dưới 10 giây) = 5, đúng bình thường = 4
int qualityOf(bool isCorrect, int? responseMs) {
  if (!isCorrect) return 1;
  if (responseMs != null && responseMs < 10000) return 5;
  return 4;
}

Sm2State applySm2(Sm2State state, int q) {
  var ef = state.ef;
  var interval = state.interval;
  var reps = state.reps;

  if (q < 3) {
    // trả lời sai: học lại từ đầu, mai ôn lại
    reps = 0;
    interval = 1;
  } else {
    if (reps == 0) {
      interval = 1;
    } else if (reps == 1) {
      interval = 6;
    } else {
      interval = (interval * ef).round();
    }
    reps += 1;
  }

  ef = ef + 0.1 - (5 - q) * (0.08 + (5 - q) * 0.02);
  if (ef < 1.3) ef = 1.3;
  ef = (ef * 1e6).round() / 1e6; // làm tròn để khỏi bị lệch số lẻ

  return Sm2State(ef: ef, interval: interval, reps: reps);
}
