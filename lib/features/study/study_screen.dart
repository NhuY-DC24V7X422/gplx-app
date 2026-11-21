import 'package:flutter/material.dart';

import '../common/placeholder_screen.dart';

// Tab Học
class StudyScreen extends StatelessWidget {
  const StudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Học',
      icon: Icons.menu_book,
      note: 'Học theo chủ đề, câu điểm liệt, sổ câu sai',
    );
  }
}
