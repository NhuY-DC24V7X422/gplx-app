import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import '../../app/env.dart';
import '../../data/repositories/catalog_repository.dart';
import '../../data/repositories/progress_repository.dart';

// Đồng bộ dữ liệu câu hỏi giữa máy chủ và điện thoại.
// Gồm: nạp gói câu hỏi đóng kèm ở lần mở app đầu tiên, và tải gói mới từ máy chủ.
class SyncService {
  SyncService({
    required this.catalog,
    this.progress,
    AssetBundle? assets,
    http.Client? client,
    String? baseUrl,
  }) : _assets = assets ?? rootBundle,
       _client = client ?? http.Client(),
       _baseUrl = baseUrl ?? Env.apiBaseUrl;

  final CatalogRepository catalog;

  // để tính lại tiến độ câu bị đổi đáp án. Test chỉ nạp gói thì không cần.
  final ProgressRepository? progress;

  // nơi đọc file assets. Mặc định là rootBundle, test có thể truyền bundle giả.
  final AssetBundle _assets;

  // dùng để gọi API. Test truyền client giả, không cần chạy máy chủ thật.
  final http.Client _client;

  // vd http://10.0.2.2:3000/api/v1
  final String _baseUrl;

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

  // Hỏi máy chủ có dữ liệu mới không, có thì tải phần thay đổi về.
  // Trả về số câu hỏi vừa cập nhật (0 = không có gì mới).
  // Mất mạng / máy chủ tắt thì ném lỗi -> nơi gọi tự bắt và bỏ qua.
  Future<int> checkForUpdate() async {
    final localVersion = await catalog.catalogVersion();

    // 1. Hỏi phiên bản trên máy chủ
    final manifestRes = await _client
        .get(Uri.parse('$_baseUrl/sync/manifest'))
        .timeout(const Duration(seconds: 5));
    if (manifestRes.statusCode != 200) return 0;
    final manifest =
        _decodeJson(utf8.decode(manifestRes.bodyBytes))['data'] as Map;
    final serverVersion = manifest['publishedVersion'] as int;
    if (serverVersion <= localVersion) return 0; // máy đã mới nhất

    // 2. Chỉ tải các mục có version lớn hơn bản trên máy
    final bundleRes = await _client
        .get(Uri.parse('$_baseUrl/sync/catalog?sinceVersion=$localVersion'))
        .timeout(const Duration(seconds: 20));
    if (bundleRes.statusCode != 200) return 0;
    final json = await compute(_decodeJson, utf8.decode(bundleRes.bodyBytes));
    final bundle = Map<String, dynamic>.from(json['data'] as Map);

    // 3. Ghi vào SQLite.
    // Ảnh trên máy chủ trùng với ảnh có sẵn trong assets (trang quản trị chưa đổi ảnh)
    // nên nạp như gói đóng kèm để vẫn dùng ảnh trong assets.
    await catalog.importBundle(bundle, bundled: true);

    // 4. Câu nào bị đổi đáp án thì tính lại tiến độ
    final questions = (bundle['questions'] as List).cast<Map>();
    final changedIds = questions
        .where((q) => q['answerChangedAt'] != null)
        .map((q) => q['id'] as String)
        .toList();
    await progress?.replayQuestions(changedIds);

    return questions.length;
  }
}

// hàm chạy trong compute phải là hàm top-level (không nằm trong class)
Map<String, dynamic> _decodeJson(String text) {
  return Map<String, dynamic>.from(jsonDecode(text) as Map);
}
