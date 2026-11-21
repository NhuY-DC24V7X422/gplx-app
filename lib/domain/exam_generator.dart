import 'exam_config.dart';

// Sinh đề thi. Port từ gplx-api/src/domain/exam-generator.ts.

// Thông tin tối thiểu của 1 câu hỏi để sinh đề.

abstract class GenQuestion {
  int get number;
  String get categoryCode;
  List<String> get licenseClasses;
  bool get isCritical;
  String get status;
}

class GeneratedExam<Q extends GenQuestion> {
  GeneratedExam(this.questions, this.slotOf, this.warnings);

  final List<Q> questions;
  final Map<int, int> slotOf; // số câu -> thứ tự slot (-1 là câu lấy bù)
  final List<String> warnings;
}

// Random có seed (mulberry32)
// Giống hệt seededRandom bên TS: cùng seed thì app và server ra cùng dãy số,
// nên cùng seed sẽ ra cùng 1 đề.
// JS tính trên số nguyên 32 bit, Dart là 64 bit nên phải tự cắt về 32 bit (& _mask32).

const _mask32 = 0xFFFFFFFF;

// nhân 2 số 32 bit, chỉ giữ 32 bit thấp (giống Math.imul của JS).
// Tách a làm 2 nửa 16 bit để phép nhân không bị tràn số.
int _imul(int a, int b) {
  final low = (a & 0xFFFF) * b;
  final high = (((a >> 16) & 0xFFFF) * b) & 0xFFFF;
  return (low + (high << 16)) & _mask32;
}

double Function() seededRandom(int seed) {
  var a = seed & _mask32;
  return () {
    a = (a + 0x6D2B79F5) & _mask32;
    var t = a;
    t = _imul(t ^ (t >> 15), t | 1);
    t = (t ^ ((t + _imul(t ^ (t >> 7), t | 61)) & _mask32)) & _mask32;
    return ((t ^ (t >> 14)) & _mask32) / 4294967296;
  };
}

// Xáo trộn danh sách (Fisher-Yates), không làm thay đổi danh sách gốc
List<T> _shuffle<T>(List<T> list, double Function() random) {
  final arr = List<T>.of(list);
  for (var i = arr.length - 1; i > 0; i--) {
    final j = (random() * (i + 1)).floor();
    final tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }
  return arr;
}

// Tạo đề thi theo cấu hình của từng hạng bằng
GeneratedExam<Q> generateExam<Q extends GenQuestion>(
  List<Q> allQuestions,
  ExamConfig config,
  String licenseClass,
  double Function() random,
) {
  final used = <int>{};
  final slotOf = <int, int>{};
  final chosen = <Q>[];
  final warnings = <String>[];

  // chỉ lấy câu đang hiển thị và thuộc hạng này
  final eligible = allQuestions
      .where(
        (q) => q.status == 'active' && q.licenseClasses.contains(licenseClass),
      )
      .toList();

  var missing = 0;
  for (var index = 0; index < config.slots.length; index++) {
    final slot = config.slots[index];

    final candidates = eligible.where((q) {
      if (used.contains(q.number)) return false;
      if (slot.critical) return q.isCritical;
      return !q.isCritical && slot.categoryCodes.contains(q.categoryCode);
    }).toList();
    final picked = _shuffle(candidates, random).take(slot.count).toList();

    for (final q in picked) {
      used.add(q.number);
      slotOf[q.number] = index;
      chosen.add(q);
    }

    if (picked.length < slot.count) {
      missing += slot.count - picked.length;
      warnings.add(
        'Slot "${slot.label}" thiếu ${slot.count - picked.length} câu',
      );
    }
  }

  // slot nào thiếu câu thì lấy bù từ các câu thường còn lại
  if (missing > 0) {
    final rest = eligible
        .where((q) => !used.contains(q.number) && !q.isCritical)
        .toList();
    for (final q in _shuffle(rest, random).take(missing)) {
      used.add(q.number);
      slotOf[q.number] = -1;
      chosen.add(q);
    }
  }

  return GeneratedExam(_shuffle(chosen, random), slotOf, warnings);
}
