import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Khung chính của app: nội dung tab ở trên, thanh 5 tab ở dưới.
// `shell` do go_router truyền vào, giữ trạng thái riêng của từng tab.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  void _onTabTap(int index) {
    // bấm lại tab đang mở thì quay về màn hình đầu của tab đó
    shell.goBranch(index, initialLocation: index == shell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: _onTabTap,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Học',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Thi thử',
          ),
          NavigationDestination(
            icon: Icon(Icons.traffic_outlined),
            selectedIcon: Icon(Icons.traffic),
            label: 'Tra cứu',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
