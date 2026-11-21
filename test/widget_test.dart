import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/app/app.dart';
import 'package:gplx_app/app/providers.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/data/repositories/settings_repository.dart';

// Vẽ lại từng nhịp (mỗi nhịp cho việc bất đồng bộ thật chạy 100ms)
// cho đến khi thấy chữ [text]. Dùng thay pumpAndSettle khi màn hình có
// vòng xoay chờ (vòng xoay quay mãi nên pumpAndSettle không bao giờ dừng).
Future<void> pumpUntilFound(WidgetTester tester, String text) async {
  for (var i = 0; i < 50; i++) {
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 100)),
    );
    await tester.pump();
    if (find.text(text).evaluate().isNotEmpty) return;
  }
  fail('Không thấy "$text" sau 5 giây');
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  // ----- Lưu / đọc cài đặt -----
  group('SettingsRepository', () {
    late AppDatabase db;
    late SettingsRepository settings;

    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      settings = SettingsRepository(db);
    });
    tearDown(() => db.close());

    test('mới cài app: dùng giá trị mặc định, chưa onboarded', () async {
      final s = await settings.load();
      expect(s.onboarded, isFalse);
      expect(s.licenseClass, 'A1');
      expect(s.examDate, isNull);
      expect(s.dailyNewGoal, 20);
    });

    test('lưu rồi đọc lại đúng giá trị', () async {
      await settings.setLicenseClass('B');
      await settings.setExamDate('2026-12-20');
      await settings.setDailyNewGoal(30);
      await settings.setOnboarded(true);

      final s = await settings.load();
      expect(s.onboarded, isTrue);
      expect(s.licenseClass, 'B');
      expect(s.examDate, '2026-12-20');
      expect(s.dailyNewGoal, 30);
    });

    test('bỏ chọn ngày thi thì lưu lại là null', () async {
      await settings.setExamDate('2026-12-20');
      await settings.setExamDate(null);
      expect((await settings.load()).examDate, isNull);
    });
  });

  // ----- Luồng mở app lần đầu -----
  testWidgets(
    'Splash -> Onboarding -> chọn hạng B, 30 câu -> Trang chủ -> 5 tab',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: const GplxApp(),
        ),
      );

      // Splash nạp gói câu hỏi rồi tự chuyển sang màn hình thiết lập ban đầu
      expect(find.text('GPLX Pro'), findsOneWidget);
      // chờ đến khi danh sách hạng bằng (đọc từ SQLite) hiện ra
      await pumpUntilFound(tester, 'Hạng B');

      // Màn hình thiết lập ban đầu
      expect(find.text('Chào mừng bạn!'), findsOneWidget);
      expect(find.text('Hạng B'), findsOneWidget);
      await tester.tap(find.text('Hạng B'));
      // chip nằm dưới màn hình -> cuộn tới rồi mới bấm
      await tester.ensureVisible(find.text('30 câu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('30 câu'));
      await tester.pump();

      // nút nằm cuối danh sách -> cuộn xuống cho đến khi thấy
      await tester.ensureVisible(find.text('Bắt đầu ôn thi'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bắt đầu ôn thi'));
      await pumpUntilFound(tester, 'Hạng bằng: B');

      // Trang chủ hiện đúng lựa chọn vừa lưu
      expect(find.text('Hạng bằng: B'), findsOneWidget);
      expect(find.text('Mục tiêu: 30 câu mới mỗi ngày'), findsOneWidget);
      expect(find.text('Ngày thi: chưa chọn'), findsOneWidget);

      // Chuyển được sang 4 tab còn lại
      final tabs = {
        'Học': 'Học theo chủ đề, câu điểm liệt, sổ câu sai',
        'Thi thử': 'Thi thử theo đề, xem lịch sử',
        'Tra cứu': 'Tra cứu biển báo, mức phạt',
        'Cá nhân': 'Cài đặt và thông tin ứng dụng',
      };
      for (final entry in tabs.entries) {
        await tester.tap(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(entry.key),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text(entry.value), findsOneWidget);
      }

      // dọn dẹp: gỡ app, cho các stream của Drift kịp hủy (database trong RAM tự mất khi test xong)
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 1));
    },
  );
}
