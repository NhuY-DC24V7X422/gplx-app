import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/database/app_database.dart';
import '../../data/models/catalog_models.dart';
import '../common/question_image.dart';

// Thẻ ghi nhớ biển báo: mặt trước là hình, chạm để lật xem tên và ý nghĩa,
// rồi tự đánh dấu "Đã nhớ" hoặc "Chưa nhớ".
class FlashcardScreen extends ConsumerStatefulWidget {
  const FlashcardScreen({super.key});

  @override
  ConsumerState<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends ConsumerState<FlashcardScreen> {
  List<TrafficSign> _allSigns = [];
  List<TrafficSign>? _deck; // các thẻ của lượt này, null = đang tải
  int _index = 0;
  bool _flipped = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final signs = await ref.read(trafficSignsProvider.future);
    _allSigns = signs;
    await _startUnremembered();
  }

  // Lượt học gồm các biển chưa nhớ
  Future<void> _startUnremembered() async {
    final remembered = await ref
        .read(progressRepositoryProvider)
        .watchRememberedSigns()
        .first;
    if (!mounted) return;
    _start(_allSigns.where((s) => !remembered.contains(s.id)).toList());
  }

  // Danh sách thẻ chốt từ đầu lượt, đánh dấu giữa chừng không làm đổi thứ tự
  void _start(List<TrafficSign> deck) {
    setState(() {
      _deck = deck;
      _index = 0;
      _flipped = false;
    });
  }

  Future<void> _mark(TrafficSign sign, bool remembered) async {
    if (_saving) return; // tránh bấm 2 lần liền bị nhảy 2 thẻ
    _saving = true;
    await ref
        .read(progressRepositoryProvider)
        .setSignRemembered(sign.id, remembered);
    _saving = false;
    if (!mounted) return;
    setState(() {
      _index++;
      _flipped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final remembered = ref.watch(rememberedSignsProvider).valueOrNull ?? {};
    final deck = _deck;

    return Scaffold(
      appBar: AppBar(title: const Text('Thẻ ghi nhớ')),
      body: SafeArea(
        child: deck == null
            ? const Center(child: CircularProgressIndicator())
            : _index >= deck.length
            ? _summary(remembered)
            : _card(deck, remembered),
      ),
    );
  }

  int _rememberedCount(Set<String> remembered) {
    return _allSigns.where((s) => remembered.contains(s.id)).length;
  }

  Widget _card(List<TrafficSign> deck, Set<String> remembered) {
    final sign = deck[_index];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Thẻ ${_index + 1}/${deck.length}'),
              Text(
                'Đã nhớ ${_rememberedCount(remembered)}/${_allSigns.length}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: (_index + 1) / deck.length),
          const SizedBox(height: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _flipped = !_flipped),
              // đổi mặt thì mặt cũ mờ dần, mặt mới hiện ra
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Card(
                  key: ValueKey('${sign.id}-$_flipped'),
                  child: SizedBox.expand(
                    child: _flipped ? _backSide(sign) : _frontSide(sign),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // lật xem đáp án rồi mới được đánh dấu
          if (_flipped)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _mark(sign, false),
                    icon: const Icon(Icons.close, color: wrongRed),
                    label: const Text('Chưa nhớ'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _mark(sign, true),
                    icon: const Icon(Icons.check),
                    label: const Text('Đã nhớ'),
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => setState(() => _flipped = true),
                child: const Text('Lật thẻ'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _frontSide(TrafficSign sign) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            QuestionImage(imageRef: sign.localImagePath, height: 220),
            const SizedBox(height: 16),
            const Text('Biển này có ý nghĩa gì?'),
          ],
        ),
      ),
    );
  }

  Widget _backSide(TrafficSign sign) {
    final text = Theme.of(context).textTheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              sign.name,
              textAlign: TextAlign.center,
              style: text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              '${sign.code} · ${signGroupNames[sign.groupCode] ?? sign.groupCode}',
              textAlign: TextAlign.center,
              style: text.titleSmall,
            ),
            const SizedBox(height: 16),
            Text(
              sign.description,
              textAlign: TextAlign.center,
              style: text.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  // Hết thẻ (hoặc đã nhớ hết từ trước)
  Widget _summary(Set<String> remembered) {
    final count = _rememberedCount(remembered);
    final left = _allSigns.length - count;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              left == 0 ? Icons.emoji_events : Icons.style,
              size: 64,
              color: left == 0 ? correctGreen : brandBlue,
            ),
            const SizedBox(height: 16),
            Text(
              'Đã nhớ $count/${_allSigns.length} biển',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            if (left > 0)
              FilledButton(
                onPressed: _startUnremembered,
                child: Text('Ôn $left biển chưa nhớ'),
              ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => _start(_allSigns),
              child: const Text('Xem lại tất cả'),
            ),
          ],
        ),
      ),
    );
  }
}
