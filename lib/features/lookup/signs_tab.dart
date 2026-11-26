import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../data/models/catalog_models.dart';
import '../../domain/search.dart';
import '../common/empty_state.dart';
import '../common/question_image.dart';
import 'search_box.dart';

// Danh sách biển báo: tìm kiếm, lọc theo nhóm, mở thẻ ghi nhớ
class SignsTab extends ConsumerStatefulWidget {
  const SignsTab({super.key});

  @override
  ConsumerState<SignsTab> createState() => _SignsTabState();
}

// AutomaticKeepAliveClientMixin: qua tab Mức phạt rồi quay lại
// vẫn còn chữ đang tìm và nhóm đang chọn
class _SignsTabState extends ConsumerState<SignsTab>
    with AutomaticKeepAliveClientMixin {
  String _query = '';
  String? _group; // null = tất cả

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final signs = ref.watch(trafficSignsProvider).valueOrNull;
    final remembered = ref.watch(rememberedSignsProvider).valueOrNull ?? {};

    if (signs == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final shown = signs.where((s) {
      if (_group != null && s.groupCode != _group) return false;
      // tìm theo cả tên nhóm, vd "bien cam"
      final groupName = signGroupNames[s.groupCode] ?? '';
      return matchesSearch('$groupName ${s.searchText}', _query);
    }).toList();
    final rememberedCount = signs
        .where((s) => remembered.contains(s.id))
        .length;

    return Column(
      children: [
        SearchBox(
          hint: 'Tên hoặc mã biển (gõ không dấu được)',
          onChanged: (value) => setState(() => _query = value),
        ),
        _groupChips(signs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: () => context.push('/flashcards'),
              icon: const Icon(Icons.style),
              label: Text(
                'Thẻ ghi nhớ (đã nhớ $rememberedCount/${signs.length})',
              ),
            ),
          ),
        ),
        Expanded(
          child: shown.isEmpty
              ? const EmptyState(
                  icon: Icons.search_off,
                  title: 'Không tìm thấy biển báo',
                  message: 'Thử từ khóa khác hoặc chọn nhóm "Tất cả".',
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisExtent: 190,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: shown.length,
                  itemBuilder: (context, index) {
                    final sign = shown[index];
                    return _SignCard(
                      sign: sign,
                      remembered: remembered.contains(sign.id),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Hàng nút lọc nhóm, chỉ hiện những nhóm đang có biển
  Widget _groupChips(List<TrafficSign> signs) {
    final groups = signGroupNames.keys.where(
      (code) => signs.any((s) => s.groupCode == code),
    );

    Widget chip(String? code, String label) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ChoiceChip(
          label: Text(label),
          selected: _group == code,
          onSelected: (_) => setState(() => _group = code),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          chip(null, 'Tất cả'),
          for (final code in groups) chip(code, signGroupNames[code]!),
        ],
      ),
    );
  }
}

// 1 ô biển báo: hình, mã, tên. Có dấu tích nếu đã nhớ.
class _SignCard extends StatelessWidget {
  const _SignCard({required this.sign, required this.remembered});

  final TrafficSign sign;
  final bool remembered;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/sign', extra: sign),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              QuestionImage(imageRef: sign.localImagePath, height: 80),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    sign.code,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (remembered) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle,
                      size: 16,
                      color: correctGreen,
                    ),
                  ],
                ],
              ),
              Text(
                sign.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
