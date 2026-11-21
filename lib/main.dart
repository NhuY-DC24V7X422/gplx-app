import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'core/database/app_database.dart';
import 'core/sync/sync_service.dart';
import 'data/repositories/catalog_repository.dart';

Future<void> main() async {
  // bắt buộc gọi trước khi dùng plugin / chạy code async trong main
  WidgetsFlutterBinding.ensureInitialized();

  // nạp dữ liệu định dạng ngày tiếng Việt (vd: "Thứ Hai, 16/11")
  await initializeDateFormatting('vi');

  // Mở database và nạp gói câu hỏi đóng kèm (chỉ lần đầu cài app).
  // Ngày 10 sẽ chuyển phần này vào màn hình Splash + Riverpod provider.
  final db = AppDatabase();
  final catalog = CatalogRepository(db);
  final loaded = await SyncService(catalog: catalog).ensureBundledCatalog();
  debugPrint(
    loaded
        ? 'Đã nạp gói đóng kèm: ${await catalog.countQuestions()} câu hỏi'
        : 'Đã có dữ liệu v${await catalog.catalogVersion()}, không cần nạp lại',
  );

  // ProviderScope: bắt buộc bọc ngoài cùng để dùng Riverpod (ngày 10 mới dùng)
  runApp(const ProviderScope(child: GplxApp()));
}
