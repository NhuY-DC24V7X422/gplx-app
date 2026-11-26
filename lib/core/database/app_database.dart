import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Questions extends Table {
  TextColumn get id => text()(); // trùng _id trên MongoDB
  IntColumn get number => integer().unique()(); // số câu 1..600
  TextColumn get content => text()();
  TextColumn get searchText => text()(); // nội dung bỏ dấu để tìm kiếm
  TextColumn get imageUrl => text().nullable()();
  TextColumn get imageHash => text().nullable()();

  // ảnh trong máy: 'asset:images/q_32.png' (ảnh đóng kèm) hoặc đường dẫn file đã tải về
  TextColumn get localImagePath => text().nullable()();

  // SQLite không có kiểu mảng -> lưu danh sách đáp án dạng chuỗi JSON
  TextColumn get optionsJson => text()();
  TextColumn get correctKey => text()();
  TextColumn get explanation => text().nullable()();
  TextColumn get legalRef => text().nullable()();
  TextColumn get categoryCode => text()();

  // lưu dạng ',A1,A,B,' để lọc bằng LIKE '%,A1,%'
  // (có dấu phẩy 2 đầu để 'A' không khớp nhầm với 'A1')
  TextColumn get licenseClasses => text()();
  BoolColumn get isCritical => boolean()();
  TextColumn get status => text()();
  IntColumn get version => integer()();
  DateTimeColumn get answerChangedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
  IntColumn get sortOrder =>
      integer()(); // "order" là từ khóa SQL nên đặt tên khác
  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {code};
}

// đặt tên class dòng là LicenseClassRow cho khỏi trùng với các class khác
@DataClassName('LicenseClassRow')
class LicenseClasses extends Table {
  TextColumn get code => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get examConfigJson => text()(); // cấu hình đề thi dạng JSON
  IntColumn get sortOrder => integer()();
  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {code};
}

class TrafficSigns extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()(); // vd: P.102
  TextColumn get name => text()();
  TextColumn get groupCode => text()(); // "group" là từ khóa SQL
  TextColumn get description => text()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get imageHash => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  TextColumn get searchText => text()();
  TextColumn get status => text()();
  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Penalties extends Table {
  TextColumn get id => text()();
  TextColumn get violation => text()();
  TextColumn get vehicleType => text()(); // MOTORBIKE | CAR
  IntColumn get fineMin => integer()();
  IntColumn get fineMax => integer()();
  TextColumn get additionalPenalty => text().nullable()();
  TextColumn get legalRef => text()();
  TextColumn get searchText => text()();
  TextColumn get status => text()();
  IntColumn get version => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

// =====================================================================
// PHẦN 2: Tiến độ học của người dùng (userId = null là dữ liệu của khách)
// =====================================================================

// Mỗi lần trả lời 1 câu = 1 dòng. CHỈ THÊM, không sửa/xóa.
// Tiến độ (bảng QuestionProgress) được tính lại từ bảng này bằng replay().
class AnswerEvents extends Table {
  TextColumn get clientEventId => text()(); // id do app tạo (uuid), không trùng
  TextColumn get userId => text().nullable()();
  TextColumn get questionId => text()();
  IntColumn get questionNumber => integer()();
  TextColumn get selectedKey => text().nullable()();
  BoolColumn get isCorrect => boolean()();
  IntColumn get responseMs => integer().nullable()(); // trả lời mất bao lâu
  TextColumn get source => text()(); // practice | exam | review...
  TextColumn get examClientId => text().nullable()();
  DateTimeColumn get answeredAt => dateTime()();
  TextColumn get deviceId => text()();
  IntColumn get seq =>
      integer().nullable()(); // số thứ tự server cấp khi đồng bộ
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {clientEventId};
}

// Tiến độ từng câu. Đây là bảng "dẫn xuất": xóa đi vẫn tính lại được từ AnswerEvents.
@DataClassName('ProgressRow')
class QuestionProgress extends Table {
  TextColumn get questionId => text()();
  RealColumn get ef => real()();
  IntColumn get interval => integer()();
  IntColumn get reps => integer()();
  TextColumn get dueDate => text().nullable()(); // 'YYYY-MM-DD'
  IntColumn get correctCount => integer()();
  IntColumn get wrongCount => integer()();
  IntColumn get consecutiveCorrect => integer()();
  BoolColumn get inWrongBook => boolean()();
  DateTimeColumn get lastAnsweredAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {questionId};
}

// Câu hỏi đã lưu (đánh dấu sao)
class Bookmarks extends Table {
  TextColumn get questionId => text()();
  BoolColumn get bookmarked =>
      boolean()(); // false = đã bỏ lưu (vẫn giữ dòng để đồng bộ)
  DateTimeColumn get clientUpdatedAt => dateTime()();
  TextColumn get userId => text().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {questionId};
}

// Bài thi đang làm dở (thoát app vào lại vẫn làm tiếp được)
class ExamSessions extends Table {
  TextColumn get id => text()();
  TextColumn get licenseClass => text()();
  TextColumn get mode => text()(); // mock | weak | review | critical
  TextColumn get questionIdsJson => text()();
  TextColumn get answersJson => text()();
  IntColumn get passScore => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get deadlineAt => dateTime()(); // hết giờ lúc nào
  TextColumn get status => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Bài thi đã nộp (lịch sử thi)
class ExamAttempts extends Table {
  TextColumn get clientId => text()();
  TextColumn get userId => text().nullable()();
  TextColumn get licenseClass => text()();
  TextColumn get mode => text()();

  // từng câu + bản chụp nội dung câu lúc thi (admin sửa câu sau này vẫn xem lại đúng đề cũ)
  TextColumn get itemsJson => text()();
  IntColumn get correctCount => integer()();
  IntColumn get total => integer()();
  IntColumn get passScore => integer()();
  BoolColumn get passed => boolean()();
  BoolColumn get failedByCritical => boolean()();
  IntColumn get durationSec => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get submittedAt => dateTime()();
  TextColumn get deviceId => text()();
  IntColumn get seq => integer().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {clientId};
}

// Bảng key – value cho các giá trị lẻ:
// catalogVersion, deviceId, licenseClass, syncCursor, lastSyncAt...
@DataClassName('MetaRow')
class Meta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    Questions,
    Categories,
    LicenseClasses,
    TrafficSigns,
    Penalties,
    AnswerEvents,
    QuestionProgress,
    Bookmarks,
    ExamSessions,
    ExamAttempts,
    Meta,
  ],
)
class AppDatabase extends _$AppDatabase {
  // Không truyền executor -> mở file 'gplx.sqlite' trong máy.
  // Khi test thì truyền NativeDatabase.memory() để chạy DB trong RAM.
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'gplx'));

  // Tăng số này khi đổi cấu trúc bảng (và viết thêm migration)
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll(); // tạo tất cả bảng

      // Index giúp các câu truy vấn hay dùng chạy nhanh hơn
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_events_question ON answer_events (question_id, answered_at)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_events_synced ON answer_events (synced)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_progress_due ON question_progress (due_date)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_attempts_class ON exam_attempts (license_class, submitted_at)',
      );
    },
  );

  // ----- Đọc / ghi bảng Meta -----

  Future<String?> getMeta(String key) async {
    final row = await (select(
      meta,
    )..where((m) => m.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  // value = null thì xóa key
  Future<void> setMeta(String key, String? value) async {
    if (value == null) {
      await (delete(meta)..where((m) => m.key.equals(key))).go();
    } else {
      await into(meta)
          .insertOnConflictUpdate(MetaCompanion.insert(key: key, value: value));
    }
  }

  // Xóa dữ liệu cá nhân (khi đăng xuất / xóa tài khoản), GIỮ dữ liệu câu hỏi
  Future<void> clearPersonalData() async {
    await transaction(() async {
      await delete(answerEvents).go();
      await delete(questionProgress).go();
      await delete(bookmarks).go();
      await delete(examSessions).go();
      await delete(examAttempts).go();
      await setMeta('rememberedSigns', null);
      await setMeta('syncCursor', null);
      await setMeta('lastSyncAt', null);
    });
  }
}
