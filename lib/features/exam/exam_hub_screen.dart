import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/repositories/exam_repository.dart';

// Tab Thi thử: bài đang làm dở, chọn kiểu đề, lịch sử thi
class ExamHubScreen extends ConsumerWidget {
  const ExamHubScreen({super.key});

  // Tạo đề mới rồi mở màn hình làm bài
  Future<void> _start(BuildContext context, WidgetRef ref, String mode) async {
    final licenseClass = ref.read(licenseClassProvider);
    final active = ref.read(activeExamProvider).valueOrNull;

    // đang có bài dở thì hỏi trước khi bỏ
    if (active != null) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Bỏ bài đang làm?'),
          content: const Text(
            'Bạn đang có 1 bài thi chưa nộp. Tạo đề mới sẽ bỏ bài đó.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Thôi'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Tạo đề mới'),
            ),
          ],
        ),
      );
      if (ok != true) return;
    }

    final session = await ref
        .read(examRepositoryProvider)
        .start(licenseClass: licenseClass, mode: mode);
    if (!context.mounted) return;
    if (session == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa đủ câu hỏi để tạo đề')),
      );
      return;
    }
    context.push('/exam/run', extra: session.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final licenseClass = ref.watch(licenseClassProvider);
    final info = ref
        .watch(licenseClassesProvider)
        .valueOrNull
        ?.where((c) => c.code == licenseClass)
        .firstOrNull;
    final active = ref.watch(activeExamProvider).valueOrNull;
    final history = ref.watch(examHistoryProvider).valueOrNull ?? [];
    final wrongCount =
        (ref.watch(wrongBookIdsProvider).valueOrNull ?? []).length;

    return Scaffold(
      appBar: AppBar(title: Text('Thi thử · Hạng $licenseClass')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ----- Bài đang làm dở -----
          if (active != null) ...[
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                leading: const Icon(Icons.pending_actions),
                title: const Text('Bạn có bài thi chưa nộp'),
                subtitle: Text(
                  'Đã làm ${active.answers.length}/${active.questionIds.length} câu',
                ),
                trailing: FilledButton(
                  onPressed: () => context.push('/exam/run', extra: active.id),
                  child: const Text('Làm tiếp'),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // ----- Chọn kiểu đề -----
          Text('Chọn kiểu đề', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _ModeCard(
            icon: Icons.shuffle,
            title: 'Đề ngẫu nhiên',
            subtitle: info == null
                ? 'Đang tải...'
                : '${info.config.totalQuestions} câu · '
                      '${info.config.durationMinutes} phút · '
                      'đúng ${info.config.passScore} câu là đậu',
            onTap: () => _start(context, ref, examModeMock),
          ),
          const SizedBox(height: 8),
          _ModeCard(
            icon: Icons.error_outline,
            title: 'Đề ôn câu sai',
            subtitle: wrongCount == 0
                ? 'Sổ câu sai đang trống'
                : 'Lấy từ $wrongCount câu trong sổ câu sai',
            onTap: wrongCount == 0
                ? null
                : () => _start(context, ref, examModeReview),
          ),
          const SizedBox(height: 8),
          Text(
            'Lưu ý: sai câu điểm liệt là trượt dù đủ điểm. Hết giờ app tự nộp bài.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),

          // ----- Lịch sử thi -----
          Text('Lịch sử thi', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          if (history.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('Chưa có bài thi nào. Hãy thử 1 đề nhé!'),
            ),
          for (final attempt in history) _HistoryTile(attempt: attempt),
        ],
      ),
    );
  }
}

// Thẻ chọn kiểu đề. onTap = null thì thẻ bị mờ.
class _ModeCard extends StatelessWidget {
  const _ModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        enabled: onTap != null,
        leading: Icon(icon),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

// 1 dòng lịch sử: đậu/trượt, điểm, ngày giờ thi
class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.attempt});

  final AttemptData attempt;

  @override
  Widget build(BuildContext context) {
    final color = attempt.passed ? correctGreen : wrongRed;
    // giờ lưu dạng UTC, đổi sang giờ máy để hiển thị
    final t = attempt.submittedAt.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    final time =
        '${two(t.hour)}:${two(t.minute)} ${two(t.day)}/${two(t.month)}/${t.year}';
    final kind = attempt.mode == examModeReview
        ? 'Đề ôn câu sai'
        : 'Đề ngẫu nhiên';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        leading: Icon(
          attempt.passed ? Icons.check_circle : Icons.cancel,
          color: color,
        ),
        title: Text(
          '${attempt.passed ? 'Đậu' : 'Trượt'} · '
          '${attempt.correctCount}/${attempt.total} câu',
          style: TextStyle(color: color, fontWeight: FontWeight.w600),
        ),
        subtitle: Text('$kind · $time'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/exam/result', extra: attempt.id),
      ),
    );
  }
}
