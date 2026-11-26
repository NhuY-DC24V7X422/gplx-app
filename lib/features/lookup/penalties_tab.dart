import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../core/utils/format_money.dart';
import '../../domain/search.dart';
import '../common/empty_state.dart';
import 'search_box.dart';

const _vehicleNames = {'MOTORBIKE': 'Xe máy', 'CAR': 'Ô tô'};

// Danh sách mức phạt: tìm theo hành vi vi phạm, lọc theo loại xe
class PenaltiesTab extends ConsumerStatefulWidget {
  const PenaltiesTab({super.key});

  @override
  ConsumerState<PenaltiesTab> createState() => _PenaltiesTabState();
}

class _PenaltiesTabState extends ConsumerState<PenaltiesTab>
    with AutomaticKeepAliveClientMixin {
  String _query = '';
  String _vehicle = 'ALL';

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final penalties = ref.watch(penaltiesProvider).valueOrNull;

    if (penalties == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final shown = penalties.where((p) {
      if (_vehicle != 'ALL' && p.vehicleType != _vehicle) return false;
      return matchesSearch(p.searchText, _query);
    }).toList();

    return Column(
      children: [
        SearchBox(
          hint: 'Hành vi (vd: den do, mu bao hiem)',
          onChanged: (value) => setState(() => _query = value),
        ),
        SegmentedButton<String>(
          segments: [
            const ButtonSegment(value: 'ALL', label: Text('Tất cả')),
            for (final entry in _vehicleNames.entries)
              ButtonSegment(value: entry.key, label: Text(entry.value)),
          ],
          selected: {_vehicle},
          onSelectionChanged: (value) => setState(() => _vehicle = value.first),
        ),
        Expanded(
          child: shown.isEmpty
              ? const EmptyState(
                  icon: Icons.search_off,
                  title: 'Không tìm thấy mức phạt',
                  message: 'Thử từ khóa khác hoặc chọn "Tất cả".',
                )
              : ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    for (final penalty in shown) _PenaltyCard(penalty: penalty),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Thông tin chỉ để tham khảo, '
                        'hãy đối chiếu với văn bản pháp luật khi cần.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _PenaltyCard extends StatelessWidget {
  const _PenaltyCard({required this.penalty});

  final Penalty penalty;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final isCar = penalty.vehicleType == 'CAR';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isCar ? Icons.directions_car : Icons.two_wheeler,
                  size: 20,
                ),
                const SizedBox(width: 6),
                Text(
                  _vehicleNames[penalty.vehicleType] ?? penalty.vehicleType,
                  style: text.labelLarge,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(penalty.violation),
            const SizedBox(height: 6),
            Text(
              '${formatMoney(penalty.fineMin)} – ${formatMoney(penalty.fineMax)}',
              style: text.titleMedium?.copyWith(
                color: wrongRed,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (penalty.additionalPenalty != null)
              Text(
                'Bổ sung: ${penalty.additionalPenalty}',
                style: text.bodySmall,
              ),
            Text(penalty.legalRef, style: text.bodySmall),
          ],
        ),
      ),
    );
  }
}
