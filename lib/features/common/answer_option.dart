import 'package:flutter/material.dart';

import '../../app/theme.dart';

// Trạng thái hiển thị của 1 đáp án
enum OptionState {
  idle, // chưa chọn
  correct, // đáp án đúng (sau khi đã trả lời)
  wrong, // đáp án người học chọn nhưng sai
}

// Một ô đáp án: số thứ tự + nội dung. Sau khi trả lời thì tô xanh / đỏ.
class AnswerOption extends StatelessWidget {
  const AnswerOption({
    super.key,
    required this.keyLabel,
    required this.text,
    required this.state,
    this.onTap,
  });

  final String keyLabel; // "1", "2", "3"...
  final String text;
  final OptionState state;
  final VoidCallback? onTap; // null = không bấm được nữa (đã trả lời)

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    // chọn màu viền, màu nền, icon theo trạng thái
    Color border = colors.outlineVariant;
    Color? background;
    IconData? icon;
    if (state == OptionState.correct) {
      border = correctGreen;
      background = correctGreen.withValues(alpha: 0.12);
      icon = Icons.check_circle;
    } else if (state == OptionState.wrong) {
      border = wrongRed;
      background = wrongRed.withValues(alpha: 0.10);
      icon = Icons.cancel;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        color: background ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: border,
            width: state == OptionState.idle ? 1 : 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: border.withValues(alpha: 0.15),
                  child: Text(
                    keyLabel,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(icon, color: border),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
