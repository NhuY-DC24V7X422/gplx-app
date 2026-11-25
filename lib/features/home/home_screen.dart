import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/dashboard_providers.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/utils/vn_date.dart';
import '../../data/repositories/settings_repository.dart';
import '../../domain/streak.dart';
import '../progress/readiness_card.dart';
import '../study/practice_screen.dart';

// Trang chủ: mở app là biết hôm nay cần làm gì.
// Gồm lộ trình hôm nay, chuỗi ngày học và mức sẵn sàng đi thi.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch: dữ liệu đổi thì màn hình tự vẽ lại
    final settings = ref.watch(settingsProvider).valueOrNull;
    final today = ref.watch(todayProvider).valueOrNull;
    final readiness = ref.watch(readinessProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ')),
      body: settings == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _SettingsCard(settings: settings),
                const SizedBox(height: 12),
                if (today != null) ...[
                  _TodayCard(today: today),
                  const SizedBox(height: 12),
                  _StreakCard(
                    streak: today.streak,
                    answeredToday: today.answeredToday,
                  ),
                  const SizedBox(height: 12),
                ],
                if (readiness != null)
                  ReadinessCard(
                    prediction: readiness,
                    footer: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () => context.push('/stats'),
                        icon: const Icon(Icons.bar_chart),
                        label: const Text('Xem thống kê'),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

// Hạng bằng, ngày thi, mục tiêu đã chọn
class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.settings});

  final AppSettings settings;

  String get _examDateText {
    final date = settings.examDate;
    if (date == null) return 'Ngày thi: chưa chọn';
    final days = diffDays(vnToday(), date);
    if (days < 0) return 'Ngày thi: ${formatDayVi(date)} (đã qua)';
    return 'Ngày thi: ${formatDayVi(date)} (còn $days ngày)';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hạng bằng: ${settings.licenseClass}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(_examDateText),
            Text('Mục tiêu: ${settings.dailyNewGoal} câu mới mỗi ngày'),
          ],
        ),
      ),
    );
  }
}

// Lộ trình hôm nay: số câu mới, số câu cần ôn và 2 nút bắt đầu
class _TodayCard extends ConsumerWidget {
  const _TodayCard({required this.today});

  final TodayData today;

  void _practice(
    BuildContext context,
    String title,
    List<String> ids,
    String source,
  ) {
    context.push(
      '/practice',
      extra: PracticeArgs(title: title, questionIds: ids, source: source),
    );
  }

  // Ngày thi đã qua thì cho chọn ngày mới ngay tại đây
  Future<void> _pickExamDate(BuildContext context, WidgetRef ref) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 14)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      helpText: 'Chọn ngày thi dự kiến',
    );
    if (picked == null) return;
    final day = picked.toIso8601String().substring(0, 10);
    await ref.read(settingsRepositoryProvider).setExamDate(day);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final plan = today.plan;
    final reviewIds = today.dueIds.take(maxReviewPerTime).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Lộ trình hôm nay', style: text.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                _NumberBox(
                  number: plan.newToday,
                  label: 'câu mới',
                  color: brandBlue,
                ),
                const SizedBox(width: 12),
                _NumberBox(
                  number: plan.reviewToday,
                  label: 'câu cần ôn',
                  color: criticalOrange,
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(
              // không còn câu mới thì nút mờ đi
              onPressed: today.newIds.isEmpty
                  ? null
                  : () => _practice(context, 'Câu mới', today.newIds, 'study'),
              child: const Text('Học câu mới'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: reviewIds.isEmpty
                  ? null
                  : () => _practice(
                      context,
                      'Ôn câu đến hạn',
                      reviewIds,
                      'review',
                    ),
              child: const Text('Ôn câu đến hạn'),
            ),
            if (plan.daysLeft != null) ...[
              const SizedBox(height: 8),
              Text(
                'Còn ${plan.daysLeft} ngày: số câu mới đã được chia đều, '
                'chừa 3 ngày cuối để ôn và thi thử.',
                style: text.bodySmall,
              ),
            ],
            if (plan.suggestMockExam)
              TextButton.icon(
                // chuyển sang tab Thi thử
                onPressed: () => context.go('/exam'),
                icon: const Icon(Icons.timer_outlined),
                label: const Text('Đến lúc thi thử rồi!'),
              ),
            if (plan.askUpdateExamDate)
              TextButton.icon(
                onPressed: () => _pickExamDate(context, ref),
                icon: const Icon(Icons.event),
                label: const Text('Ngày thi đã qua, chọn ngày mới'),
              ),
          ],
        ),
      ),
    );
  }
}

// Ô số to + chữ nhỏ bên dưới
class _NumberBox extends StatelessWidget {
  const _NumberBox({
    required this.number,
    required this.label,
    required this.color,
  });

  final int number;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              '$number',
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

// Chuỗi ngày học liên tiếp
class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streak, required this.answeredToday});

  final StreakResult streak;
  final int answeredToday;

  @override
  Widget build(BuildContext context) {
    final doneToday = answeredToday >= streakMinAnswers;

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.local_fire_department,
          size: 36,
          color: streak.current > 0 ? criticalOrange : Colors.grey,
        ),
        title: Text(
          'Chuỗi ${streak.current} ngày',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${doneToday ? 'Hôm nay đã đạt' : 'Hôm nay: $answeredToday/$streakMinAnswers câu để tính chuỗi'}\n'
          'Dài nhất: ${streak.longest} ngày',
        ),
        isThreeLine: true,
      ),
    );
  }
}
