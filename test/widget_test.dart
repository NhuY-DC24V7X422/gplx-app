import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/app/app.dart';

void main() {
  testWidgets('mở app thấy tab Trang chủ, bấm chuyển được sang 4 tab còn lại', (
    tester,
  ) async {
    await tester.pumpWidget(const GplxApp());
    await tester.pumpAndSettle();

    // mở app là ở tab Trang chủ
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(
      find.text('Lộ trình hôm nay, chuỗi ngày học (ngày 13)'),
      findsOneWidget,
    );

    // bấm từng tab rồi kiểm tra đúng màn hình
    final tabs = {
      'Học': 'Học theo chủ đề, câu điểm liệt, sổ câu sai (ngày 11)',
      'Thi thử': 'Thi thử theo đề, xem lịch sử (ngày 12)',
      'Tra cứu': 'Tra cứu biển báo, mức phạt (ngày 13)',
      'Cá nhân': 'Đăng nhập, cài đặt, đồng bộ (ngày 14, 16)',
    };
    for (final entry in tabs.entries) {
      // tên tab xuất hiện ở thanh dưới và ở AppBar -> lấy cái trong NavigationBar
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(entry.key),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(entry.value), findsOneWidget);
    }
  });
}
