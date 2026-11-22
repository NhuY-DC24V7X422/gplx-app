// Test luồng học trên giao diện (tab Học, danh sách câu, luyện từng câu, sổ câu sai).
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/app/app.dart';
import 'package:gplx_app/app/providers.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/models/catalog_models.dart';
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
  // báo lỗi kèm các chữ đang hiện trên màn hình để biết app đang ở đâu
  final shown = tester
      .widgetList<Text>(find.byType(Text))
      .map((t) => t.data)
      .whereType<String>()
      .take(15)
      .toList();
  fail('Không thấy "$text" sau 5 giây. Đang hiện: $shown');
}

const rulesTopic = 'Khái niệm và quy tắc giao thông đường bộ';

// Mở app (đã qua màn hình thiết lập, hạng A1), sang tab Học, chờ thấy danh sách chủ đề.
Future<AppDatabase> openStudyTab(WidgetTester tester) async {
  // đặt lại trang mặc định, không để test trước làm app mở sai màn hình
  tester.platformDispatcher.defaultRouteNameTestValue = '/';
  addTearDown(tester.platformDispatcher.clearDefaultRouteNameTestValue);

  final db = AppDatabase(NativeDatabase.memory());
  await SettingsRepository(db).setLicenseClass('A1');
  await SettingsRepository(db).setOnboarded(true);
  // nạp sẵn gói câu hỏi (trong runAsync) để Splash không phải nạp lúc đang chạy test
  await tester.runAsync(
    () => SyncService(catalog: CatalogRepository(db)).ensureBundledCatalog(),
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const GplxApp(),
    ),
  );
  await pumpUntilFound(tester, 'Hạng bằng: A1'); // đã vào Trang chủ

  await tester.tap(
    find.descendant(of: find.byType(NavigationBar), matching: find.text('Học')),
  );
  await pumpUntilFound(tester, rulesTopic);
  return db;
}

// Gỡ app, cho các stream của Drift kịp hủy, rồi đóng database
Future<void> closeApp(WidgetTester tester, AppDatabase db) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 1));
  await tester.runAsync(db.close);
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('Học theo chủ đề: trả lời sai thì vào sổ câu sai', (
    tester,
  ) async {
    final db = await openStudyTab(tester);

    // Câu đầu tiên của chủ đề RULES và 1 đáp án sai của câu đó
    final a1 = await tester.runAsync(
      () => CatalogRepository(db).questionsForClass('A1'),
    );
    final question = a1!.firstWhere((q) => q.categoryCode == 'RULES');
    final wrongOption = question.options.firstWhere(
      (o) => o.key != question.correctKey,
    );

    // 1. Tab Học có 3 lối tắt và danh sách chủ đề
    expect(find.text('Câu điểm liệt'), findsOneWidget);
    expect(find.text('Sổ câu sai'), findsOneWidget);
    expect(find.text('Câu đã lưu'), findsOneWidget);
    expect(find.text('Học theo chủ đề'), findsOneWidget);

    // 2. Bấm chủ đề -> vào luyện tập ngay, nút "Câu tiếp theo" còn mờ
    await tester.tap(find.text(rulesTopic));
    await pumpUntilFound(tester, 'Câu tiếp theo');
    expect(find.text('Câu ${question.number}'), findsOneWidget);
    expect(find.text(question.content), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );

    // 3. Chọn đáp án sai -> hiện "Chưa đúng" và đáp án đúng, nút "Câu tiếp theo" bấm được
    await tester.tap(find.text(wrongOption.text));
    await pumpUntilFound(
      tester,
      'Chưa đúng – đáp án đúng là ${question.correctKey}',
    );
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );

    // 4. Lịch sử đã ghi, câu nằm trong sổ câu sai
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 300)),
    );
    final wrongIds = await tester.runAsync(
      () => ProgressRepository(db).watchWrongBookIds('A1').first,
    );
    expect(wrongIds, [question.id]);

    // 5. Quay lại tab Học, mở "Sổ câu sai": thấy danh sách có đúng câu vừa sai
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    // chờ số đếm của lối tắt cập nhật (Drift báo thay đổi bất đồng bộ)
    await tester.runAsync(
      () => Future.delayed(const Duration(milliseconds: 300)),
    );
    await tester.pump();
    await tester.tap(find.text('Sổ câu sai'));
    await pumpUntilFound(tester, 'Ôn ngay');
    expect(find.text('Đã làm 1/1 câu'), findsOneWidget);
    expect(find.text('Câu ${question.number}'), findsOneWidget);
    expect(find.text(question.content), findsOneWidget);

    // 6. Bấm "Ôn ngay" -> luyện lại đúng câu đó (chỉ 1 câu nên nút là "Hoàn thành")
    await tester.tap(find.text('Ôn ngay'));
    await pumpUntilFound(tester, 'Hoàn thành');
    expect(find.text('1/1'), findsOneWidget);

    await closeApp(tester, db);
  });

  testWidgets('Danh sách câu của chủ đề: bấm 1 câu thì luyện từ câu đó', (
    tester,
  ) async {
    final db = await openStudyTab(tester);
    final a1 = await tester.runAsync(
      () => CatalogRepository(db).questionsForClass('A1'),
    );
    final rules = <QuestionItem>[
      for (final q in a1!)
        if (q.categoryCode == 'RULES') q,
    ];

    // icon danh sách ở thẻ chủ đề đầu tiên (Khái niệm và quy tắc giao thông)
    await tester.tap(find.byTooltip('Xem danh sách câu').first);
    await pumpUntilFound(tester, 'Học tiếp');
    expect(find.text('Đã làm 0/${rules.length} câu'), findsOneWidget);
    expect(find.text('Câu ${rules[0].number}'), findsOneWidget);
    expect(find.text('Câu ${rules[1].number}'), findsOneWidget);

    // bấm câu thứ 2 trong danh sách -> luyện tập bắt đầu từ câu đó
    await tester.tap(find.text('Câu ${rules[1].number}'));
    await pumpUntilFound(tester, 'Câu tiếp theo');
    expect(find.text('2/${rules.length}'), findsOneWidget);
    expect(find.text(rules[1].content), findsOneWidget);

    await closeApp(tester, db);
  });

  testWidgets('Sổ câu sai và câu đã lưu trống thì hiện hướng dẫn', (
    tester,
  ) async {
    final db = await openStudyTab(tester);

    await tester.tap(find.text('Sổ câu sai'));
    await pumpUntilFound(tester, 'Chưa có câu nào');
    expect(find.textContaining('bạn chưa trả lời sai câu nào'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Câu đã lưu'));
    await pumpUntilFound(tester, 'Chưa có câu nào');
    expect(find.textContaining('Bấm biểu tượng lưu'), findsOneWidget);

    await closeApp(tester, db);
  });
}
