import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../data/models/catalog_models.dart';
import '../common/empty_state.dart';
import 'practice_screen.dart';

// Danh sách câu hỏi thuộc loại nào
enum QuestionListKind {
  topic, // các câu của 1 chủ đề
  critical, // câu điểm liệt
  wrongBook, // sổ câu sai
  bookmarked, // câu đã lưu
}

// Thông tin truyền vào màn hình danh sách
class QuestionListArgs {
  const QuestionListArgs({
    required this.kind,
    required this.title,
    this.categoryCode,
  });

  final QuestionListKind kind;
  final String title; // tên hiện trên thanh tiêu đề
  final String? categoryCode; // chỉ dùng khi kind = topic
}

// Danh sách các câu kèm trạng thái (chưa làm / đúng / sai).
// Bấm vào 1 câu để luyện từ câu đó, hoặc bấm nút ở cuối để luyện cả danh sách.
class QuestionListScreen extends ConsumerWidget {
  const QuestionListScreen({super.key, required this.args});

  final QuestionListArgs args;

  // Lọc ra các câu thuộc danh sách này (đọc từ provider nên đổi dữ liệu là tự cập nhật)
  List<QuestionItem> _pick(WidgetRef ref, List<QuestionItem> all) {
    switch (args.kind) {
      case QuestionListKind.topic:
        return [
          for (final q in all)
            if (q.categoryCode == args.categoryCode) q,
        ];
      case QuestionListKind.critical:
        return [
          for (final q in all)
            if (q.isCritical) q,
        ];
      case QuestionListKind.wrongBook:
        final ids = (ref.watch(wrongBookIdsProvider).valueOrNull ?? []).toSet();
        return [
          for (final q in all)
            if (ids.contains(q.id)) q,
        ];
      case QuestionListKind.bookmarked:
        final ids = (ref.watch(bookmarkIdsProvider).valueOrNull ?? []).toSet();
        return [
          for (final q in all)
            if (ids.contains(q.id)) q,
        ];
    }
  }

  // Ghi vào lịch sử trả lời là từ đâu: 'study' | 'critical' | 'review'
  String get _source {
    switch (args.kind) {
      case QuestionListKind.critical:
        return 'critical';
      case QuestionListKind.wrongBook:
        return 'review';
      default:
        return 'study';
    }
  }

  String get _emptyMessage {
    switch (args.kind) {
      case QuestionListKind.wrongBook:
        return 'Sổ câu sai đang trống – bạn chưa trả lời sai câu nào.';
      case QuestionListKind.bookmarked:
        return 'Chưa lưu câu nào. Bấm biểu tượng lưu khi đang học.';
      default:
        return 'Danh sách này hiện chưa có câu nào.';
    }
  }

  void _practice(
    BuildContext context,
    List<QuestionItem> questions,
    int startIndex,
  ) {
    context.push(
      '/practice',
      extra: PracticeArgs(
        title: args.title,
        questionIds: [for (final q in questions) q.id],
        source: _source,
        startIndex: startIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allAsync = ref.watch(classQuestionsProvider);
    final progress = ref.watch(progressMapProvider).valueOrNull ?? {};

    final all = allAsync.valueOrNull;
    if (all == null) {
      return Scaffold(
        appBar: AppBar(title: Text(args.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final questions = _pick(ref, all);
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(args.title)),
        body: EmptyState(
          icon: Icons.inbox_outlined,
          title: 'Chưa có câu nào',
          message: _emptyMessage,
        ),
      );
    }

    final doneCount = questions.where((q) => progress[q.id] != null).length;
    final isReview = args.kind == QuestionListKind.wrongBook;

    // Sổ câu sai: ôn lại từ đầu. Các loại khác: học tiếp từ câu đầu tiên chưa làm.
    var startIndex = 0;
    if (!isReview) {
      final firstNew = questions.indexWhere((q) => progress[q.id] == null);
      if (firstNew >= 0) startIndex = firstNew;
    }

    return Scaffold(
      appBar: AppBar(title: Text(args.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Đã làm $doneCount/${questions.length} câu',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: questions.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final q = questions[index];
                return ListTile(
                  leading: _StatusIcon(progress: progress[q.id]),
                  title: Text('Câu ${q.number}'),
                  subtitle: Text(
                    q.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: q.isCritical
                      ? const Icon(
                          Icons.warning_amber_rounded,
                          color: criticalOrange,
                        )
                      : null,
                  onTap: () => _practice(context, questions, index),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton(
            onPressed: () => _practice(context, questions, startIndex),
            child: Text(isReview ? 'Ôn ngay' : 'Học tiếp'),
          ),
        ),
      ),
    );
  }
}

// Icon trạng thái của 1 câu: chưa làm (xám), đang trong sổ câu sai (đỏ), đã làm đúng (xanh)
class _StatusIcon extends StatelessWidget {
  const _StatusIcon({required this.progress});

  final ProgressRow? progress;

  @override
  Widget build(BuildContext context) {
    final p = progress;
    if (p == null) {
      return const Icon(Icons.radio_button_unchecked, color: Colors.grey);
    }
    if (p.inWrongBook) {
      return const Icon(Icons.cancel, color: wrongRed);
    }
    return const Icon(Icons.check_circle, color: correctGreen);
  }
}
