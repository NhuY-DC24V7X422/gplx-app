import 'package:flutter/material.dart';

// Ảnh của câu hỏi hoặc biển báo.
// imageRef dạng 'asset:images/q_34.png' -> ảnh nằm sẵn trong app (assets/catalog/images/q_34.png).
class QuestionImage extends StatelessWidget {
  const QuestionImage({super.key, required this.imageRef, this.height = 180});

  final String? imageRef;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ref = imageRef;
    if (ref == null || !ref.startsWith('asset:')) {
      return const SizedBox.shrink();
    }

    final path = 'assets/catalog/${ref.substring('asset:'.length)}';
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8),
        // nền trắng để biển báo nhìn rõ cả khi app ở chế độ tối
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          path,
          height: height,
          fit: BoxFit.contain,
          // file ảnh bị thiếu thì hiện icon thay vì báo lỗi đỏ cả màn hình
          errorBuilder: (context, error, stack) => SizedBox(
            height: height,
            child: const Center(
              child: Icon(Icons.image_not_supported_outlined, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}
