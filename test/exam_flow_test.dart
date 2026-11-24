// Test luồng thi thử trên giao diện: tạo đề, thoát ra rồi làm tiếp, nộp bài, xem kết quả, lịch sử.
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
import 'package:gplx_app/data/repositories/exam_repository.dart';
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
  final shown = tester
      .widgetList<Text>(find.byType(Text))
      .map((t) => t.data)
      .whereType<String>()
      .take(15)
      .toList();
  fail('Không thấy "$text" sau 5 giây. Đang hiện: $shown');
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('Thi thử: tạo đề, làm tiếp bài dở, nộp bài, xem kết quả', (
    tester,
  ) async {
    tester.platformDispatcher.defaultRouteNameTestValue = '/';
    addTearDown(tester.platformDispatcher.clearDefaultRouteNameTestValue);

    final db = AppDatabase(NativeDatabase.memory());
    await SettingsRepository(db).setLicenseClass('A1');
    await SettingsRepository(db).setOnboarded(true);
    await tester.runAsync(
      () => SyncService(catalog: CatalogRepository(db)).ensureBundledCatalog(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const GplxApp(),
      ),
    );
    await pumpUntilFound(tester, 'Hạng bằng: A1');

    // 1. Sang tab Thi thử: chưa có lịch sử, đề ôn câu sai bị khóa vì sổ câu sai trống
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Thi thử'),
      ),
    );
    await pumpUntilFound(tester, 'Đề ngẫu nhiên');
    await pumpUntilFound(tester, '25 câu · 19 phút · đúng 21 câu là đậu');
    expect(find.text('Sổ câu sai đang trống'), findsOneWidget);
    expect(find.text('Chưa có bài thi nào. Hãy thử 1 đề nhé!'), findsOneWidget);

    // 2. Tạo đề -> màn hình làm bài có đồng hồ và nút nộp bài
    await tester.tap(find.text('Đề ngẫu nhiên'));
    await pumpUntilFound(tester, 'Câu sau');
    expect(find.text('Câu 1/25'), findsOneWidget);
    expect(find.textContaining(RegExp(r'^1[89]:\d\d$')), findsOneWidget);

    // chọn đúng đáp án câu 1
    final session = await tester.runAsync(
      () => ExamRepository(
        db,
        CatalogRepository(db),
        ProgressRepository(db),
      ).watchActive('A1').first,
    );
    final first = await tester.runAsync(
      () => CatalogRepository(db).questionById(session!.questionIds.first),
    );
    final rightText = first!.options
        .firstWhere((o) => o.key == first.correctKey)
        .text;
    await tester.tap(find.text(rightText));
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 300)),
    );
    await tester.pump();

    // 3. Thoát ra giữa chừng -> tab Thi thử hiện bài chưa nộp, bấm "Làm tiếp"
    await tester.tap(find.byType(BackButton));
    await pumpUntilFound(tester, 'Làm tiếp');
    expect(find.text('Đã làm 1/25 câu'), findsOneWidget);
    await tester.tap(find.text('Làm tiếp'));
    await pumpUntilFound(tester, 'Câu sau');

    // 4. Nộp bài (hỏi lại vì còn 24 câu chưa làm)
    await tester.tap(find.widgetWithText(TextButton, 'Nộp bài'));
    await tester.pump();
    expect(find.textContaining('còn 24 câu chưa làm'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Nộp bài'));
    await pumpUntilFound(tester, 'TRƯỢT');
    expect(find.text('Đúng 1/25 câu'), findsOneWidget);
    // câu điểm liệt bị bỏ trống nên lý do trượt là điểm liệt
    expect(
      find.text('Bạn làm sai câu điểm liệt nên bị trượt.'),
      findsOneWidget,
    );

    // 5. Xem lại câu 1: thấy "Bạn trả lời đúng"
    await tester.tap(find.text('Xem lại bài'));
    await pumpUntilFound(tester, 'Bạn trả lời đúng');
    expect(find.text('Xem lại · Câu 1/25'), findsOneWidget);

    // 6. Quay về tab Thi thử: có 1 dòng lịch sử, không còn bài dở
    await tester.tap(find.byType(BackButton));
    await pumpUntilFound(tester, 'TRƯỢT');
    await tester.tap(find.byType(BackButton));
    await pumpUntilFound(tester, 'Trượt · 1/25 câu');
    expect(find.text('Làm tiếp'), findsNothing);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  });
}
