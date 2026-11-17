import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';

Future<void> main() async {
  // bắt buộc gọi trước khi dùng plugin / chạy code async trong main
  WidgetsFlutterBinding.ensureInitialized();

  // nạp dữ liệu định dạng ngày tiếng Việt (vd: "Thứ Hai, 16/11")
  await initializeDateFormatting('vi');

  // ProviderScope: bắt buộc bọc ngoài cùng để dùng Riverpod (ngày 10 mới dùng)
  runApp(const ProviderScope(child: GplxApp()));
}
