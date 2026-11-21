import 'dart:convert';

import '../../core/database/app_database.dart';
import '../../domain/exam_config.dart';
import '../../domain/exam_generator.dart';

// Các class dữ liệu dùng ở màn hình.
// Dòng đọc từ Drift (Question, LicenseClassRow...) còn để JSON dạng chuỗi,
// nên đổi sang class dưới đây cho dễ dùng.

const licenseCodes = ['A1', 'A', 'B'];

// tên nhóm biển báo để hiển thị
const signGroupNames = {
  'PROHIBITION': 'Biển báo cấm',
  'DANGER': 'Biển báo nguy hiểm và cảnh báo',
  'MANDATORY': 'Biển hiệu lệnh',
  'INDICATION': 'Biển chỉ dẫn',
  'AUXILIARY': 'Biển phụ',
  'OTHER': 'Khác',
};

class QuestionOption {
  const QuestionOption(this.key, this.text);

  final String key; // "1", "2", "3"...
  final String text;

  factory QuestionOption.fromJson(Map<String, dynamic> json) {
    return QuestionOption(json['key'] as String, json['text'] as String);
  }

  Map<String, dynamic> toJson() => {'key': key, 'text': text};
}

// Câu hỏi. implements GenQuestion để đưa thẳng vào generateExam() được.
class QuestionItem implements GenQuestion {
  QuestionItem({
    required this.id,
    required this.number,
    required this.content,
    required this.imageRef,
    required this.options,
    required this.correctKey,
    required this.explanation,
    required this.legalRef,
    required this.categoryCode,
    required this.licenseClasses,
    required this.isCritical,
    required this.status,
    required this.version,
    required this.answerChangedAt,
  });

  final String id;
  @override
  final int number;
  final String content;
  final String? imageRef; // 'asset:images/q_32.png' | đường dẫn file | null
  final List<QuestionOption> options;
  final String correctKey;
  final String? explanation;
  final String? legalRef;
  @override
  final String categoryCode;
  @override
  final List<String> licenseClasses;
  @override
  final bool isCritical;
  @override
  final String status;
  final int version;
  final DateTime? answerChangedAt;

  // đổi 1 dòng trong bảng questions thành QuestionItem
  factory QuestionItem.fromRow(Question row) {
    final options = (jsonDecode(row.optionsJson) as List)
        .map(
          (o) => QuestionOption.fromJson(Map<String, dynamic>.from(o as Map)),
        )
        .toList();
    // ',A1,A,B,' -> ['A1', 'A', 'B']
    final classes = row.licenseClasses
        .split(',')
        .where((s) => s.isNotEmpty)
        .toList();

    return QuestionItem(
      id: row.id,
      number: row.number,
      content: row.content,
      imageRef: row.localImagePath,
      options: options,
      correctKey: row.correctKey,
      explanation: row.explanation,
      legalRef: row.legalRef,
      categoryCode: row.categoryCode,
      licenseClasses: classes,
      isCritical: row.isCritical,
      status: row.status,
      version: row.version,
      answerChangedAt: row.answerChangedAt,
    );
  }
}

class LicenseClassInfo {
  const LicenseClassInfo({
    required this.code,
    required this.name,
    required this.description,
    required this.config,
  });

  final String code;
  final String name;
  final String description;
  final ExamConfig config;

  factory LicenseClassInfo.fromRow(LicenseClassRow row) {
    final json = Map<String, dynamic>.from(
      jsonDecode(row.examConfigJson) as Map,
    );
    return LicenseClassInfo(
      code: row.code,
      name: row.name,
      description: row.description,
      config: ExamConfig.fromJson(json),
    );
  }
}

class CategoryInfo {
  const CategoryInfo({
    required this.code,
    required this.name,
    required this.order,
  });

  final String code;
  final String name;
  final int order;
}
