import 'package:flutter/material.dart';

import '../common/placeholder_screen.dart';

// Tab Tra cứu
class LookupScreen extends StatelessWidget {
  const LookupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Tra cứu',
      icon: Icons.traffic,
      note: 'Tra cứu biển báo, mức phạt (ngày 13)',
    );
  }
}
