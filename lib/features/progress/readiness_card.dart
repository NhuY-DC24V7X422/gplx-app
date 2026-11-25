import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../domain/prediction.dart';

// Thẻ "Mức sẵn sàng đi thi": hiện mức đánh giá kèm lý do cụ thể.
class ReadinessCard extends StatelessWidget {
  const ReadinessCard({super.key, required this.prediction, this.footer});

  final Prediction prediction;
  final Widget? footer; // vd nút "Xem thống kê"

  String get _levelText {
    switch (prediction.level) {
      case PredictionLevel.notEnoughData:
        return 'Chưa đủ dữ liệu';
      case PredictionLevel.notReady:
        return 'Chưa sẵn sàng';
      case PredictionLevel.nearReady:
        return 'Gần sẵn sàng';
      case PredictionLevel.ready:
        return 'Sẵn sàng';
    }
  }

  Color get _levelColor {
    switch (prediction.level) {
      case PredictionLevel.notEnoughData:
        return Colors.grey;
      case PredictionLevel.notReady:
        return wrongRed;
      case PredictionLevel.nearReady:
        return criticalOrange;
      case PredictionLevel.ready:
        return correctGreen;
    }
  }

  // Đổi từng lý do thành câu dễ hiểu, kèm con số
  String _reasonText(PredictionReason reason) {
    final p = prediction;
    switch (reason) {
      case PredictionReason.needMoreExams:
        return 'Cần thi thử thêm (mới có ${p.examsUsed}/3 bài)';
      case PredictionReason.lowScore:
        // làm tròn xuống, tránh hiện "105%" khi thật ra chưa tới 105%
        final percent = ((p.avgRatio ?? 0) * 100).floor();
        return 'Điểm trung bình bằng $percent% điểm đạt, nên đạt từ 105%';
      case PredictionReason.criticalFails:
        return 'Trượt vì câu điểm liệt ${p.criticalFails}/${p.examsUsed} bài gần nhất';
      case PredictionReason.lowCoverage:
        final percent = (p.coverage * 100).floor();
        return 'Mới học $percent% số câu, nên học từ 90%';
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mức sẵn sàng đi thi', style: text.titleMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.speed, color: _levelColor),
                const SizedBox(width: 8),
                Text(
                  _levelText,
                  style: text.titleLarge?.copyWith(
                    color: _levelColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final reason in prediction.reasons)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• ${_reasonText(reason)}'),
              ),
            if (prediction.reasons.isEmpty)
              Text(
                'Điểm ${prediction.examsUsed} bài thi gần nhất ổn định, '
                'không trượt điểm liệt và đã học gần hết câu hỏi.',
              ),
            if (footer != null) ...[const SizedBox(height: 4), footer!],
          ],
        ),
      ),
    );
  }
}
