// Chấm bài thi. Port từ gplx-api/src/domain/grade.ts.

class GradeItem {
  const GradeItem({
    required this.correctKey,
    required this.selectedKey,
    required this.isCritical,
  });

  final String correctKey; // đáp án đúng
  final String? selectedKey; // đáp án người dùng chọn (null = bỏ trống)
  final bool isCritical; // câu điểm liệt

  bool get isRight => selectedKey != null && selectedKey == correctKey;
}

class GradeResult {
  const GradeResult({
    required this.correctCount,
    required this.total,
    required this.passed,
    required this.failedByCritical,
  });

  final int correctCount;
  final int total;
  final bool passed;
  final bool failedByCritical;
}

// Bỏ trống tính là sai. Sai câu điểm liệt thì trượt dù đủ điểm.
GradeResult grade(List<GradeItem> items, int passScore) {
  final correctCount = items.where((item) => item.isRight).length;
  final failedByCritical = items.any(
    (item) => item.isCritical && !item.isRight,
  );
  final passed = correctCount >= passScore && !failedByCritical;

  return GradeResult(
    correctCount: correctCount,
    total: items.length,
    passed: passed,
    failedByCritical: failedByCritical,
  );
}
