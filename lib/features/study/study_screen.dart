import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/repositories/progress_repository.dart';
import 'practice_screen.dart';
import 'question_list_screen.dart';

// Tab Học: 3 lối tắt (câu điểm liệt, sổ câu sai, câu đã lưu) + danh sách 6 chủ đề
class StudyScreen extends ConsumerWidget {
  const StudyScreen({super.key});

  // Mở danh sách câu hỏi (kèm trạng thái từng câu)
  void _openList(
    BuildContext context,
    QuestionListKind kind,
    String title, {
    String? categoryCode,
  }) {
    context.push(
      '/questions',
      extra: QuestionListArgs(
        kind: kind,
        title: title,
        categoryCode: categoryCode,
      ),
    );
  }

  // Mở thẳng màn hình luyện tập. Danh sách trống thì báo bằng SnackBar.
  void _open(
    BuildContext context, {
    required String title,
    required List<String> ids,
    required String source,
    int startIndex = 0,
  }) {
    if (ids.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chủ đề này chưa có câu nào')),
      );
      return;
    }
    context.push(
      '/practice',
      extra: PracticeArgs(
        title: title,
        questionIds: ids,
        source: source,
        startIndex: startIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licenseClass = ref.watch(licenseClassProvider);
    final questions = ref.watch(classQuestionsProvider).valueOrNull ?? [];
    final progress = ref.watch(progressMapProvider).valueOrNull ?? {};
    final topics = ref.watch(topicProgressProvider).valueOrNull ?? [];
    final wrongIds = ref.watch(wrongBookIdsProvider).valueOrNull ?? [];
    final bookmarkIds = ref.watch(bookmarkIdsProvider).valueOrNull ?? [];

    final criticalIds = [
      for (final q in questions)
        if (q.isCritical) q.id,
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Học · Hạng $licenseClass')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ----- 3 lối tắt -----
          Row(
            children: [
              _ShortcutCard(
                icon: Icons.warning_amber_rounded,
                color: criticalOrange,
                label: 'Câu điểm liệt',
                count: criticalIds.length,
                onTap: () => _openList(
                  context,
                  QuestionListKind.critical,
                  'Câu điểm liệt',
                ),
              ),
              const SizedBox(width: 8),
              _ShortcutCard(
                icon: Icons.error_outline,
                color: wrongRed,
                label: 'Sổ câu sai',
                count: wrongIds.length,
                onTap: () => _openList(
                  context,
                  QuestionListKind.wrongBook,
                  'Sổ câu sai',
                ),
              ),
              const SizedBox(width: 8),
              _ShortcutCard(
                icon: Icons.bookmark_outline,
                color: brandBlue,
                label: 'Câu đã lưu',
                count: bookmarkIds.length,
                onTap: () => _openList(
                  context,
                  QuestionListKind.bookmarked,
                  'Câu đã lưu',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ----- Danh sách chủ đề -----
          Text(
            'Học theo chủ đề',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final topic in topics)
            _TopicCard(
              topic: topic,
              // icon danh sách: xem từng câu của chủ đề, bấm vào để làm từ câu đó
              onList: () => _openList(
                context,
                QuestionListKind.topic,
                topic.name,
                categoryCode: topic.code,
              ),
              onTap: () {
                final ids = [
                  for (final q in questions)
                    if (q.categoryCode == topic.code) q.id,
                ];
                // bắt đầu từ câu đầu tiên chưa học (học hết rồi thì từ câu 1)
                final firstNew = ids.indexWhere((id) => progress[id] == null);
                _open(
                  context,
                  title: topic.name,
                  ids: ids,
                  source: 'study',
                  startIndex: firstNew < 0 ? 0 : firstNew,
                );
              },
            ),
        ],
      ),
    );
  }
}

// Ô lối tắt: icon, số lượng, tên
class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String label;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior:
            Clip.antiAlias, // để hiệu ứng bấm không tràn ra ngoài góc bo
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 8),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(label, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Thẻ 1 chủ đề: tên, số câu đã học / tổng, tỉ lệ đúng, thanh tiến độ
class _TopicCard extends StatelessWidget {
  const _TopicCard({
    required this.topic,
    required this.onTap,
    required this.onList,
  });

  final TopicProgress topic;
  final VoidCallback onTap; // bấm thẻ: làm tiếp từ câu chưa học
  final VoidCallback onList; // bấm icon danh sách: xem các câu

  @override
  Widget build(BuildContext context) {
    final accuracy = topic.accuracy;
    final accuracyText = accuracy == null
        ? 'chưa làm'
        : 'đúng ${(accuracy * 100).round()}%';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 6, 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${topic.answered}/${topic.total} câu · $accuracyText',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: topic.progress,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Xem danh sách câu',
                  icon: const Icon(Icons.format_list_bulleted),
                  onPressed: onList,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
