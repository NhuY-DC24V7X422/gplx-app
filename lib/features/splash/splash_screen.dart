import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';

// Màn hình khởi động: nạp bộ câu hỏi đóng kèm (chỉ lần đầu) rồi chuyển màn hình:
// - chưa thiết lập ban đầu -> Onboarding
// - đã thiết lập -> Trang chủ
//
// ConsumerStatefulWidget: giống StatefulWidget nhưng có thêm `ref` để dùng Riverpod.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  String? _error; // có lỗi thì hiện chữ + nút Thử lại

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    setState(() => _error = null);
    try {
      await ref.read(syncServiceProvider).ensureBundledCatalog();
      final settings = await ref.read(settingsRepositoryProvider).load();

      // widget có thể đã bị đóng trong lúc chờ -> kiểm tra trước khi chuyển màn hình
      if (!mounted) return;
      context.go(settings.onboarded ? '/' : '/onboarding');
    } catch (e) {
      setState(() => _error = 'Không nạp được dữ liệu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = TextStyle(color: colors.onPrimary);

    return Scaffold(
      backgroundColor: colors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.directions_car_filled,
                size: 72,
                color: colors.onPrimary,
              ),
              const SizedBox(height: 16),
              Text(
                'GPLX Pro',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text('Ôn thi lý thuyết A1 · A · B', style: textStyle),
              const SizedBox(height: 32),
              if (_error == null) ...[
                CircularProgressIndicator(color: colors.onPrimary),
                const SizedBox(height: 12),
                Text('Đang chuẩn bị bộ câu hỏi…', style: textStyle),
              ] else ...[
                Text(_error!, textAlign: TextAlign.center, style: textStyle),
                const SizedBox(height: 12),
                FilledButton.tonal(
                  onPressed: _start,
                  child: const Text('Thử lại'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
