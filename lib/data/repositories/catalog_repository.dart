import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/database/app_database.dart';
import '../../core/utils/normalize_vi.dart';
import '../models/catalog_models.dart';

// Đọc / ghi dữ liệu câu hỏi, biển báo, mức phạt trong SQLite.
// Màn hình CHỈ đọc từ đây, không gọi API trực tiếp -> không có mạng vẫn chạy.
class CatalogRepository {
  CatalogRepository(this.db);

  final AppDatabase db;

  // Nạp gói dữ liệu 
  // bundled = true: gói đóng kèm trong app (assets/catalog/catalog.json),
  // ảnh nằm sẵn trong assets nên không cần tải.
  Future<void> importBundle(
    Map<String, dynamic> bundle, {
    required bool bundled,
  }) async {
    // transaction: lỗi giữa chừng thì hủy hết, không bị nạp dở dang
    await db.transaction(() async {
      for (final c in (bundle['categories'] as List).cast<Map>()) {
        await db
            .into(db.categories)
            .insertOnConflictUpdate(
              CategoriesCompanion.insert(
                code: c['code'] as String,
                name: c['name'] as String,
                sortOrder: c['order'] as int,
                version: c['version'] as int,
              ),
            );
      }

      for (final l in (bundle['licenseClasses'] as List).cast<Map>()) {
        await db
            .into(db.licenseClasses)
            .insertOnConflictUpdate(
              LicenseClassesCompanion.insert(
                code: l['code'] as String,
                name: l['name'] as String,
                description: l['description'] as String,
                examConfigJson: jsonEncode(l['examConfig']),
                sortOrder: l['order'] as int,
                version: l['version'] as int,
              ),
            );
      }

      for (final q in (bundle['questions'] as List).cast<Map>()) {
        final id = q['id'] as String;
        // câu bị admin ẩn thì xóa khỏi máy
        if (q['status'] == 'hidden') {
          await (db.delete(db.questions)..where((t) => t.id.equals(id))).go();
          continue;
        }

        final answerChangedAt = q['answerChangedAt'] == null
            ? null
            : DateTime.parse(q['answerChangedAt'] as String);

        // insertOnConflictUpdate: chưa có thì thêm, có rồi (trùng id) thì cập nhật
        await db
            .into(db.questions)
            .insertOnConflictUpdate(
              QuestionsCompanion.insert(
                id: id,
                number: q['number'] as int,
                content: q['content'] as String,
                searchText:
                    (q['searchText'] as String?) ??
                    normalizeVi(q['content'] as String),
                imageUrl: Value(bundled ? null : q['imageUrl'] as String?),
                imageHash: Value(q['imageHash'] as String?),
                localImagePath: Value(_bundledImage(q['imageUrl'], bundled)),
                optionsJson: jsonEncode(q['options']),
                correctKey: q['correctKey'] as String,
                explanation: Value(q['explanation'] as String?),
                legalRef: Value(q['legalRef'] as String?),
                categoryCode: q['categoryCode'] as String,
                licenseClasses: ',${(q['licenseClasses'] as List).join(',')},',
                isCritical: q['isCritical'] as bool,
                status: q['status'] as String,
                version: q['version'] as int,
                answerChangedAt: Value(answerChangedAt),
              ),
            );
      }

      for (final s in (bundle['trafficSigns'] as List).cast<Map>()) {
        final id = s['id'] as String;
        if (s['status'] == 'hidden') {
          await (db.delete(
            db.trafficSigns,
          )..where((t) => t.id.equals(id))).go();
          continue;
        }
        await db
            .into(db.trafficSigns)
            .insertOnConflictUpdate(
              TrafficSignsCompanion.insert(
                id: id,
                code: s['code'] as String,
                name: s['name'] as String,
                groupCode: s['group'] as String,
                description: s['description'] as String,
                imageUrl: Value(bundled ? null : s['imageUrl'] as String?),
                imageHash: Value(s['imageHash'] as String?),
                localImagePath: Value(_bundledImage(s['imageUrl'], bundled)),
                searchText:
                    (s['searchText'] as String?) ??
                    normalizeVi('${s['code']} ${s['name']}'),
                status: s['status'] as String,
                version: s['version'] as int,
              ),
            );
      }

      for (final p in (bundle['penalties'] as List).cast<Map>()) {
        final id = p['id'] as String;
        if (p['status'] == 'hidden') {
          await (db.delete(db.penalties)..where((t) => t.id.equals(id))).go();
          continue;
        }
        await db
            .into(db.penalties)
            .insertOnConflictUpdate(
              PenaltiesCompanion.insert(
                id: id,
                violation: p['violation'] as String,
                vehicleType: p['vehicleType'] as String,
                fineMin: p['fineMin'] as int,
                fineMax: p['fineMax'] as int,
                additionalPenalty: Value(p['additionalPenalty'] as String?),
                legalRef: p['legalRef'] as String,
                searchText:
                    (p['searchText'] as String?) ??
                    normalizeVi(p['violation'] as String),
                status: p['status'] as String,
                version: p['version'] as int,
              ),
            );
      }

      // nhớ version đang có để lần sau so với server
      await db.setMeta('catalogVersion', '${bundle['version']}');
      if (bundle['dataset'] != null) {
        await db.setMeta('dataset', bundle['dataset'] as String);
      }
    });
  }

  // Ảnh trong gói đóng kèm: 'images/q_32.png' -> 'asset:images/q_32.png'
  // (chữ "asset:" để màn hình biết đọc ảnh từ assets của app)
  String? _bundledImage(dynamic url, bool bundled) {
    if (url == null || !bundled) return null;
    return 'asset:$url';
  }

  // version dữ liệu đang có trong máy, 0 = chưa nạp gì
  Future<int> catalogVersion() async {
    final text = await db.getMeta('catalogVersion');
    return int.tryParse(text ?? '') ?? 0;
  }

  // ---------------------------------------------------------------
  // Đọc dữ liệu
  // ---------------------------------------------------------------

  Future<List<LicenseClassInfo>> licenseClasses() async {
    final rows = await (db.select(
      db.licenseClasses,
    )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).get();
    return rows.map(LicenseClassInfo.fromRow).toList();
  }

  Future<LicenseClassInfo?> licenseClass(String code) async {
    final row = await (db.select(
      db.licenseClasses,
    )..where((t) => t.code.equals(code))).getSingleOrNull();
    return row == null ? null : LicenseClassInfo.fromRow(row);
  }

  Future<List<CategoryInfo>> categories() async {
    final rows = await (db.select(
      db.categories,
    )..orderBy([(t) => OrderingTerm(expression: t.sortOrder)])).get();
    return rows
        .map(
          (c) => CategoryInfo(code: c.code, name: c.name, order: c.sortOrder),
        )
        .toList();
  }

  // Câu hỏi của 1 hạng bằng, xếp theo số câu
  Future<List<QuestionItem>> questionsForClass(String licenseClass) async {
    final rows =
        await (db.select(db.questions)
              ..where(
                (t) =>
                    t.status.equals('active') &
                    t.licenseClasses.like('%,$licenseClass,%'),
              )
              ..orderBy([(t) => OrderingTerm(expression: t.number)]))
            .get();
    return rows.map(QuestionItem.fromRow).toList();
  }

  Future<QuestionItem?> questionById(String id) async {
    final row = await (db.select(
      db.questions,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : QuestionItem.fromRow(row);
  }

  // đếm số câu trong máy (dùng để kiểm tra đã nạp gói chưa)
  Future<int> countQuestions() async {
    final count = db.questions.id.count();
    final row = await (db.selectOnly(
      db.questions,
    )..addColumns([count])).getSingle();
    return row.read(count) ?? 0;
  }
}
