// Bỏ dấu tiếng Việt để tìm kiếm: "Cấm đi ngược chiều" -> "cam di nguoc chieu"
// Phải ra cùng kết quả với gplx-api/src/domain/normalize-vi.ts.
//
// Bên TS dùng normalize('NFD') để tách dấu, Dart không có hàm này
// nên mình dùng bảng: mỗi chữ có dấu ở _from ứng với chữ không dấu cùng vị trí ở _to.

const _from =
    'àáạảãâầấậẩẫăằắặẳẵ'
    'èéẹẻẽêềếệểễ'
    'ìíịỉĩ'
    'òóọỏõôồốộổỗơờớợởỡ'
    'ùúụủũưừứựửữ'
    'ỳýỵỷỹ'
    'đ';
const _to =
    'aaaaaaaaaaaaaaaaa'
    'eeeeeeeeeee'
    'iiiii'
    'ooooooooooooooooo'
    'uuuuuuuuuuu'
    'yyyyy'
    'd';

// tạo Map { 'à': 'a', 'á': 'a', ... } 1 lần để tra cho nhanh
final _map = {for (var i = 0; i < _from.length; i++) _from[i]: _to[i]};

// dấu rời (khi chữ được gõ kiểu tổ hợp: "a" + dấu sắc riêng)
final _combiningMarks = RegExp('[̀-ͯ]');
final _spaces = RegExp(r'\s+');

String normalizeVi(String text) {
  final lower = text.toLowerCase();

  // thay từng ký tự có dấu bằng ký tự không dấu
  final buffer = StringBuffer();
  for (final ch in lower.split('')) {
    buffer.write(_map[ch] ?? ch);
  }

  // xóa dấu rời còn sót, gộp nhiều khoảng trắng/xuống dòng thành 1 khoảng trắng
  return buffer
      .toString()
      .replaceAll(_combiningMarks, '')
      .replaceAll(_spaces, ' ')
      .trim();
}
