// Dự đoán khả năng đậu. Port từ gplx-api/src/domain/prediction.ts.

enum PredictionLevel { notEnoughData, notReady, nearReady, ready }

enum PredictionReason { needMoreExams, lowScore, criticalFails, lowCoverage }

// Đổi enum Dart sang chuỗi giống bên TS (vd: notEnoughData -> 'NOT_ENOUGH_DATA')
// để so sánh với test vector và gửi lên server.
String _toCode(String name) {
  return name
      .replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]}')
      .toUpperCase();
}

String predictionLevelCode(PredictionLevel level) => _toCode(level.name);
String predictionReasonCode(PredictionReason reason) => _toCode(reason.name);

class AttemptLike {
  const AttemptLike({
    required this.correctCount,
    required this.passScore,
    required this.failedByCritical,
  });

  final int correctCount;
  final int passScore;
  final bool failedByCritical;
}

class Prediction {
  const Prediction({
    required this.level,
    required this.reasons,
    required this.examsUsed,
    required this.avgRatio,
    required this.criticalFails,
    required this.coverage,
  });

  final PredictionLevel level;
  final List<PredictionReason> reasons;
  final int examsUsed;
  final double? avgRatio;
  final int criticalFails;
  final double coverage;
}

// Điểm trung bình so với điểm đậu (1.0 = vừa đủ đậu)
double _averageRatio(List<AttemptLike> attempts) {
  var total = 0.0;
  for (final a in attempts) {
    total += a.correctCount / a.passScore;
  }
  return total / attempts.length;
}

// Dự đoán từ 5 bài thi thử gần nhất.
// attempts xếp mới nhất trước. coverage là tỉ lệ câu đã học (0 đến 1).
Prediction predict(List<AttemptLike> attempts, double coverage) {
  final recent = attempts.take(5).toList();
  final count = recent.length;
  final lowCoverage = coverage < 0.9;
  final criticalFails = recent.where((a) => a.failedByCritical).length;

  // chưa thi đủ 3 bài thì chưa dự đoán được
  if (count < 3) {
    final reasons = [PredictionReason.needMoreExams];
    if (lowCoverage) reasons.add(PredictionReason.lowCoverage);
    return Prediction(
      level: PredictionLevel.notEnoughData,
      reasons: reasons,
      examsUsed: count,
      avgRatio: count > 0 ? _averageRatio(recent) : null,
      criticalFails: criticalFails,
      coverage: coverage,
    );
  }

  final avgRatio = _averageRatio(recent);
  final reasons = <PredictionReason>[];
  if (avgRatio < 1.05) reasons.add(PredictionReason.lowScore);
  if (criticalFails > 0) reasons.add(PredictionReason.criticalFails);
  if (lowCoverage) reasons.add(PredictionReason.lowCoverage);

  PredictionLevel level;
  if (avgRatio >= 1.05 && criticalFails == 0 && !lowCoverage) {
    level = PredictionLevel.ready;
  } else if (avgRatio >= 0.95 && criticalFails <= 1) {
    level = PredictionLevel.nearReady;
  } else {
    level = PredictionLevel.notReady;
  }

  return Prediction(
    level: level,
    reasons: reasons,
    examsUsed: count,
    avgRatio: avgRatio,
    criticalFails: criticalFails,
    coverage: coverage,
  );
}
