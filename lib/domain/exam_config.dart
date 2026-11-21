// Cấu hình đề thi của 1 hạng bằng (lấy từ gói catalog / API).

// Một "slot" là một nhóm câu trong đề, vd: 8 câu về quy tắc giao thông
class ExamSlot {
  const ExamSlot({
    required this.label,
    required this.categoryCodes,
    required this.critical,
    required this.count,
  });

  final String label;
  final List<String> categoryCodes;
  final bool critical; // true thì lấy câu điểm liệt
  final int count;

  // đọc từ JSON
  factory ExamSlot.fromJson(Map<String, dynamic> json) {
    return ExamSlot(
      label: json['label'] as String,
      categoryCodes: (json['categoryCodes'] as List).cast<String>(),
      critical: json['critical'] as bool,
      count: json['count'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'label': label,
    'categoryCodes': categoryCodes,
    'critical': critical,
    'count': count,
  };
}

class ExamConfig {
  const ExamConfig({
    required this.totalQuestions,
    required this.passScore,
    required this.durationMinutes,
    required this.slots,
  });

  final int totalQuestions;
  final int passScore; // số câu đúng tối thiểu để đậu
  final int durationMinutes;
  final List<ExamSlot> slots;

  factory ExamConfig.fromJson(Map<String, dynamic> json) {
    final slots = (json['slots'] as List)
        .map((s) => ExamSlot.fromJson(Map<String, dynamic>.from(s as Map)))
        .toList();
    return ExamConfig(
      totalQuestions: json['totalQuestions'] as int,
      passScore: json['passScore'] as int,
      durationMinutes: json['durationMinutes'] as int,
      slots: slots,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalQuestions': totalQuestions,
    'passScore': passScore,
    'durationMinutes': durationMinutes,
    'slots': slots.map((s) => s.toJson()).toList(),
  };
}
