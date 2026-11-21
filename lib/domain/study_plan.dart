import 'dart:math';

import '../core/utils/vn_date.dart';

// Lộ trình học hôm nay. Port từ gplx-api/src/domain/study-plan.ts.

class StudyPlan {
  const StudyPlan({
    required this.daysLeft,
    required this.newToday,
    required this.reviewToday,
    required this.suggestMockExam,
    required this.askUpdateExamDate,
  });

  final int? daysLeft;
  final int newToday; // hôm nay học bao nhiêu câu mới
  final int reviewToday; // hôm nay ôn bao nhiêu câu
  final bool suggestMockExam; // gợi ý thi thử
  final bool askUpdateExamDate; // hỏi người dùng cập nhật ngày thi
}

StudyPlan studyPlan({
  required int unseen, // số câu chưa học
  required int due, // số câu đến hạn ôn lại
  required String? examDate, // ngày thi 'YYYY-MM-DD'
  required String today,
  required int dailyNewGoal, // mục tiêu học bao nhiêu câu mới mỗi ngày
}) {
  final reviewToday = due;

  // chưa đặt ngày thi, hoặc ngày thi đã qua: học theo mục tiêu mỗi ngày
  if (examDate == null || diffDays(today, examDate) < 0) {
    return StudyPlan(
      daysLeft: null,
      newToday: min(dailyNewGoal, unseen),
      reviewToday: reviewToday,
      suggestMockExam: unseen == 0,
      askUpdateExamDate: examDate != null,
    );
  }

  // có ngày thi: chia đều số câu chưa học cho các ngày còn lại (chừa 3 ngày cuối để ôn)
  final daysLeft = max(1, diffDays(today, examDate));
  final studyDays = max(1, daysLeft - 3);
  final newToday = min(unseen, (unseen / studyDays).ceil());

  return StudyPlan(
    daysLeft: daysLeft,
    newToday: newToday,
    reviewToday: reviewToday,
    suggestMockExam: daysLeft <= 7 || unseen == 0,
    askUpdateExamDate: false,
  );
}
