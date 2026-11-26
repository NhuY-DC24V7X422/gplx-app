import '../core/utils/normalize_vi.dart';

// Tìm kiếm không dấu theo từng từ: mọi từ trong ô tìm kiếm đều phải có
// trong [text]. Vd gõ "bien cam" khớp với "Biển báo cấm".
bool matchesSearch(String text, String query) {
  final words = normalizeVi(query).split(' ');
  final content = normalizeVi(text);
  return words.every(content.contains);
}
