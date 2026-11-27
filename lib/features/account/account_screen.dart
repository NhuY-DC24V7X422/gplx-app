import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/env.dart';
import '../../app/providers.dart';
import '../../core/utils/vn_date.dart';
import '../../data/repositories/settings_repository.dart';

// Tab Cá nhân: đổi hạng bằng, ngày thi, mục tiêu mỗi ngày
// (các lựa chọn ở màn thiết lập ban đầu) và xem thông tin ứng dụng.
// Đổi xong là lưu ngay vào SQLite, Trang chủ tự cập nhật theo.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  static const goalOptions = [10, 20, 30, 50]; // giống màn thiết lập ban đầu

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).valueOrNull;
    final classes = ref.watch(licenseClassesProvider).valueOrNull ?? [];
    final dataVersion = ref.watch(catalogVersionProvider).valueOrNull;
    final repo = ref.read(settingsRepositoryProvider);
    final text = Theme.of(context).textTheme;

    if (settings == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // tên đầy đủ của hạng đang chọn, vd "Hạng A1"
    final className = classes
        .where((c) => c.code == settings.licenseClass)
        .map((c) => c.name)
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(title: const Text('Cá nhân')),
      body: ListView(
        children: [
          _sectionTitle(context, 'Ôn thi'),
          ListTile(
            leading: const Icon(Icons.badge_outlined),
            title: const Text('Hạng bằng'),
            subtitle: Text(className ?? settings.licenseClass),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _pickLicenseClass(context, ref, settings),
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Ngày thi'),
            subtitle: Text(
              settings.examDate == null
                  ? 'Chưa chọn'
                  : '${formatDayVi(settings.examDate!)} '
                        '(còn ${diffDays(vnToday(), settings.examDate!)} ngày)',
            ),
            onTap: () => _pickExamDate(context, repo, settings),
            // có ngày thi thì cho bỏ chọn
            trailing: settings.examDate == null
                ? const Icon(Icons.chevron_right)
                : IconButton(
                    tooltip: 'Bỏ ngày thi',
                    icon: const Icon(Icons.close),
                    onPressed: () => repo.setExamDate(null),
                  ),
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('Số câu mới mỗi ngày'),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Wrap(
                spacing: 8,
                children: [
                  for (final goal in goalOptions)
                    ChoiceChip(
                      label: Text('$goal câu'),
                      selected: settings.dailyNewGoal == goal,
                      onSelected: (_) => repo.setDailyNewGoal(goal),
                    ),
                ],
              ),
            ),
          ),
          if (settings.examDate != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(72, 0, 16, 8),
              child: Text(
                'Đã có ngày thi: app chia đều số câu cần học, '
                'mục tiêu này chỉ dùng khi bỏ ngày thi.',
                style: text.bodySmall,
              ),
            ),
          const Divider(),

          _sectionTitle(context, 'Nhắc học'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_outlined),
            title: const Text('Nhắc học mỗi ngày'),
            subtitle: Text(
              settings.reminderTime == null
                  ? 'Đang tắt'
                  : 'Lúc ${settings.reminderTime} mỗi ngày',
            ),
            value: settings.reminderTime != null,
            onChanged: (on) => on
                ? _turnOnReminder(context, ref, settings)
                : _turnOffReminder(ref),
          ),
          if (settings.reminderTime != null)
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Đổi giờ nhắc'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _turnOnReminder(context, ref, settings),
            ),
          const Divider(),

          _sectionTitle(context, 'Ứng dụng'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Phiên bản ứng dụng'),
            subtitle: Text(Env.appVersion),
          ),
          ListTile(
            leading: const Icon(Icons.storage_outlined),
            title: const Text('Phiên bản dữ liệu câu hỏi'),
            subtitle: Text(dataVersion == null ? '…' : '$dataVersion'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }

  // Bảng chọn hạng bằng hiện từ dưới lên
  Future<void> _pickLicenseClass(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    final classes = ref.read(licenseClassesProvider).valueOrNull ?? [];
    final picked = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final c in classes)
              ListTile(
                leading: Icon(
                  c.code == settings.licenseClass
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
                title: Text(c.name),
                subtitle: Text(
                  '${c.config.totalQuestions} câu · '
                  '${c.config.durationMinutes} phút · '
                  'đạt từ ${c.config.passScore} câu',
                ),
                onTap: () => Navigator.pop(context, c.code),
              ),
          ],
        ),
      ),
    );
    if (picked == null || picked == settings.licenseClass) return;
    await ref.read(settingsRepositoryProvider).setLicenseClass(picked);
  }

  // Chọn giờ rồi bật nhắc học (cũng dùng để đổi giờ nhắc)
  Future<void> _turnOnReminder(
    BuildContext context,
    WidgetRef ref,
    AppSettings settings,
  ) async {
    // giờ đang đặt, chưa đặt thì gợi ý 20:00
    final parts = (settings.reminderTime ?? '20:00').split(':');
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      ),
      helpText: 'Chọn giờ nhắc học',
      // luôn dùng kiểu 24 giờ (gõ 07 là 7 giờ sáng, không bị hiểu thành 7 giờ tối)
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return; // bấm Hủy

    final ok = await ref
        .read(reminderServiceProvider)
        .turnOn(picked.hour, picked.minute);
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    if (!ok) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Bạn chưa cho phép app hiện thông báo. '
            'Hãy bật trong Cài đặt của điện thoại.',
          ),
        ),
      );
      return;
    }

    // lưu dạng 'HH:mm', vd 07:05
    final hh = picked.hour.toString().padLeft(2, '0');
    final mm = picked.minute.toString().padLeft(2, '0');
    await ref.read(settingsRepositoryProvider).setReminderTime('$hh:$mm');
    messenger.showSnackBar(
      SnackBar(content: Text('Sẽ nhắc bạn lúc $hh:$mm mỗi ngày')),
    );
  }

  Future<void> _turnOffReminder(WidgetRef ref) async {
    await ref.read(reminderServiceProvider).turnOff();
    await ref.read(settingsRepositoryProvider).setReminderTime(null);
  }

  // Lịch chọn ngày thi: từ hôm nay đến 1 năm sau
  Future<void> _pickExamDate(
    BuildContext context,
    SettingsRepository repo,
    AppSettings settings,
  ) async {
    final today = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: settings.examDate == null
          ? today.add(const Duration(days: 30))
          : DateTime.parse(settings.examDate!),
      firstDate: today,
      lastDate: today.add(const Duration(days: 365)),
      helpText: 'Chọn ngày thi dự kiến',
    );
    if (picked == null) return; // bấm Hủy

    // đổi DateTime thành chuỗi 'YYYY-MM-DD'
    final y = picked.year.toString().padLeft(4, '0');
    final m = picked.month.toString().padLeft(2, '0');
    final d = picked.day.toString().padLeft(2, '0');
    await repo.setExamDate('$y-$m-$d');
  }
}