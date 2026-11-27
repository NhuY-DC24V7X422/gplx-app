// Test giao diện tab Cá nhân: đổi hạng bằng, mục tiêu mỗi ngày.
// Chỉ dựng riêng màn Cá nhân (không chạy cả app) cho test nhanh và ổn định.
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/app/providers.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/settings_repository.dart';
import 'package:gplx_app/features/account/account_screen.dart';

// Vẽ lại từng nhịp cho đến khi thấy chữ [text] (xem giải thích ở widget_test.dart)
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

  testWidgets('Tab Cá nhân: đổi hạng bằng và mục tiêu thì lưu ngay', (
    tester,
  ) async {
    final db = AppDatabase(NativeDatabase.memory());
    final settings = SettingsRepository(db);
    await tester.runAsync(() async {
      await SyncService(catalog: CatalogRepository(db)).ensureBundledCatalog();
      await settings.setLicenseClass('A1');
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const MaterialApp(home: AccountScreen()),
      ),
    );

    // chờ cài đặt và danh sách hạng bằng nạp xong
    await pumpUntilFound(tester, 'Hạng A1');
    expect(find.text('Chưa chọn'), findsOneWidget); // chưa có ngày thi

    // bấm Hạng bằng -> bảng chọn hiện lên -> chọn Hạng B
    await tester.tap(find.text('Hạng bằng'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hạng B'));
    await tester.pumpAndSettle();
    await pumpUntilFound(tester, 'Hạng B');
    expect(find.text('Hạng A1'), findsNothing);

    // chọn mục tiêu 30 câu
    await tester.tap(find.text('30 câu'));
    await tester.pump();

    // đã lưu vào SQLite
    final saved = (await tester.runAsync(settings.load))!;
    expect(saved.licenseClass, 'B');
    expect(saved.dailyNewGoal, 30);

    // gỡ widget, cho các stream của Drift kịp hủy, rồi đóng database
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  });
}