import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/repositories/exam_repository.dart';
import '../common/answer_option.dart';
import '../common/question_image.dart';
import 'exam_result_screen.dart';

// Xem lại bài đã nộp: từng câu hiện đáp án đã chọn, đáp án đúng và giải thích.
// Dùng nội dung câu đã lưu lúc thi (không đọc lại bảng câu hỏi).
class ExamReviewScreen extends ConsumerStatefulWidget {
  const ExamReviewScreen({super.key, required this.args});

  final ExamReviewArgs args;

  @override
  ConsumerState<ExamReviewScreen> createState() => _ExamReviewScreenState();
}

class _ExamReviewScreenState extends ConsumerState<ExamReviewScreen> {
  AttemptData? _attempt;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.args.startIndex;
    _load();
  }

  Future<void> _load() async {
    final attempt = await ref
        .read(examRepositoryProvider)
        .attempt(widget.args.attemptId);
    if (!mounted) return;
    setState(() => _attempt = attempt);
  }

  // Ô đáp án tô màu gì
  OptionState _stateOf(AttemptItem item, String key) {
    if (key == item.correctKey) return OptionState.correct;
    if (key == item.selectedKey) return OptionState.wrong;
    return OptionState.idle;
  }

  @override
  Widget build(BuildContext context) {
    final attempt = _attempt;
    if (attempt == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Xem lại bài')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final items = attempt.items;
    final item = items[_index];

    String status;
    Color color;
    if (item.selectedKey == null) {
      status = 'Bỏ trống – đáp án đúng là ${item.correctKey}';
      color = Colors.grey;
    } else if (item.isRight) {
      status = 'Bạn trả lời đúng';
      color = correctGreen;
    } else {
      status =
          'Bạn chọn ${item.selectedKey} – đáp án đúng là ${item.correctKey}';
      color = wrongRed;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Xem lại · Câu ${_index + 1}/${items.length}'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Chip(label: Text('Câu ${item.number}')),
              const SizedBox(width: 8),
              if (item.isCritical)
                const Chip(
                  avatar: Icon(
                    Icons.warning_amber_rounded,
                    color: criticalOrange,
                    size: 18,
                  ),
                  label: Text('Điểm liệt'),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            item.content,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          QuestionImage(imageRef: item.imageRef),
          const SizedBox(height: 8),
          for (final option in item.options)
            AnswerOption(
              keyLabel: option.key,
              text: option.text,
              state: _stateOf(item, option.key),
            ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                if (item.explanation != null) ...[
                  const SizedBox(height: 8),
                  Text(item.explanation!),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _index == 0
                      ? null
                      : () => setState(() => _index--),
                  child: const Text('Câu trước'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: _index == items.length - 1
                      ? null
                      : () => setState(() => _index++),
                  child: const Text('Câu sau'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
