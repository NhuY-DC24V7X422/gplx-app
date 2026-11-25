import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/vn_date.dart';
import '../data/repositories/exam_repository.dart';
import '../domain/prediction.dart';
import '../domain/streak.dart';
import '../domain/study_plan.dart';
import '../domain/weak_topics.dart';
import 'providers.dart';

// Số liệu cho Trang chủ và màn Thống kê.
// Các provider này "watch" tiến độ học, nên trả lời thêm câu là số tự cập nhật.

// Mỗi lần ôn câu đến hạn lấy tối đa 30 câu cho đỡ ngợp
const maxReviewPerTime = 30;

// Dữ liệu "hôm nay" ở Trang chủ
class TodayData {
  const TodayData({
    required this.plan,
    required this.streak,
    required this.answeredToday,
    required this.dueIds,
    required this.newIds,
  });

  final StudyPlan plan;
  final StreakResult streak;
  final int answeredToday; // hôm nay đã trả lời bao nhiêu câu
  final List<String> dueIds; // tất cả câu đến hạn ôn
  final List<String> newIds; // các câu mới nên học hôm nay
}

final todayProvider = FutureProvider<TodayData>((ref) async {
  final repo = ref.watch(progressRepositoryProvider);
  final licenseClass = ref.watch(licenseClassProvider);
  final settings = await ref.watch(settingsProvider.future);
  final progress = await ref.watch(progressMapProvider.future);
  final questions = await ref.watch(classQuestionsProvider.future);

  final today = vnToday();
  final unseen = [
    for (final q in questions)
      if (progress[q.id] == null) q.id,
  ];
  final dueIds = await repo.dueQuestionIds(licenseClass, today);
  final dayCounts = await repo.dayCounts();

  final plan = studyPlan(
    unseen: unseen.length,
    due: dueIds.length,
    examDate: settings.examDate,
    today: today,
    dailyNewGoal: settings.dailyNewGoal,
  );

  return TodayData(
    plan: plan,
    streak: computeStreak(dayCounts, today),
    answeredToday: dayCounts[today] ?? 0,
    dueIds: dueIds,
    newIds: unseen.take(plan.newToday).toList(),
  );
});

// Mức sẵn sàng đi thi: dựa trên các đề thi thử (không tính đề ôn câu sai)
// và tỉ lệ câu đã học
final readinessProvider = FutureProvider<Prediction>((ref) async {
  final history = await ref.watch(examHistoryProvider.future);
  final progress = await ref.watch(progressMapProvider.future);
  final questions = await ref.watch(classQuestionsProvider.future);

  final learned = questions.where((q) => progress[q.id] != null).length;
  final coverage = questions.isEmpty ? 0.0 : learned / questions.length;

  // history đã xếp bài mới nhất lên đầu
  final mocks = [
    for (final a in history)
      if (a.mode == examModeMock)
        AttemptLike(
          correctCount: a.correctCount,
          passScore: a.passScore,
          failedByCritical: a.failedByCritical,
        ),
  ];
  return predict(mocks, coverage);
});

// Phân tích từng chủ đề (tỉ lệ đúng 30 lần gần nhất, chủ đề yếu)
final topicStatsProvider = FutureProvider<Map<String, TopicStat>>((ref) async {
  final repo = ref.watch(progressRepositoryProvider);
  final licenseClass = ref.watch(licenseClassProvider);
  // watch để trả lời thêm câu thì tính lại
  await ref.watch(progressMapProvider.future);
  final topics = await ref.watch(topicProgressProvider.future);

  final events = await repo.topicEvents(licenseClass);
  return analyzeTopics([for (final t in topics) t.code], events);
});
