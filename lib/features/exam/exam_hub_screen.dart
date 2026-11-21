import 'package:flutter/material.dart';

import '../common/placeholder_screen.dart';

// Tab Thi thử
class ExamHubScreen extends StatelessWidget {
  const ExamHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Thi thử',
      icon: Icons.timer,
      note: 'Thi thử theo đề, xem lịch sử',
    );
  }
}
