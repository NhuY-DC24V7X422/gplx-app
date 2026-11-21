// Chạy cùng bộ test vector với gplx-api (test/vectors/*.json)
// để chắc chắn code Dart và code TS tính ra cùng kết quả.
// Nếu thiếu thư mục test/vectors: chạy `bash tool/sync_vectors.sh ../gplx-api`
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gplx_app/core/utils/normalize_vi.dart';
import 'package:gplx_app/core/utils/vn_date.dart';
import 'package:gplx_app/domain/exam_config.dart';
import 'package:gplx_app/domain/exam_generator.dart';
import 'package:gplx_app/domain/grade.dart';
import 'package:gplx_app/domain/prediction.dart';
import 'package:gplx_app/domain/replay.dart';
import 'package:gplx_app/domain/sm2.dart';
import 'package:gplx_app/domain/streak.dart';
import 'package:gplx_app/domain/study_plan.dart';
import 'package:gplx_app/domain/weak_topics.dart';

// đọc file vector, trả về danh sách các ca test
List<Map<String, dynamic>> loadVectors(String name) {
  final text = File('test/vectors/$name.json').readAsStringSync();
  return (jsonDecode(text) as List).cast<Map<String, dynamic>>();
}

// số trong JSON có thể là int (2) hoặc double (2.5) -> đổi hết sang double
double toDouble(dynamic x) => (x as num).toDouble();

// câu hỏi giả để test sinh đề
class FakeQuestion implements GenQuestion {
  FakeQuestion(
    this.number,
    this.categoryCode,
    this.isCritical,
    this.licenseClasses,
  );

  @override
  final int number;
  @override
  final String categoryCode;
  @override
  final bool isCritical;
  @override
  final List<String> licenseClasses;
  @override
  String get status => 'active';
}

// dựng kho câu hỏi giả từ mô tả "pool" trong vector (giống bên TS)
List<FakeQuestion> buildPool(List pool) {
  final result = <FakeQuestion>[];
  var number = 1;
  for (final p in pool) {
    final classes =
        (p['licenseClasses'] as List?)?.cast<String>() ?? ['A1', 'A', 'B'];
    for (var i = 0; i < (p['count'] as int); i++) {
      result.add(
        FakeQuestion(number++, p['categoryCode'], p['critical'], classes),
      );
    }
  }
  return result;
}

void main() {
  group('sm2', () {
    for (final c in loadVectors('sm2')) {
      test(c['name'], () {
        final s = c['input']['state'];
        final state = Sm2State(
          ef: toDouble(s['ef']),
          interval: s['interval'],
          reps: s['reps'],
        );
        final r = applySm2(state, c['input']['q']);

        expect(r.interval, c['expected']['interval']);
        expect(r.reps, c['expected']['reps']);
        expect(r.ef, closeTo(toDouble(c['expected']['ef']), 1e-9));
      });
    }
  });

  group('replay', () {
    for (final c in loadVectors('replay')) {
      test(c['name'], () {
        final events = (c['input']['events'] as List).map((e) {
          return ReplayEvent(
            clientEventId: e['clientEventId'],
            isCorrect: e['isCorrect'],
            responseMs: e['responseMs'],
            answeredAt: DateTime.parse(e['answeredAt']),
          );
        }).toList();
        final changed = c['input']['answerChangedAt'];
        final r = replay(
          events,
          changed == null ? null : DateTime.parse(changed),
        );

        final e = c['expected'];
        expect(r.correctCount, e['correctCount']);
        expect(r.wrongCount, e['wrongCount']);
        expect(r.consecutiveCorrect, e['consecutiveCorrect']);
        expect(r.inWrongBook, e['inWrongBook']);
        expect(r.interval, e['interval']);
        expect(r.reps, e['reps']);
        expect(r.dueDate, e['dueDate']);
        expect(r.ef, closeTo(toDouble(e['ef']), 1e-9));
      });
    }
  });

  group('grade', () {
    for (final c in loadVectors('grade')) {
      test(c['name'], () {
        final items = (c['input']['items'] as List).map((i) {
          return GradeItem(
            correctKey: i['correctKey'],
            selectedKey: i['selectedKey'],
            isCritical: i['isCritical'],
          );
        }).toList();
        final r = grade(items, c['input']['passScore']);

        expect(r.correctCount, c['expected']['correctCount']);
        expect(r.total, c['expected']['total']);
        expect(r.passed, c['expected']['passed']);
        expect(r.failedByCritical, c['expected']['failedByCritical']);
      });
    }
  });

  group('normalizeVi', () {
    for (final c in loadVectors('normalize')) {
      test(c['name'], () {
        expect(normalizeVi(c['input']), c['expected']);
      });
    }
  });

  group('prediction', () {
    for (final c in loadVectors('prediction')) {
      test(c['name'], () {
        final attempts = (c['input']['attempts'] as List).map((a) {
          return AttemptLike(
            correctCount: a['correctCount'],
            passScore: a['passScore'],
            failedByCritical: a['failedByCritical'],
          );
        }).toList();
        final r = predict(attempts, toDouble(c['input']['coverage']));

        expect(predictionLevelCode(r.level), c['expected']['level']);
        expect(
          r.reasons.map(predictionReasonCode).toList(),
          c['expected']['reasons'],
        );
      });
    }
  });

  group('streak', () {
    for (final c in loadVectors('streak')) {
      test(c['name'], () {
        final dayCounts = Map<String, int>.from(c['input']['dayCounts']);
        final r = computeStreak(dayCounts, c['input']['today']);

        expect(r.current, c['expected']['current']);
        expect(r.longest, c['expected']['longest']);
      });
    }
  });

  group('weak topics', () {
    for (final c in loadVectors('weak_topics')) {
      test(c['name'], () {
        final events = (c['input']['events'] as List).map((e) {
          return TopicEvent(
            categoryCode: e['categoryCode'],
            isCorrect: e['isCorrect'],
            answeredAt: DateTime.parse(e['answeredAt']),
          );
        }).toList();
        final categories = (c['input']['categories'] as List).cast<String>();
        final result = analyzeTopics(categories, events);

        (c['expected'] as Map).forEach((category, expected) {
          final r = result[category]!;
          expect(r.answered, expected['answered']);
          expect(r.enoughData, expected['enoughData']);
          expect(r.weak, expected['weak']);
          expect(r.weight, closeTo(toDouble(expected['weight']), 1e-9));
          if (expected['accuracy'] == null) {
            expect(r.accuracy, isNull);
          } else {
            expect(r.accuracy, closeTo(toDouble(expected['accuracy']), 1e-9));
          }
        });
      });
    }
  });

  group('study plan', () {
    for (final c in loadVectors('study_plan')) {
      test(c['name'], () {
        final i = c['input'];
        final r = studyPlan(
          unseen: i['unseen'],
          due: i['due'],
          examDate: i['examDate'],
          today: i['today'],
          dailyNewGoal: i['dailyNewGoal'],
        );

        final e = c['expected'];
        expect(r.daysLeft, e['daysLeft']);
        expect(r.newToday, e['newToday']);
        expect(r.reviewToday, e['reviewToday']);
        expect(r.suggestMockExam, e['suggestMockExam']);
        expect(r.askUpdateExamDate, e['askUpdateExamDate']);
      });
    }
  });

  group('exam generator', () {
    for (final c in loadVectors('exam')) {
      test(c['name'], () {
        final pool = buildPool(c['input']['pool']);
        final config = ExamConfig.fromJson(
          Map<String, dynamic>.from(c['input']['config']),
        );
        final licenseClass = c['input']['licenseClass'] as String;
        final exam = generateExam(
          pool,
          config,
          licenseClass,
          seededRandom(c['input']['seed']),
        );
        final numbers = exam.questions.map((q) => q.number).toList();

        expect(numbers.length, c['expected']['total']);
        expect(numbers.toSet().length, numbers.length); // không trùng câu
        expect(
          exam.questions.every((q) => q.licenseClasses.contains(licenseClass)),
          isTrue,
        );
        expect(
          exam.questions.where((q) => q.isCritical).length,
          c['expected']['criticalCount'],
        );
        expect(exam.warnings.length, c['expected']['warnings']);

        // số câu của từng slot
        final slotCounts = List.generate(
          config.slots.length,
          (i) => exam.slotOf.values.where((v) => v == i).length,
        );
        expect(slotCounts, c['expected']['slotCounts']);
      });
    }
  });

  // ----- Kiểm tra thêm: app và server phải ra GIỐNG HỆT nhau -----
  // Các số dưới đây lấy từ code TS (chạy bằng node) để so sánh.
  group('khớp với code TS', () {
    test('seededRandom(42) ra cùng dãy số', () {
      final random = seededRandom(42);
      expect(random(), closeTo(0.6011037519201636, 1e-15));
      expect(random(), closeTo(0.44829055899754167, 1e-15));
      expect(random(), closeTo(0.8524657934904099, 1e-15));
    });

    test('cùng seed thì ra cùng đề (vector đầu tiên, seed 42)', () {
      final c = loadVectors('exam').first;
      final pool = buildPool(c['input']['pool']);
      final config = ExamConfig.fromJson(
        Map<String, dynamic>.from(c['input']['config']),
      );
      final exam = generateExam(
        pool,
        config,
        c['input']['licenseClass'],
        seededRandom(c['input']['seed']),
      );

      expect(exam.questions.map((q) => q.number).toList(), [
        14, 17, 46, 60, 37, 51, 27, 20, 57, 7, 31, 10, 67, //
        62, 45, 69, 5, 61, 2, 49, 41, 1, 58, 40, 47,
      ]);
    });

    test('vnDay, addDays, diffDays', () {
      // 18:00 UTC ngày 20 là 01:00 sáng ngày 21 ở VN
      expect(vnDay(DateTime.utc(2026, 10, 20, 18)), '2026-10-21');
      expect(addDays('2026-12-31', 1), '2027-01-01');
      expect(addDays('2026-03-01', -1), '2026-02-28');
      expect(diffDays('2026-10-20', '2026-11-02'), 13);
    });
  });

  test('đã chép đủ test vector từ gplx-api', () {
    final files = Directory('test/vectors')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.json'))
        .toList();
    expect(files.length, greaterThanOrEqualTo(9));
    expect(
      File('test/vectors/vectors.sha1').existsSync(),
      isTrue,
      reason: 'Chạy bash tool/sync_vectors.sh ../gplx-api',
    );
  });
}
