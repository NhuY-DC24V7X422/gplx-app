import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'core/database/app_database.dart';

Future<void> main() async {
  // bắt buộc gọi trước khi dùng plugin / chạy code async trong main
  WidgetsFlutterBinding.ensureInitialized();

  // nạp dữ liệu định dạng ngày tiếng Việt (vd: "Thứ Hai, 16/11")
  await initializeDateFormatting('vi');

  // Mở database 1 lần cho cả app. Việc nạp gói câu hỏi đã chuyển sang màn hình Splash.
  final db = AppDatabase();

  // ProviderScope: bắt buộc bọc ngoài cùng để dùng Riverpod.
  // overrides: đưa database thật vào databaseProvider.
  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(db)],
      child: const GplxApp(),
    ),
  );
}
