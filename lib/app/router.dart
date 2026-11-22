import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/account/account_screen.dart';
import '../features/exam/exam_hub_screen.dart';
import '../features/home/home_screen.dart';
import '../features/lookup/lookup_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/shell/home_shell.dart';
import '../features/splash/splash_screen.dart';
import '../features/study/practice_screen.dart';
import '../features/study/question_list_screen.dart';
import '../features/study/study_screen.dart';

// Key của navigator gốc. Các màn hình mở toàn màn hình (làm bài, kết quả...)
// sẽ dùng key này để che luôn thanh tab ở dưới.
final rootNavigatorKey = GlobalKey<NavigatorState>();

// Khai báo các đường dẫn trong app.
// Mở app luôn vào /splash trước, Splash tự chuyển sang /onboarding hoặc / (Trang chủ).
GoRouter buildRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      // Các màn hình toàn màn hình, không có thanh tab ở dưới
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      // danh sách câu hỏi: nhận QuestionListArgs qua `extra`
      GoRoute(
        path: '/questions',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            QuestionListScreen(args: state.extra as QuestionListArgs),
      ),
      // luyện từng câu: nhận PracticeArgs qua `extra` khi gọi context.push
      GoRoute(
        path: '/practice',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) =>
            PracticeScreen(args: state.extra as PracticeArgs),
      ),

      // StatefulShellRoute: mỗi tab là 1 nhánh, chuyển tab không mất trạng thái
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => HomeShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/study',
                builder: (context, state) => const StudyScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/exam',
                builder: (context, state) => const ExamHubScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/lookup',
                builder: (context, state) => const LookupScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                builder: (context, state) => const AccountScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
