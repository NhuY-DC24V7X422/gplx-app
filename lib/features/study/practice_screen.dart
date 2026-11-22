import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../data/models/catalog_models.dart';
import '../common/answer_option.dart';
import '../common/empty_state.dart';
import '../common/question_image.dart';

// Thông tin truyền vào màn hình luyện tập
class PracticeArgs {
  const PracticeArgs({
    required this.title,
    required this.questionIds,
    required this.source,
    this.startIndex = 0,
  });

  final String title; // tên hiện trên thanh tiêu đề, vd tên chủ đề
  final List<String> questionIds; // các câu sẽ làm, theo thứ tự
  final String
  source; // 'study' | 'critical' | 'review' (ghi vào lịch sử trả lời)
  final int startIndex; // bắt đầu từ câu thứ mấy trong danh sách
}

// Luyện từng câu: chọn đáp án -> thấy ngay đúng/sai và lời giải thích -> sang câu tiếp
class PracticeScreen extends ConsumerStatefulWidget {
  const PracticeScreen({super.key, required this.args});

  final PracticeArgs args;

  @override
  ConsumerState<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends ConsumerState<PracticeScreen> {
  List<QuestionItem>? _questions; // null = đang tải
  int _index = 0;
  String? _selectedKey; // null = chưa trả lời câu hiện tại
  int _answered = 0;
  int _correct = 0;

  // đo thời gian trả lời (đúng nhanh dưới 10 giây được điểm SM-2 cao hơn)
  final _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _index = widget.args.startIndex;
    _load();
  }

  Future<void> _load() async {
    final questions = await ref
        .read(catalogRepositoryProvider)
        .questionsByIds(widget.args.questionIds);
    if (!mounted) return;
    setState(() {
      _questions = questions;
      if (_index >= questions.length) _index = 0;
    });
    _stopwatch.start();
  }

  QuestionItem get _current => _questions![_index];

  // Người học bấm chọn 1 đáp án
  Future<void> _answer(String key) async {
    if (_selectedKey != null) return; // đã trả lời rồi thì không cho chọn lại
    _stopwatch.stop();
    final question = _current;

    setState(() {
      _selectedKey = key;
      _answered++;
      if (key == question.correctKey) _correct++;
    });

    await ref
        .read(progressRepositoryProvider)
        .recordAnswer(
          question: question,
          selectedKey: key,
          responseMs: _stopwatch.elapsedMilliseconds,
          source: widget.args.source,
        );
  }

  // Bấm "Câu tiếp theo" (hoặc "Hoàn thành" ở câu cuối)
  void _next() {
    if (_index == _questions!.length - 1) {
      _showSummary();
      return;
    }
    setState(() {
      _index++;
      _selectedKey = null;
    });
    _stopwatch
      ..reset()
      ..start();
  }

  Future<void> _showSummary() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hoàn thành'),
        content: Text('Bạn đã làm $_answered câu, đúng $_correct câu.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
    if (mounted) Navigator.of(context).pop(); // quay lại tab Học
  }

  // Ô đáp án hiện màu gì
  OptionState _stateOf(QuestionOption option) {
    if (_selectedKey == null) return OptionState.idle;
    if (option.key == _current.correctKey) return OptionState.correct;
    if (option.key == _selectedKey) return OptionState.wrong;
    return OptionState.idle;
  }

  @override
  Widget build(BuildContext context) {
    final questions = _questions;

    if (questions == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.args.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.args.title)),
        body: const EmptyState(
          icon: Icons.inbox_outlined,
          title: 'Không có câu hỏi',
          message: 'Danh sách này hiện chưa có câu nào.',
        ),
      );
    }

    final question = _current;
    final answered = _selectedKey != null;
    final isLast = _index == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.args.title),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text('${_index + 1}/${questions.length}'),
            ),
          ),
        ],
        // thanh tiến độ mỏng dưới tiêu đề
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_index + 1) / questions.length,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _QuestionHeader(question: question),
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
              state: _stateOf(option),
              onTap: answered ? null : () => _answer(option.key),
            ),
          if (answered) ...[
            const SizedBox(height: 12),
            _ExplanationBox(question: question, selectedKey: _selectedKey!),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: answered ? _next : null, // chưa trả lời thì nút mờ
            child: Text(isLast ? 'Hoàn thành' : 'Câu tiếp theo'),
          ),
        ),
      ),
    );
  }
}

// Dòng trên cùng: số câu, nhãn điểm liệt, nút lưu câu
class _QuestionHeader extends ConsumerWidget {
  const _QuestionHeader({required this.question});

  final QuestionItem question;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarked =
        ref.watch(bookmarkedProvider(question.id)).valueOrNull ?? false;

    return Row(
      children: [
        Chip(label: Text('Câu ${question.number}')),
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
        const Spacer(),
        IconButton(
          tooltip: bookmarked ? 'Bỏ lưu' : 'Lưu câu này',
          icon: Icon(bookmarked ? Icons.bookmark : Icons.bookmark_outline),
          onPressed: () => ref
              .read(progressRepositoryProvider)
              .setBookmark(question.id, !bookmarked),
        ),
      ],
    );
  }
}

// Hộp kết quả sau khi trả lời: đúng/sai, đáp án đúng, giải thích, căn cứ luật
class _ExplanationBox extends StatelessWidget {
  const _ExplanationBox({required this.question, required this.selectedKey});

  final QuestionItem question;
  final String selectedKey;

  @override
  Widget build(BuildContext context) {
    final isRight = selectedKey == question.correctKey;
    final color = isRight ? correctGreen : wrongRed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isRight
                ? 'Chính xác!'
                : 'Chưa đúng – đáp án đúng là ${question.correctKey}',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          if (question.explanation != null) ...[
            const SizedBox(height: 8),
            Text(question.explanation!),
          ],
          if (question.legalRef != null) ...[
            const SizedBox(height: 8),
            Text(
              'Căn cứ: ${question.legalRef}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ],
      ),
    );
  }
}
