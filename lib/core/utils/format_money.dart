// Thêm dấu chấm ngăn cách hàng nghìn: 4000000 -> "4.000.000 đ"
String formatMoney(int value) {
  final text = value.toString().replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+$)'),
    (match) => '.',
  );
  return '$text đ';
}
