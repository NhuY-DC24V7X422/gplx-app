import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../core/utils/vn_date.dart';

// Tab Trang chủ (bản tạm). Ngày 13 làm thật: lộ trình hôm nay, chuỗi ngày học, khả năng đạt.
// Hôm nay chỉ hiện các lựa chọn ở màn hình thiết lập ban đầu để kiểm tra đã lưu đúng.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch: cài đặt đổi thì màn hình tự vẽ lại
    final settings = ref.watch(settingsProvider).valueOrNull;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ')),
      body: settings == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Lựa chọn của bạn', style: text.titleMedium),
                        const SizedBox(height: 12),
                        Text('Hạng bằng: ${settings.licenseClass}'),
                        Text(
                          settings.examDate == null
                              ? 'Ngày thi: chưa chọn'
                              : 'Ngày thi: ${formatDayVi(settings.examDate!)} '
                                    '(còn ${diffDays(vnToday(), settings.examDate!)} ngày)',
                        ),
                        Text(
                          'Mục tiêu: ${settings.dailyNewGoal} câu mới mỗi ngày',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Lộ trình hôm nay, chuỗi ngày học (ngày 13)',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
    );
  }
}
