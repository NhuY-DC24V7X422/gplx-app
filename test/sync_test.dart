// Test tải gói dữ liệu mới từ máy chủ (máy chủ giả bằng MockClient).
import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/database/app_database.dart';
import 'package:gplx_app/core/sync/sync_service.dart';
import 'package:gplx_app/data/repositories/catalog_repository.dart';
import 'package:gplx_app/data/repositories/progress_repository.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late CatalogRepository catalog;
  late ProgressRepository progress;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    catalog = CatalogRepository(db);
    progress = ProgressRepository(db);
    await SyncService(catalog: catalog).ensureBundledCatalog(); // version 1
  });

  tearDown(() => db.close());

  // Tạo SyncService với máy chủ giả: manifest báo [serverVersion],
  // catalog trả về [questions]. [calls] ghi lại các đường dẫn đã gọi.
  SyncService fakeServer(
    int serverVersion,
    List<Map<String, dynamic>> questions,
    List<String> calls,
  ) {
    final client = MockClient((request) async {
      calls.add('${request.url.path}?${request.url.query}');
      if (request.url.path.endsWith('/sync/manifest')) {
        return http.Response(
          jsonEncode({
            'data': {'publishedVersion': serverVersion},
          }),
          200,
        );
      }
      return http.Response.bytes(
        utf8.encode(
          jsonEncode({
            'data': {
              'version': serverVersion,
              'licenseClasses': [],
              'categories': [],
              'questions': questions,
              'trafficSigns': [],
              'penalties': [],
            },
          }),
        ),
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      );
    });
    return SyncService(
      catalog: catalog,
      progress: progress,
      client: client,
      baseUrl: 'http://test/api/v1',
    );
  }

  // Lấy 1 câu trong máy, đổi nội dung + đáp án thành dạng JSON như máy chủ trả về
  Future<Map<String, dynamic>> editedQuestion() async {
    final q = (await catalog.questionsForClass('A1')).first;
    final newKey = q.options.firstWhere((o) => o.key != q.correctKey).key;
    return {
      'id': q.id,
      'number': q.number,
      'content': 'Nội dung đã sửa',
      'imageUrl': null,
      'options': q.options.map((o) => {'key': o.key, 'text': o.text}).toList(),
      'correctKey': newKey,
      'explanation': null,
      'legalRef': null,
      'categoryCode': q.categoryCode,
      'licenseClasses': ['A1'],
      'isCritical': q.isCritical,
      'status': 'published',
      'version': 2,
      'answerChangedAt': DateTime.now().toUtc().toIso8601String(),
    };
  }

  test('máy chủ cùng phiên bản thì không tải gói', () async {
    final calls = <String>[];
    final n = await fakeServer(1, [], calls).checkForUpdate();
    expect(n, 0);
    expect(calls.length, 1); // chỉ gọi manifest
  });

  test('máy chủ mới hơn thì tải phần thay đổi và cập nhật câu hỏi', () async {
    final calls = <String>[];
    final edited = await editedQuestion();
    final n = await fakeServer(2, [edited], calls).checkForUpdate();

    expect(n, 1);
    expect(calls.last, contains('sinceVersion=1'));
    expect(await catalog.catalogVersion(), 2);
    final q = await catalog.questionById(edited['id'] as String);
    expect(q!.content, 'Nội dung đã sửa');
    expect(q.correctKey, edited['correctKey']);
  });
}
