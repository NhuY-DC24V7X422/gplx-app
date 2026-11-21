import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/utils/vn_date.dart';
import '../../data/models/catalog_models.dart';

// Màn hình thiết lập ban đầu (chỉ hiện ở lần mở app đầu tiên):
// 1. chọn hạng bằng  2. chọn ngày thi (không bắt buộc)  3. mục tiêu số câu mới mỗi ngày
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const goalOptions = [10, 20, 30, 50]; // các mức câu mới mỗi ngày

  String _licenseClass = 'A1';
  String? _examDate; // 'YYYY-MM-DD'
  int _dailyGoal = 20;
  bool _saving = false;

  // Mở lịch chọn ngày thi: từ hôm nay đến 1 năm sau
  Future<void> _pickExamDate() async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: today.add(const Duration(days: 30)),
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
      helpText: 'Chọn ngày thi dự kiến',
    );
    if (picked == null) return; // bấm Hủy

    // đổi DateTime thành chuỗi 'YYYY-MM-DD'
    final y = picked.year.toString().padLeft(4, '0');
    final m = picked.month.toString().padLeft(2, '0');
    final d = picked.day.toString().padLeft(2, '0');
    setState(() => _examDate = '$y-$m-$d');
  }

  // Bấm "Bắt đầu ôn thi": lưu lựa chọn rồi vào Trang chủ
  Future<void> _finish() async {
    setState(() => _saving = true);
    final settings = ref.read(settingsRepositoryProvider);
    await settings.setLicenseClass(_licenseClass);
    await settings.setExamDate(_examDate);
    await settings.setDailyNewGoal(_dailyGoal);
    await settings.setOnboarded(true); // lần sau mở app sẽ bỏ qua màn hình này

    if (!mounted) return;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    // danh sách hạng bằng đọc từ SQLite (đã nạp ở Splash)
    final classes = ref.watch(licenseClassesProvider).valueOrNull ?? [];
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Chào mừng bạn!',
              style: text.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Thiết lập nhanh để app lên lộ trình ôn thi phù hợp. '
              'Bạn có thể đổi lại bất cứ lúc nào.',
              style: text.bodyLarge,
            ),
            const SizedBox(height: 28),

            // ----- 1. Hạng bằng -----
            Text('1. Bạn thi hạng nào?', style: text.titleMedium),
            const SizedBox(height: 8),
            for (final c in classes) _classCard(c),
            const SizedBox(height: 20),

            // ----- 2. Ngày thi -----
            Text(
              '2. Ngày thi dự kiến (không bắt buộc)',
              style: text.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.event),
                  label: Text(
                    _examDate == null
                        ? 'Chọn ngày thi'
                        : formatDayVi(_examDate!),
                  ),
                  onPressed: _pickExamDate,
                ),
                if (_examDate != null)
                  TextButton(
                    onPressed: () => setState(() => _examDate = null),
                    child: const Text('Bỏ chọn'),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _examDate == null
                  ? 'Chưa có ngày thi: mỗi ngày học theo mục tiêu ở bước 3.'
                  : 'Còn ${diffDays(vnToday(), _examDate!)} ngày – app sẽ chia đều số câu cần học.',
              style: text.bodySmall,
            ),
            const SizedBox(height: 20),

            // ----- 3. Mục tiêu mỗi ngày -----
            Text('3. Mỗi ngày học bao nhiêu câu mới?', style: text.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final goal in goalOptions)
                  ChoiceChip(
                    label: Text('$goal câu'),
                    selected: _dailyGoal == goal,
                    onSelected: (_) => setState(() => _dailyGoal = goal),
                  ),
              ],
            ),
            const SizedBox(height: 32),

            FilledButton(
              onPressed: _saving ? null : _finish,
              child: Text(_saving ? 'Đang lưu…' : 'Bắt đầu ôn thi'),
            ),
          ],
        ),
      ),
    );
  }

  // Thẻ chọn 1 hạng bằng: bấm vào để chọn, hạng đang chọn có viền + dấu tích
  Widget _classCard(LicenseClassInfo c) {
    final selected = c.code == _licenseClass;
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: selected ? colors.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: () => setState(() => _licenseClass = c.code),
        leading: Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          color: selected ? colors.primary : null,
        ),
        title: Text(
          c.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${c.config.totalQuestions} câu · ${c.config.durationMinutes} phút · '
          'đạt từ ${c.config.passScore} câu',
        ),
      ),
    );
  }
}
