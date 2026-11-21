// Tìm chủ đề yếu. Port từ gplx-api/src/domain/weak-topics.ts.

class TopicEvent {
  const TopicEvent({
    required this.categoryCode,
    required this.isCorrect,
    required this.answeredAt,
  });

  final String categoryCode;
  final bool isCorrect;
  final DateTime answeredAt;
}

class TopicStat {
  const TopicStat({
    required this.answered,
    required this.accuracy,
    required this.enoughData,
    required this.weight,
    required this.weak,
  });

  final int answered; // số câu đã tính (tối đa 30 gần nhất)
  final double? accuracy; // tỉ lệ đúng, null nếu chưa trả lời câu nào
  final bool enoughData;
  // trọng số khi chọn câu cho đề ôn: chủ đề càng yếu càng cao
  final double weight;
  final bool weak;
}

const _window = 30; // chỉ xét 30 câu gần nhất của mỗi chủ đề
const _minAnswers = 10; // ít hơn 10 câu thì chưa đủ để kết luận
const _weakBelow = 0.8; // đúng dưới 80% là yếu

double _round(double x) => (x * 1e6).round() / 1e6;

// Phân tích từng chủ đề xem chủ đề nào yếu
Map<String, TopicStat> analyzeTopics(
  List<String> categories,
  List<TopicEvent> events,
) {
  final result = <String, TopicStat>{};

  for (final category in categories) {
    // lấy các câu gần nhất của chủ đề này (mới nhất trước)
    final recent = events.where((e) => e.categoryCode == category).toList()
      ..sort((a, b) => b.answeredAt.compareTo(a.answeredAt));
    final window = recent.take(_window).toList();

    final answered = window.length;
    final correct = window.where((e) => e.isCorrect).length;
    final accuracy = answered > 0 ? _round(correct / answered) : null;
    final enoughData = answered >= _minAnswers;

    var weight = 1.0;
    if (enoughData && accuracy != null) weight = _round(1 - accuracy + 0.1);

    final weak = enoughData && accuracy != null && accuracy < _weakBelow;
    result[category] = TopicStat(
      answered: answered,
      accuracy: accuracy,
      enoughData: enoughData,
      weight: weight,
      weak: weak,
    );
  }

  return result;
}
