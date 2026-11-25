// Test giao diện: Trang chủ (lộ trình, chuỗi ngày, mức sẵn sàng),
// ôn câu đến hạn và mở màn Thống kê.
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/app/app.dart';
import 'package:gplx_app/app/providers.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/progress_repository.dart';
import 'package:gplx_app/data/repositories/settings_repository.dart';

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

  testWidgets('Trang chủ có câu đến hạn ôn, mở được màn Thống kê', (
    tester,
  ) async {
    // màn hình cao để thấy hết các thẻ, khỏi phải cuộn
    tester.view.physicalSize = const Size(800, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final db = AppDatabase(NativeDatabase.memory());
    await SettingsRepository(db).setLicenseClass('A1');
    await SettingsRepository(db).setOnboarded(true);
    final question = await tester.runAsync(() async {
      final catalog = CatalogRepository(db);
      await SyncService(catalog: catalog).ensureBundledCatalog();
      final first = (await catalog.questionsForClass('A1')).first;
      // trả lời sai 1 câu từ 3 ngày trước -> hôm nay đã đến hạn ôn
      final past = DateTime.now().subtract(const Duration(days: 3));
      await ProgressRepository(db, clock: () => past).recordAnswer(
        question: first,
        selectedKey: null,
        responseMs: null,
        source: 'study',
      );
      return first;
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const GplxApp(),
      ),
    );

    // Trang chủ: lộ trình 20 câu mới + 1 câu cần ôn
    await pumpUntilFound(tester, 'Lộ trình hôm nay');
    await pumpUntilFound(tester, 'Chưa đủ dữ liệu');
    expect(find.text('Hạng bằng: A1'), findsOneWidget);
    expect(find.text('20'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('Chuỗi 0 ngày'), findsOneWidget);
    expect(find.text('• Cần thi thử thêm (mới có 0/3 bài)'), findsOneWidget);

    // Bấm "Ôn câu đến hạn" thì mở đúng câu đã làm 3 ngày trước
    await tester.tap(find.text('Ôn câu đến hạn'));
    await pumpUntilFound(tester, 'Câu ${question!.number}');
    expect(find.text('1/1'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Mở màn Thống kê: 6 chủ đề, mỗi chủ đề 2 thanh tiến độ
    await tester.tap(find.text('Xem thống kê'));
    await pumpUntilFound(tester, 'Tiến độ theo chủ đề');
    expect(find.byType(LinearProgressIndicator), findsNWidgets(12));
    expect(
      find.text('Khái niệm và quy tắc giao thông đường bộ'),
      findsOneWidget,
    );
    expect(find.textContaining('chưa đủ 10 lần trả lời'), findsOneWidget);

    // gỡ app, cho các stream của Drift kịp hủy, rồi đóng database
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  });
}
