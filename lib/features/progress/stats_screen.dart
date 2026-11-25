import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/dashboard_providers.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/repositories/progress_repository.dart';
import '../../domain/weak_topics.dart';
import '../study/question_list_screen.dart';
import 'readiness_card.dart';

// Màn Thống kê: mức sẵn sàng và tiến độ từng chủ đề
class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readiness = ref.watch(readinessProvider).valueOrNull;
    final topics = ref.watch(topicProgressProvider).valueOrNull;
    final stats = ref.watch(topicStatsProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Thống kê')),
      body: topics == null || stats == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (readiness != null) ...[
                  ReadinessCard(prediction: readiness),
                  const SizedBox(height: 12),
                ],
                Text(
                  'Tiến độ theo chủ đề',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                for (final topic in topics)
                  _TopicCard(topic: topic, stat: stats[topic.code]),
              ],
            ),
    );
  }
}

// 1 chủ đề: thanh "Đã học" và thanh "Đúng". Bấm vào thì mở danh sách câu.
class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic, required this.stat});

  final TopicProgress topic;
  final TopicStat? stat;

  // Dòng chữ nhỏ dưới 2 thanh
  String get _note {
    final learned = 'Đã học ${topic.answered}/${topic.total} câu';
    if (stat?.accuracy == null) return '$learned · chưa làm';
    // làm ít hơn 10 lần thì chưa đủ để kết luận yếu hay không
    if (!stat!.enoughData) return '$learned · chưa đủ 10 lần trả lời';
    return learned;
  }

  @override
  Widget build(BuildContext context) {
    final weak = stat?.weak ?? false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        // chủ đề yếu tô nền đỏ nhạt cho dễ thấy
        color: weak ? wrongRed.withValues(alpha: 0.08) : null,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(
            '/questions',
            extra: QuestionListArgs(
              kind: QuestionListKind.topic,
              title: topic.name,
              categoryCode: topic.code,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        topic.name,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (weak)
                      const Text(
                        'Yếu',
                        style: TextStyle(
                          color: wrongRed,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    else
                      const Icon(Icons.chevron_right),
                  ],
                ),
                const SizedBox(height: 8),
                _ProgressLine(
                  label: 'Đã học',
                  value: topic.progress,
                  color: brandBlue,
                ),
                const SizedBox(height: 6),
                _ProgressLine(
                  label: 'Đúng',
                  value: stat?.accuracy,
                  color: weak ? wrongRed : correctGreen,
                ),
                const SizedBox(height: 6),
                Text(_note, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 1 dòng: nhãn, thanh ngang và số phần trăm
class _ProgressLine extends StatelessWidget {
  const _ProgressLine({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final double? value; // từ 0 đến 1, null là chưa có số liệu
  final Color color;

  @override
  Widget build(BuildContext context) {
    final percent = value == null ? '–' : '${(value! * 100).round()}%';

    return Row(
      children: [
        SizedBox(
          width: 56,
          child: Text(label, style: const TextStyle(fontSize: 12)),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: value ?? 0,
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(
          width: 44,
          child: Text(
            percent,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
