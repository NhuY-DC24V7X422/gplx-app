import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../data/repositories/catalog_repository.dart';

// Đồng bộ dữ liệu. Hôm nay mới có phần nạp gói đóng kèm.
// Ngày 15 thêm: hỏi API có bản mới không, tải về, tải ảnh, đẩy/kéo tiến độ.
class SyncService {
  SyncService({required this.catalog, AssetBundle? assets})
    : _assets = assets ?? rootBundle;

  final CatalogRepository catalog;

  // nơi đọc file assets. Mặc định là rootBundle, test có thể truyền bundle giả.
  final AssetBundle _assets;

  // Lần đầu mở app: nạp assets/catalog/catalog.json vào SQLite
  // để học được ngay khi chưa có mạng.
  // Trả về true nếu vừa nạp, false nếu máy đã có dữ liệu rồi.
  Future<bool> ensureBundledCatalog() async {
    if (await catalog.catalogVersion() > 0) return false;

    final text = await _assets.loadString('assets/catalog/catalog.json');
    // compute: đọc JSON ở luồng khác cho giao diện khỏi bị khựng
    final bundle = await compute(_decodeJson, text);
    await catalog.importBundle(bundle, bundled: true);
    return true;
  }
}

// hàm chạy trong compute phải là hàm top-level (không nằm trong class)
Map<String, dynamic> _decodeJson(String text) {
  return Map<String, dynamic>.from(jsonDecode(text) as Map);
}
