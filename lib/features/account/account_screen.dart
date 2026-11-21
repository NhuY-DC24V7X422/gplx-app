import 'package:flutter/material.dart';

import '../common/placeholder_screen.dart';

// Tab Cá nhân
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Cá nhân',
      icon: Icons.person,
      note: 'Cài đặt và thông tin ứng dụng',
    );
  }
}
