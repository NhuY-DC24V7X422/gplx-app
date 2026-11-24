import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/repositories/exam_repository.dart';

// Kết quả 1 bài thi: đậu/trượt, số câu đúng, lý do trượt, bảng đúng sai từng câu
class ExamResultScreen extends ConsumerStatefulWidget {
  const ExamResultScreen({super.key, required this.attemptId});

  final String attemptId;

  @override
  ConsumerState<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends ConsumerState<ExamResultScreen> {
  AttemptData? _attempt;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final attempt = await ref
        .read(examRepositoryProvider)
        .attempt(widget.attemptId);
    if (!mounted) return;
    setState(() {
      _attempt = attempt;
      _loading = false;
    });
  }

  // 754 giây -> "12 phút 34 giây"
  String _duration(int seconds) => '${seconds ~/ 60} phút ${seconds % 60} giây';

  @override
  Widget build(BuildContext context) {
    final attempt = _attempt;
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kết quả')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (attempt == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kết quả')),
        body: const Center(child: Text('Không tìm thấy bài thi')),
      );
    }

    final color = attempt.passed ? correctGreen : wrongRed;
    final blank = attempt.items.where((i) => i.selectedKey == null).length;
    final wrong = attempt.total - attempt.correctCount - blank;

    // lý do trượt
    String? reason;
    if (attempt.failedByCritical) {
      reason = 'Bạn làm sai câu điểm liệt nên bị trượt.';
    } else if (!attempt.passed) {
      reason = 'Cần đúng ít nhất ${attempt.passScore} câu để đậu.';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ----- Đậu / trượt -----
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  attempt.passed
                      ? Icons.emoji_events
                      : Icons.sentiment_dissatisfied,
                  color: color,
                  size: 56,
                ),
                const SizedBox(height: 8),
                Text(
                  attempt.passed ? 'ĐẬU' : 'TRƯỢT',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(color: color, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Đúng ${attempt.correctCount}/${attempt.total} câu',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (reason != null) ...[
                  const SizedBox(height: 8),
                  Text(reason, textAlign: TextAlign.center),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ----- Thống kê nhanh -----
          Row(
            children: [
              _StatBox(
                label: 'Đúng',
                value: '${attempt.correctCount}',
                color: correctGreen,
              ),
              const SizedBox(width: 8),
              _StatBox(label: 'Sai', value: '$wrong', color: wrongRed),
              const SizedBox(width: 8),
              _StatBox(label: 'Bỏ trống', value: '$blank', color: Colors.grey),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Thời gian làm bài: ${_duration(attempt.durationSec)}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // ----- Bảng đúng sai từng câu -----
          Text('Từng câu', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (var i = 0; i < attempt.items.length; i++)
                _ItemDot(
                  index: i,
                  item: attempt.items[i],
                  onTap: () => context.push(
                    '/exam/review',
                    extra: ExamReviewArgs(attempt.id, i),
                  ),
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            icon: const Icon(Icons.fact_check_outlined),
            label: const Text('Xem lại bài'),
            onPressed: () => context.push(
              '/exam/review',
              extra: ExamReviewArgs(attempt.id, 0),
            ),
          ),
        ),
      ),
    );
  }
}

// Thông tin mở màn hình xem lại: id bài thi + mở ở câu thứ mấy
class ExamReviewArgs {
  const ExamReviewArgs(this.attemptId, this.startIndex);

  final String attemptId;
  final int startIndex;
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(color: color, fontWeight: FontWeight.bold),
              ),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

// Ô số câu: xanh = đúng, đỏ = sai, xám = bỏ trống. Câu điểm liệt có viền cam.
class _ItemDot extends StatelessWidget {
  const _ItemDot({
    required this.index,
    required this.item,
    required this.onTap,
  });

  final int index;
  final AttemptItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = item.selectedKey == null
        ? Colors.grey
        : item.isRight
        ? correctGreen
        : wrongRed;
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: item.isCritical
              ? Border.all(color: criticalOrange, width: 3)
              : null,
        ),
        child: Text(
          '${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
