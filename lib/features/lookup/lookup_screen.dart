import 'package:flutter/material.dart';

import 'penalties_tab.dart';
import 'signs_tab.dart';

// Tab Tra cứu: gồm 2 phần Biển báo và Mức phạt (xem được khi không có mạng)
class LookupScreen extends StatelessWidget {
  const LookupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tra cứu'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Biển báo'),
              Tab(text: 'Mức phạt'),
            ],
          ),
        ),
        body: const TabBarView(children: [SignsTab(), PenaltiesTab()]),
      ),
    );
  }
}
