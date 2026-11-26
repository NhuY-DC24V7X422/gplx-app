// Test giao diện tab Tra cứu: tìm biển báo không dấu, xem chi tiết,
// tra mức phạt, học thẻ ghi nhớ.
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

  testWidgets('Tra cứu biển báo, mức phạt và học thẻ ghi nhớ', (tester) async {
    tester.view.physicalSize = const Size(800, 1800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final db = AppDatabase(NativeDatabase.memory());
    await SettingsRepository(db).setLicenseClass('A1');
    await SettingsRepository(db).setOnboarded(true);
    final signs = await tester.runAsync(() async {
      final catalog = CatalogRepository(db);
      await SyncService(catalog: catalog).ensureBundledCatalog();
      return catalog.trafficSigns();
    });
    final total = signs!.length;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const GplxApp(),
      ),
    );
    await pumpUntilFound(tester, 'Hạng bằng: A1');

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Tra cứu'),
      ),
    );
    await pumpUntilFound(tester, 'Thẻ ghi nhớ (đã nhớ 0/$total)');

    // 1. Gõ không dấu "nguoc chieu" -> thấy biển cấm đi ngược chiều
    await tester.enterText(find.byType(TextField), 'nguoc chieu');
    await tester.pump();
    expect(find.text('P.102'), findsOneWidget);
    expect(find.text('P.127'), findsNothing);

    // "bien cam" ra biển cấm, không ra biển chỉ dẫn
    await tester.enterText(find.byType(TextField), 'bien cam');
    await tester.pump();
    expect(find.text('P.101'), findsOneWidget);
    expect(find.text('I.401'), findsNothing);

    await tester.enterText(find.byType(TextField), 'khong co bien nay');
    await tester.pump();
    expect(find.text('Không tìm thấy biển báo'), findsOneWidget);

    // 2. Mở chi tiết 1 biển
    await tester.enterText(find.byType(TextField), 'p.102');
    await tester.pump();
    await tester.tap(find.text('P.102'));
    await tester.pumpAndSettle();
    expect(find.text('Biển P.102'), findsOneWidget);
    expect(find.text('P.102 · Biển báo cấm'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // 3. Mức phạt: tìm "den do", lọc ô tô
    await tester.tap(find.text('Mức phạt'));
    await tester.pumpAndSettle();
    await pumpUntilFound(
      tester,
      'Thông tin chỉ để tham khảo, '
      'hãy đối chiếu với văn bản pháp luật khi cần.',
    );
    await tester.enterText(find.byType(TextField), 'den do');
    await tester.pump();
    expect(find.textContaining('vượt đèn đỏ'), findsNWidgets(2));
    await tester.tap(
      find.descendant(
        of: find.byType(SegmentedButton<String>),
        matching: find.text('Ô tô'),
      ),
    );
    await tester.pump();
    expect(find.textContaining('vượt đèn đỏ'), findsOneWidget);
    expect(find.text('18.000.000 đ – 20.000.000 đ'), findsOneWidget);

    // 4. Quay lại Biển báo: vẫn còn chữ đang tìm. Mở thẻ ghi nhớ.
    await tester.tap(find.text('Biển báo'));
    await tester.pumpAndSettle();
    expect(find.text('p.102'), findsOneWidget);
    await tester.tap(find.text('Thẻ ghi nhớ (đã nhớ 0/$total)'));
    await pumpUntilFound(tester, 'Thẻ 1/$total');

    // mặt trước không lộ tên biển và chưa có nút đánh dấu
    expect(find.text(signs[0].name), findsNothing);
    expect(find.text('Đã nhớ'), findsNothing);

    await tester.tap(find.text('Lật thẻ'));
    await tester.pumpAndSettle();
    expect(find.text(signs[0].name), findsOneWidget);
    await tester.tap(find.text('Đã nhớ'));
    await pumpUntilFound(tester, 'Thẻ 2/$total');
    await pumpUntilFound(tester, 'Đã nhớ 1/$total');

    // thẻ còn lại đánh dấu "Chưa nhớ" hết
    for (var i = 1; i < total; i++) {
      await pumpUntilFound(tester, 'Thẻ ${i + 1}/$total');
      await tester.tap(find.text('Lật thẻ'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Chưa nhớ'));
      await tester.runAsync(
        () => Future.delayed(const Duration(milliseconds: 100)),
      );
      await tester.pumpAndSettle();
    }

    // 5. Hết thẻ: ôn lại thì chỉ còn các biển chưa nhớ
    await pumpUntilFound(tester, 'Đã nhớ 1/$total biển');
    await tester.tap(find.text('Ôn ${total - 1} biển chưa nhớ'));
    await pumpUntilFound(tester, 'Thẻ 1/${total - 1}');
    await tester.tap(find.byType(BackButton));
    await pumpUntilFound(tester, 'Thẻ ghi nhớ (đã nhớ 1/$total)');

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  });
}
