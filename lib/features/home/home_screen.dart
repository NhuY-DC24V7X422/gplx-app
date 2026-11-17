import 'package:flutter/material.dart';

import '../common/placeholder_screen.dart';

// Tab Trang chủ
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Trang chủ',
      icon: Icons.home,
      note: 'Lộ trình hôm nay, chuỗi ngày học (ngày 13)',
    );
  }
}
