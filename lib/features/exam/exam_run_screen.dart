import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/models/catalog_models.dart';
import '../../data/repositories/exam_repository.dart';
import '../common/answer_option.dart';
import '../common/question_image.dart';

// Màn hình làm bài thi.
// Thời gian còn lại = deadlineAt - giờ hiện tại, nên thoát app vào lại
// đồng hồ vẫn chạy đúng (giống thi thật, không dừng giờ được).
class ExamRunScreen extends ConsumerStatefulWidget {
  const ExamRunScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  ConsumerState<ExamRunScreen> createState() => _ExamRunScreenState();
}

class _ExamRunScreenState extends ConsumerState<ExamRunScreen> {
  ExamSessionData? _session;
  List<QuestionItem>? _questions; // null = đang tải
  final Map<String, String> _answers = {}; // { id câu: đáp án đã chọn }
  int _index = 0;
  Duration _remaining = Duration.zero;
  Timer? _timer;
  bool _submitting = false; // tránh nộp 2 lần

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _timer?.cancel(); // thoát màn hình thì tắt đồng hồ
    super.dispose();
  }

  Future<void> _load() async {
    final session = await ref
        .read(examRepositoryProvider)
        .session(widget.sessionId);
    if (session == null) {
      // bài đã nộp hoặc bị bỏ
      if (mounted) Navigator.of(context).pop();
      return;
    }
    final questions = await ref
        .read(catalogRepositoryProvider)
        .questionsByIds(session.questionIds);
    if (!mounted) return;

    setState(() {
      _session = session;
      _questions = questions;
      _answers.addAll(session.answers);
    });

    _tick();
    // mỗi giây tính lại thời gian còn lại 1 lần
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final left = _session!.deadlineAt.difference(DateTime.now().toUtc());
    if (left <= Duration.zero) {
      // hết giờ thì tự nộp
      _timer?.cancel();
      setState(() => _remaining = Duration.zero);
      _submit(timeUp: true);
      return;
    }
    setState(() => _remaining = left);
  }

  // Chọn đáp án: lưu ngay vào SQLite. Lúc thi được đổi đáp án, chưa hiện đúng sai.
  void _choose(String key) {
    final question = _questions![_index];
    setState(() => _answers[question.id] = key);
    ref
        .read(examRepositoryProvider)
        .saveAnswer(widget.sessionId, question.id, key);
  }

  // Bấm "Nộp bài": hỏi lại trước khi nộp
  Future<void> _confirmSubmit() async {
    final left = _questions!.length - _answers.length;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nộp bài?'),
        content: Text(
          left > 0
              ? 'Bạn còn $left câu chưa làm. Câu bỏ trống tính là sai.'
              : 'Bạn đã làm hết các câu.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Làm tiếp'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Nộp bài'),
          ),
        ],
      ),
    );
    if (ok == true) await _submit();
  }

  Future<void> _submit({bool timeUp = false}) async {
    if (_submitting) return;
    _submitting = true;
    _timer?.cancel();

    final attemptId = await ref
        .read(examRepositoryProvider)
        .submit(widget.sessionId);
    if (!mounted) return;
    if (timeUp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hết giờ, bài đã được nộp tự động')),
      );
    }
    if (attemptId == null) {
      Navigator.of(context).pop();
      return;
    }
    // thay màn hình làm bài bằng màn hình kết quả (bấm back không quay lại bài thi)
    context.pushReplacement('/exam/result', extra: attemptId);
  }

  // 125 giây -> "02:05"
  String _format(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final questions = _questions;
    if (questions == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Thi thử')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final question = questions[_index];
    final selected = _answers[question.id];
    final isLast = _index == questions.length - 1;
    // còn dưới 1 phút thì đồng hồ đổi màu đỏ
    final timeColor = _remaining.inSeconds < 60 ? wrongRed : null;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.timer_outlined, color: timeColor),
            const SizedBox(width: 6),
            Text(
              _format(_remaining),
              style: TextStyle(color: timeColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _submitting ? null : _confirmSubmit,
            child: const Text('Nộp bài'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(52),
          child: _QuestionStrip(
            count: questions.length,
            current: _index,
            isAnswered: (i) => _answers.containsKey(questions[i].id),
            onTap: (i) => setState(() => _index = i),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Chip(label: Text('Câu ${_index + 1}/${questions.length}')),
              const SizedBox(width: 8),
              if (question.isCritical)
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
            question.content,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          QuestionImage(imageRef: question.imageRef),
          const SizedBox(height: 8),
          for (final option in question.options)
            AnswerOption(
              keyLabel: option.key,
              text: option.text,
              state: option.key == selected
                  ? OptionState.selected
                  : OptionState.idle,
              onTap: () => _choose(option.key),
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
                  onPressed: isLast
                      ? _confirmSubmit
                      : () => setState(() => _index++),
                  child: Text(isLast ? 'Nộp bài' : 'Câu sau'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dãy số câu (1, 2, 3...) cuộn ngang. Câu đã làm tô màu, câu đang xem có viền đậm.
class _QuestionStrip extends StatelessWidget {
  const _QuestionStrip({
    required this.count,
    required this.current,
    required this.isAnswered,
    required this.onTap,
  });

  final int count;
  final int current;
  final bool Function(int index) isAnswered;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: count,
        separatorBuilder: (context, i) => const SizedBox(width: 6),
        itemBuilder: (context, i) {
          final answered = isAnswered(i);
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => onTap(i),
            child: Container(
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: answered ? colors.primary : null,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: i == current ? colors.onSurface : colors.outline,
                  width: i == current ? 2 : 1,
                ),
              ),
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  color: answered ? colors.onPrimary : null,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
