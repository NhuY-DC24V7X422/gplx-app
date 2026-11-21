// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageHashMeta = const VerificationMeta(
    'imageHash',
  );
  @override
  late final GeneratedColumn<String> imageHash = GeneratedColumn<String>(
    'image_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localImagePathMeta = const VerificationMeta(
    'localImagePath',
  );
  @override
  late final GeneratedColumn<String> localImagePath = GeneratedColumn<String>(
    'local_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionsJsonMeta = const VerificationMeta(
    'optionsJson',
  );
  @override
  late final GeneratedColumn<String> optionsJson = GeneratedColumn<String>(
    'options_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctKeyMeta = const VerificationMeta(
    'correctKey',
  );
  @override
  late final GeneratedColumn<String> correctKey = GeneratedColumn<String>(
    'correct_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _explanationMeta = const VerificationMeta(
    'explanation',
  );
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
    'explanation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _legalRefMeta = const VerificationMeta(
    'legalRef',
  );
  @override
  late final GeneratedColumn<String> legalRef = GeneratedColumn<String>(
    'legal_ref',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryCodeMeta = const VerificationMeta(
    'categoryCode',
  );
  @override
  late final GeneratedColumn<String> categoryCode = GeneratedColumn<String>(
    'category_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseClassesMeta = const VerificationMeta(
    'licenseClasses',
  );
  @override
  late final GeneratedColumn<String> licenseClasses = GeneratedColumn<String>(
    'license_classes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCriticalMeta = const VerificationMeta(
    'isCritical',
  );
  @override
  late final GeneratedColumn<bool> isCritical = GeneratedColumn<bool>(
    'is_critical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_critical" IN (0, 1))',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answerChangedAtMeta = const VerificationMeta(
    'answerChangedAt',
  );
  @override
  late final GeneratedColumn<DateTime> answerChangedAt =
      GeneratedColumn<DateTime>(
        'answer_changed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    number,
    content,
    searchText,
    imageUrl,
    imageHash,
    localImagePath,
    optionsJson,
    correctKey,
    explanation,
    legalRef,
    categoryCode,
    licenseClasses,
    isCritical,
    status,
    version,
    answerChangedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Question> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_hash')) {
      context.handle(
        _imageHashMeta,
        imageHash.isAcceptableOrUnknown(data['image_hash']!, _imageHashMeta),
      );
    }
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
        ),
      );
    }
    if (data.containsKey('options_json')) {
      context.handle(
        _optionsJsonMeta,
        optionsJson.isAcceptableOrUnknown(
          data['options_json']!,
          _optionsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_optionsJsonMeta);
    }
    if (data.containsKey('correct_key')) {
      context.handle(
        _correctKeyMeta,
        correctKey.isAcceptableOrUnknown(data['correct_key']!, _correctKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_correctKeyMeta);
    }
    if (data.containsKey('explanation')) {
      context.handle(
        _explanationMeta,
        explanation.isAcceptableOrUnknown(
          data['explanation']!,
          _explanationMeta,
        ),
      );
    }
    if (data.containsKey('legal_ref')) {
      context.handle(
        _legalRefMeta,
        legalRef.isAcceptableOrUnknown(data['legal_ref']!, _legalRefMeta),
      );
    }
    if (data.containsKey('category_code')) {
      context.handle(
        _categoryCodeMeta,
        categoryCode.isAcceptableOrUnknown(
          data['category_code']!,
          _categoryCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoryCodeMeta);
    }
    if (data.containsKey('license_classes')) {
      context.handle(
        _licenseClassesMeta,
        licenseClasses.isAcceptableOrUnknown(
          data['license_classes']!,
          _licenseClassesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseClassesMeta);
    }
    if (data.containsKey('is_critical')) {
      context.handle(
        _isCriticalMeta,
        isCritical.isAcceptableOrUnknown(data['is_critical']!, _isCriticalMeta),
      );
    } else if (isInserting) {
      context.missing(_isCriticalMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    if (data.containsKey('answer_changed_at')) {
      context.handle(
        _answerChangedAtMeta,
        answerChangedAt.isAcceptableOrUnknown(
          data['answer_changed_at']!,
          _answerChangedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Question map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Question(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      imageHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_hash'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
      optionsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}options_json'],
      )!,
      correctKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correct_key'],
      )!,
      explanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}explanation'],
      ),
      legalRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_ref'],
      ),
      categoryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_code'],
      )!,
      licenseClasses: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_classes'],
      )!,
      isCritical: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_critical'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      answerChangedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}answer_changed_at'],
      ),
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final String id;
  final int number;
  final String content;
  final String searchText;
  final String? imageUrl;
  final String? imageHash;
  final String? localImagePath;
  final String optionsJson;
  final String correctKey;
  final String? explanation;
  final String? legalRef;
  final String categoryCode;
  final String licenseClasses;
  final bool isCritical;
  final String status;
  final int version;
  final DateTime? answerChangedAt;
  const Question({
    required this.id,
    required this.number,
    required this.content,
    required this.searchText,
    this.imageUrl,
    this.imageHash,
    this.localImagePath,
    required this.optionsJson,
    required this.correctKey,
    this.explanation,
    this.legalRef,
    required this.categoryCode,
    required this.licenseClasses,
    required this.isCritical,
    required this.status,
    required this.version,
    this.answerChangedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<int>(number);
    map['content'] = Variable<String>(content);
    map['search_text'] = Variable<String>(searchText);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || imageHash != null) {
      map['image_hash'] = Variable<String>(imageHash);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    map['options_json'] = Variable<String>(optionsJson);
    map['correct_key'] = Variable<String>(correctKey);
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    if (!nullToAbsent || legalRef != null) {
      map['legal_ref'] = Variable<String>(legalRef);
    }
    map['category_code'] = Variable<String>(categoryCode);
    map['license_classes'] = Variable<String>(licenseClasses);
    map['is_critical'] = Variable<bool>(isCritical);
    map['status'] = Variable<String>(status);
    map['version'] = Variable<int>(version);
    if (!nullToAbsent || answerChangedAt != null) {
      map['answer_changed_at'] = Variable<DateTime>(answerChangedAt);
    }
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      number: Value(number),
      content: Value(content),
      searchText: Value(searchText),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      imageHash: imageHash == null && nullToAbsent
          ? const Value.absent()
          : Value(imageHash),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      optionsJson: Value(optionsJson),
      correctKey: Value(correctKey),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      legalRef: legalRef == null && nullToAbsent
          ? const Value.absent()
          : Value(legalRef),
      categoryCode: Value(categoryCode),
      licenseClasses: Value(licenseClasses),
      isCritical: Value(isCritical),
      status: Value(status),
      version: Value(version),
      answerChangedAt: answerChangedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(answerChangedAt),
    );
  }

  factory Question.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Question(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<int>(json['number']),
      content: serializer.fromJson<String>(json['content']),
      searchText: serializer.fromJson<String>(json['searchText']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      imageHash: serializer.fromJson<String?>(json['imageHash']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      optionsJson: serializer.fromJson<String>(json['optionsJson']),
      correctKey: serializer.fromJson<String>(json['correctKey']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      legalRef: serializer.fromJson<String?>(json['legalRef']),
      categoryCode: serializer.fromJson<String>(json['categoryCode']),
      licenseClasses: serializer.fromJson<String>(json['licenseClasses']),
      isCritical: serializer.fromJson<bool>(json['isCritical']),
      status: serializer.fromJson<String>(json['status']),
      version: serializer.fromJson<int>(json['version']),
      answerChangedAt: serializer.fromJson<DateTime?>(json['answerChangedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<int>(number),
      'content': serializer.toJson<String>(content),
      'searchText': serializer.toJson<String>(searchText),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'imageHash': serializer.toJson<String?>(imageHash),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'optionsJson': serializer.toJson<String>(optionsJson),
      'correctKey': serializer.toJson<String>(correctKey),
      'explanation': serializer.toJson<String?>(explanation),
      'legalRef': serializer.toJson<String?>(legalRef),
      'categoryCode': serializer.toJson<String>(categoryCode),
      'licenseClasses': serializer.toJson<String>(licenseClasses),
      'isCritical': serializer.toJson<bool>(isCritical),
      'status': serializer.toJson<String>(status),
      'version': serializer.toJson<int>(version),
      'answerChangedAt': serializer.toJson<DateTime?>(answerChangedAt),
    };
  }

  Question copyWith({
    String? id,
    int? number,
    String? content,
    String? searchText,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> imageHash = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    String? optionsJson,
    String? correctKey,
    Value<String?> explanation = const Value.absent(),
    Value<String?> legalRef = const Value.absent(),
    String? categoryCode,
    String? licenseClasses,
    bool? isCritical,
    String? status,
    int? version,
    Value<DateTime?> answerChangedAt = const Value.absent(),
  }) => Question(
    id: id ?? this.id,
    number: number ?? this.number,
    content: content ?? this.content,
    searchText: searchText ?? this.searchText,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    imageHash: imageHash.present ? imageHash.value : this.imageHash,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    optionsJson: optionsJson ?? this.optionsJson,
    correctKey: correctKey ?? this.correctKey,
    explanation: explanation.present ? explanation.value : this.explanation,
    legalRef: legalRef.present ? legalRef.value : this.legalRef,
    categoryCode: categoryCode ?? this.categoryCode,
    licenseClasses: licenseClasses ?? this.licenseClasses,
    isCritical: isCritical ?? this.isCritical,
    status: status ?? this.status,
    version: version ?? this.version,
    answerChangedAt: answerChangedAt.present
        ? answerChangedAt.value
        : this.answerChangedAt,
  );
  Question copyWithCompanion(QuestionsCompanion data) {
    return Question(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      content: data.content.present ? data.content.value : this.content,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageHash: data.imageHash.present ? data.imageHash.value : this.imageHash,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      optionsJson: data.optionsJson.present
          ? data.optionsJson.value
          : this.optionsJson,
      correctKey: data.correctKey.present
          ? data.correctKey.value
          : this.correctKey,
      explanation: data.explanation.present
          ? data.explanation.value
          : this.explanation,
      legalRef: data.legalRef.present ? data.legalRef.value : this.legalRef,
      categoryCode: data.categoryCode.present
          ? data.categoryCode.value
          : this.categoryCode,
      licenseClasses: data.licenseClasses.present
          ? data.licenseClasses.value
          : this.licenseClasses,
      isCritical: data.isCritical.present
          ? data.isCritical.value
          : this.isCritical,
      status: data.status.present ? data.status.value : this.status,
      version: data.version.present ? data.version.value : this.version,
      answerChangedAt: data.answerChangedAt.present
          ? data.answerChangedAt.value
          : this.answerChangedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('content: $content, ')
          ..write('searchText: $searchText, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageHash: $imageHash, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('correctKey: $correctKey, ')
          ..write('explanation: $explanation, ')
          ..write('legalRef: $legalRef, ')
          ..write('categoryCode: $categoryCode, ')
          ..write('licenseClasses: $licenseClasses, ')
          ..write('isCritical: $isCritical, ')
          ..write('status: $status, ')
          ..write('version: $version, ')
          ..write('answerChangedAt: $answerChangedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    number,
    content,
    searchText,
    imageUrl,
    imageHash,
    localImagePath,
    optionsJson,
    correctKey,
    explanation,
    legalRef,
    categoryCode,
    licenseClasses,
    isCritical,
    status,
    version,
    answerChangedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Question &&
          other.id == this.id &&
          other.number == this.number &&
          other.content == this.content &&
          other.searchText == this.searchText &&
          other.imageUrl == this.imageUrl &&
          other.imageHash == this.imageHash &&
          other.localImagePath == this.localImagePath &&
          other.optionsJson == this.optionsJson &&
          other.correctKey == this.correctKey &&
          other.explanation == this.explanation &&
          other.legalRef == this.legalRef &&
          other.categoryCode == this.categoryCode &&
          other.licenseClasses == this.licenseClasses &&
          other.isCritical == this.isCritical &&
          other.status == this.status &&
          other.version == this.version &&
          other.answerChangedAt == this.answerChangedAt);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<String> id;
  final Value<int> number;
  final Value<String> content;
  final Value<String> searchText;
  final Value<String?> imageUrl;
  final Value<String?> imageHash;
  final Value<String?> localImagePath;
  final Value<String> optionsJson;
  final Value<String> correctKey;
  final Value<String?> explanation;
  final Value<String?> legalRef;
  final Value<String> categoryCode;
  final Value<String> licenseClasses;
  final Value<bool> isCritical;
  final Value<String> status;
  final Value<int> version;
  final Value<DateTime?> answerChangedAt;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.content = const Value.absent(),
    this.searchText = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.optionsJson = const Value.absent(),
    this.correctKey = const Value.absent(),
    this.explanation = const Value.absent(),
    this.legalRef = const Value.absent(),
    this.categoryCode = const Value.absent(),
    this.licenseClasses = const Value.absent(),
    this.isCritical = const Value.absent(),
    this.status = const Value.absent(),
    this.version = const Value.absent(),
    this.answerChangedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String id,
    required int number,
    required String content,
    required String searchText,
    this.imageUrl = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.localImagePath = const Value.absent(),
    required String optionsJson,
    required String correctKey,
    this.explanation = const Value.absent(),
    this.legalRef = const Value.absent(),
    required String categoryCode,
    required String licenseClasses,
    required bool isCritical,
    required String status,
    required int version,
    this.answerChangedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       number = Value(number),
       content = Value(content),
       searchText = Value(searchText),
       optionsJson = Value(optionsJson),
       correctKey = Value(correctKey),
       categoryCode = Value(categoryCode),
       licenseClasses = Value(licenseClasses),
       isCritical = Value(isCritical),
       status = Value(status),
       version = Value(version);
  static Insertable<Question> custom({
    Expression<String>? id,
    Expression<int>? number,
    Expression<String>? content,
    Expression<String>? searchText,
    Expression<String>? imageUrl,
    Expression<String>? imageHash,
    Expression<String>? localImagePath,
    Expression<String>? optionsJson,
    Expression<String>? correctKey,
    Expression<String>? explanation,
    Expression<String>? legalRef,
    Expression<String>? categoryCode,
    Expression<String>? licenseClasses,
    Expression<bool>? isCritical,
    Expression<String>? status,
    Expression<int>? version,
    Expression<DateTime>? answerChangedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (content != null) 'content': content,
      if (searchText != null) 'search_text': searchText,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageHash != null) 'image_hash': imageHash,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (optionsJson != null) 'options_json': optionsJson,
      if (correctKey != null) 'correct_key': correctKey,
      if (explanation != null) 'explanation': explanation,
      if (legalRef != null) 'legal_ref': legalRef,
      if (categoryCode != null) 'category_code': categoryCode,
      if (licenseClasses != null) 'license_classes': licenseClasses,
      if (isCritical != null) 'is_critical': isCritical,
      if (status != null) 'status': status,
      if (version != null) 'version': version,
      if (answerChangedAt != null) 'answer_changed_at': answerChangedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith({
    Value<String>? id,
    Value<int>? number,
    Value<String>? content,
    Value<String>? searchText,
    Value<String?>? imageUrl,
    Value<String?>? imageHash,
    Value<String?>? localImagePath,
    Value<String>? optionsJson,
    Value<String>? correctKey,
    Value<String?>? explanation,
    Value<String?>? legalRef,
    Value<String>? categoryCode,
    Value<String>? licenseClasses,
    Value<bool>? isCritical,
    Value<String>? status,
    Value<int>? version,
    Value<DateTime?>? answerChangedAt,
    Value<int>? rowid,
  }) {
    return QuestionsCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      content: content ?? this.content,
      searchText: searchText ?? this.searchText,
      imageUrl: imageUrl ?? this.imageUrl,
      imageHash: imageHash ?? this.imageHash,
      localImagePath: localImagePath ?? this.localImagePath,
      optionsJson: optionsJson ?? this.optionsJson,
      correctKey: correctKey ?? this.correctKey,
      explanation: explanation ?? this.explanation,
      legalRef: legalRef ?? this.legalRef,
      categoryCode: categoryCode ?? this.categoryCode,
      licenseClasses: licenseClasses ?? this.licenseClasses,
      isCritical: isCritical ?? this.isCritical,
      status: status ?? this.status,
      version: version ?? this.version,
      answerChangedAt: answerChangedAt ?? this.answerChangedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageHash.present) {
      map['image_hash'] = Variable<String>(imageHash.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (optionsJson.present) {
      map['options_json'] = Variable<String>(optionsJson.value);
    }
    if (correctKey.present) {
      map['correct_key'] = Variable<String>(correctKey.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (legalRef.present) {
      map['legal_ref'] = Variable<String>(legalRef.value);
    }
    if (categoryCode.present) {
      map['category_code'] = Variable<String>(categoryCode.value);
    }
    if (licenseClasses.present) {
      map['license_classes'] = Variable<String>(licenseClasses.value);
    }
    if (isCritical.present) {
      map['is_critical'] = Variable<bool>(isCritical.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (answerChangedAt.present) {
      map['answer_changed_at'] = Variable<DateTime>(answerChangedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('content: $content, ')
          ..write('searchText: $searchText, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageHash: $imageHash, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('optionsJson: $optionsJson, ')
          ..write('correctKey: $correctKey, ')
          ..write('explanation: $explanation, ')
          ..write('legalRef: $legalRef, ')
          ..write('categoryCode: $categoryCode, ')
          ..write('licenseClasses: $licenseClasses, ')
          ..write('isCritical: $isCritical, ')
          ..write('status: $status, ')
          ..write('version: $version, ')
          ..write('answerChangedAt: $answerChangedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [code, name, sortOrder, version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String code;
  final String name;
  final int sortOrder;
  final int version;
  const Category({
    required this.code,
    required this.name,
    required this.sortOrder,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['version'] = Variable<int>(version);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      code: Value(code),
      name: Value(name),
      sortOrder: Value(sortOrder),
      version: Value(version),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'version': serializer.toJson<int>(version),
    };
  }

  Category copyWith({
    String? code,
    String? name,
    int? sortOrder,
    int? version,
  }) => Category(
    code: code ?? this.code,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    version: version ?? this.version,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name, sortOrder, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.code == this.code &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.version == this.version);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> version;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String code,
    required String name,
    required int sortOrder,
    required int version,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       sortOrder = Value(sortOrder),
       version = Value(version);
  static Insertable<Category> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LicenseClassesTable extends LicenseClasses
    with TableInfo<$LicenseClassesTable, LicenseClassRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LicenseClassesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examConfigJsonMeta = const VerificationMeta(
    'examConfigJson',
  );
  @override
  late final GeneratedColumn<String> examConfigJson = GeneratedColumn<String>(
    'exam_config_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    code,
    name,
    description,
    examConfigJson,
    sortOrder,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'license_classes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LicenseClassRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('exam_config_json')) {
      context.handle(
        _examConfigJsonMeta,
        examConfigJson.isAcceptableOrUnknown(
          data['exam_config_json']!,
          _examConfigJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_examConfigJsonMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  LicenseClassRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LicenseClassRow(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      examConfigJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_config_json'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $LicenseClassesTable createAlias(String alias) {
    return $LicenseClassesTable(attachedDatabase, alias);
  }
}

class LicenseClassRow extends DataClass implements Insertable<LicenseClassRow> {
  final String code;
  final String name;
  final String description;
  final String examConfigJson;
  final int sortOrder;
  final int version;
  const LicenseClassRow({
    required this.code,
    required this.name,
    required this.description,
    required this.examConfigJson,
    required this.sortOrder,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['exam_config_json'] = Variable<String>(examConfigJson);
    map['sort_order'] = Variable<int>(sortOrder);
    map['version'] = Variable<int>(version);
    return map;
  }

  LicenseClassesCompanion toCompanion(bool nullToAbsent) {
    return LicenseClassesCompanion(
      code: Value(code),
      name: Value(name),
      description: Value(description),
      examConfigJson: Value(examConfigJson),
      sortOrder: Value(sortOrder),
      version: Value(version),
    );
  }

  factory LicenseClassRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LicenseClassRow(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      examConfigJson: serializer.fromJson<String>(json['examConfigJson']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'examConfigJson': serializer.toJson<String>(examConfigJson),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'version': serializer.toJson<int>(version),
    };
  }

  LicenseClassRow copyWith({
    String? code,
    String? name,
    String? description,
    String? examConfigJson,
    int? sortOrder,
    int? version,
  }) => LicenseClassRow(
    code: code ?? this.code,
    name: name ?? this.name,
    description: description ?? this.description,
    examConfigJson: examConfigJson ?? this.examConfigJson,
    sortOrder: sortOrder ?? this.sortOrder,
    version: version ?? this.version,
  );
  LicenseClassRow copyWithCompanion(LicenseClassesCompanion data) {
    return LicenseClassRow(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      examConfigJson: data.examConfigJson.present
          ? data.examConfigJson.value
          : this.examConfigJson,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LicenseClassRow(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('examConfigJson: $examConfigJson, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(code, name, description, examConfigJson, sortOrder, version);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LicenseClassRow &&
          other.code == this.code &&
          other.name == this.name &&
          other.description == this.description &&
          other.examConfigJson == this.examConfigJson &&
          other.sortOrder == this.sortOrder &&
          other.version == this.version);
}

class LicenseClassesCompanion extends UpdateCompanion<LicenseClassRow> {
  final Value<String> code;
  final Value<String> name;
  final Value<String> description;
  final Value<String> examConfigJson;
  final Value<int> sortOrder;
  final Value<int> version;
  final Value<int> rowid;
  const LicenseClassesCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.examConfigJson = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LicenseClassesCompanion.insert({
    required String code,
    required String name,
    required String description,
    required String examConfigJson,
    required int sortOrder,
    required int version,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name),
       description = Value(description),
       examConfigJson = Value(examConfigJson),
       sortOrder = Value(sortOrder),
       version = Value(version);
  static Insertable<LicenseClassRow> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? examConfigJson,
    Expression<int>? sortOrder,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (examConfigJson != null) 'exam_config_json': examConfigJson,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LicenseClassesCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<String>? description,
    Value<String>? examConfigJson,
    Value<int>? sortOrder,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return LicenseClassesCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      description: description ?? this.description,
      examConfigJson: examConfigJson ?? this.examConfigJson,
      sortOrder: sortOrder ?? this.sortOrder,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (examConfigJson.present) {
      map['exam_config_json'] = Variable<String>(examConfigJson.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LicenseClassesCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('examConfigJson: $examConfigJson, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrafficSignsTable extends TrafficSigns
    with TableInfo<$TrafficSignsTable, TrafficSign> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrafficSignsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupCodeMeta = const VerificationMeta(
    'groupCode',
  );
  @override
  late final GeneratedColumn<String> groupCode = GeneratedColumn<String>(
    'group_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageHashMeta = const VerificationMeta(
    'imageHash',
  );
  @override
  late final GeneratedColumn<String> imageHash = GeneratedColumn<String>(
    'image_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localImagePathMeta = const VerificationMeta(
    'localImagePath',
  );
  @override
  late final GeneratedColumn<String> localImagePath = GeneratedColumn<String>(
    'local_image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    code,
    name,
    groupCode,
    description,
    imageUrl,
    imageHash,
    localImagePath,
    searchText,
    status,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'traffic_signs';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrafficSign> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('group_code')) {
      context.handle(
        _groupCodeMeta,
        groupCode.isAcceptableOrUnknown(data['group_code']!, _groupCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_groupCodeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('image_hash')) {
      context.handle(
        _imageHashMeta,
        imageHash.isAcceptableOrUnknown(data['image_hash']!, _imageHashMeta),
      );
    }
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
        ),
      );
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrafficSign map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrafficSign(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      groupCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      imageHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_hash'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $TrafficSignsTable createAlias(String alias) {
    return $TrafficSignsTable(attachedDatabase, alias);
  }
}

class TrafficSign extends DataClass implements Insertable<TrafficSign> {
  final String id;
  final String code;
  final String name;
  final String groupCode;
  final String description;
  final String? imageUrl;
  final String? imageHash;
  final String? localImagePath;
  final String searchText;
  final String status;
  final int version;
  const TrafficSign({
    required this.id,
    required this.code,
    required this.name,
    required this.groupCode,
    required this.description,
    this.imageUrl,
    this.imageHash,
    this.localImagePath,
    required this.searchText,
    required this.status,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['group_code'] = Variable<String>(groupCode);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || imageHash != null) {
      map['image_hash'] = Variable<String>(imageHash);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    map['search_text'] = Variable<String>(searchText);
    map['status'] = Variable<String>(status);
    map['version'] = Variable<int>(version);
    return map;
  }

  TrafficSignsCompanion toCompanion(bool nullToAbsent) {
    return TrafficSignsCompanion(
      id: Value(id),
      code: Value(code),
      name: Value(name),
      groupCode: Value(groupCode),
      description: Value(description),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      imageHash: imageHash == null && nullToAbsent
          ? const Value.absent()
          : Value(imageHash),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      searchText: Value(searchText),
      status: Value(status),
      version: Value(version),
    );
  }

  factory TrafficSign.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrafficSign(
      id: serializer.fromJson<String>(json['id']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      groupCode: serializer.fromJson<String>(json['groupCode']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      imageHash: serializer.fromJson<String?>(json['imageHash']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      searchText: serializer.fromJson<String>(json['searchText']),
      status: serializer.fromJson<String>(json['status']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'groupCode': serializer.toJson<String>(groupCode),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'imageHash': serializer.toJson<String?>(imageHash),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'searchText': serializer.toJson<String>(searchText),
      'status': serializer.toJson<String>(status),
      'version': serializer.toJson<int>(version),
    };
  }

  TrafficSign copyWith({
    String? id,
    String? code,
    String? name,
    String? groupCode,
    String? description,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> imageHash = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    String? searchText,
    String? status,
    int? version,
  }) => TrafficSign(
    id: id ?? this.id,
    code: code ?? this.code,
    name: name ?? this.name,
    groupCode: groupCode ?? this.groupCode,
    description: description ?? this.description,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    imageHash: imageHash.present ? imageHash.value : this.imageHash,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    searchText: searchText ?? this.searchText,
    status: status ?? this.status,
    version: version ?? this.version,
  );
  TrafficSign copyWithCompanion(TrafficSignsCompanion data) {
    return TrafficSign(
      id: data.id.present ? data.id.value : this.id,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      groupCode: data.groupCode.present ? data.groupCode.value : this.groupCode,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      imageHash: data.imageHash.present ? data.imageHash.value : this.imageHash,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      status: data.status.present ? data.status.value : this.status,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrafficSign(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupCode: $groupCode, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageHash: $imageHash, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('searchText: $searchText, ')
          ..write('status: $status, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    code,
    name,
    groupCode,
    description,
    imageUrl,
    imageHash,
    localImagePath,
    searchText,
    status,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrafficSign &&
          other.id == this.id &&
          other.code == this.code &&
          other.name == this.name &&
          other.groupCode == this.groupCode &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.imageHash == this.imageHash &&
          other.localImagePath == this.localImagePath &&
          other.searchText == this.searchText &&
          other.status == this.status &&
          other.version == this.version);
}

class TrafficSignsCompanion extends UpdateCompanion<TrafficSign> {
  final Value<String> id;
  final Value<String> code;
  final Value<String> name;
  final Value<String> groupCode;
  final Value<String> description;
  final Value<String?> imageUrl;
  final Value<String?> imageHash;
  final Value<String?> localImagePath;
  final Value<String> searchText;
  final Value<String> status;
  final Value<int> version;
  final Value<int> rowid;
  const TrafficSignsCompanion({
    this.id = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.groupCode = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.searchText = const Value.absent(),
    this.status = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrafficSignsCompanion.insert({
    required String id,
    required String code,
    required String name,
    required String groupCode,
    required String description,
    this.imageUrl = const Value.absent(),
    this.imageHash = const Value.absent(),
    this.localImagePath = const Value.absent(),
    required String searchText,
    required String status,
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       code = Value(code),
       name = Value(name),
       groupCode = Value(groupCode),
       description = Value(description),
       searchText = Value(searchText),
       status = Value(status),
       version = Value(version);
  static Insertable<TrafficSign> custom({
    Expression<String>? id,
    Expression<String>? code,
    Expression<String>? name,
    Expression<String>? groupCode,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? imageHash,
    Expression<String>? localImagePath,
    Expression<String>? searchText,
    Expression<String>? status,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (groupCode != null) 'group_code': groupCode,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (imageHash != null) 'image_hash': imageHash,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (searchText != null) 'search_text': searchText,
      if (status != null) 'status': status,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrafficSignsCompanion copyWith({
    Value<String>? id,
    Value<String>? code,
    Value<String>? name,
    Value<String>? groupCode,
    Value<String>? description,
    Value<String?>? imageUrl,
    Value<String?>? imageHash,
    Value<String?>? localImagePath,
    Value<String>? searchText,
    Value<String>? status,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return TrafficSignsCompanion(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      groupCode: groupCode ?? this.groupCode,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageHash: imageHash ?? this.imageHash,
      localImagePath: localImagePath ?? this.localImagePath,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (groupCode.present) {
      map['group_code'] = Variable<String>(groupCode.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (imageHash.present) {
      map['image_hash'] = Variable<String>(imageHash.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrafficSignsCompanion(')
          ..write('id: $id, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('groupCode: $groupCode, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('imageHash: $imageHash, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('searchText: $searchText, ')
          ..write('status: $status, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PenaltiesTable extends Penalties
    with TableInfo<$PenaltiesTable, Penalty> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PenaltiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _violationMeta = const VerificationMeta(
    'violation',
  );
  @override
  late final GeneratedColumn<String> violation = GeneratedColumn<String>(
    'violation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleTypeMeta = const VerificationMeta(
    'vehicleType',
  );
  @override
  late final GeneratedColumn<String> vehicleType = GeneratedColumn<String>(
    'vehicle_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fineMinMeta = const VerificationMeta(
    'fineMin',
  );
  @override
  late final GeneratedColumn<int> fineMin = GeneratedColumn<int>(
    'fine_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fineMaxMeta = const VerificationMeta(
    'fineMax',
  );
  @override
  late final GeneratedColumn<int> fineMax = GeneratedColumn<int>(
    'fine_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _additionalPenaltyMeta = const VerificationMeta(
    'additionalPenalty',
  );
  @override
  late final GeneratedColumn<String> additionalPenalty =
      GeneratedColumn<String>(
        'additional_penalty',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _legalRefMeta = const VerificationMeta(
    'legalRef',
  );
  @override
  late final GeneratedColumn<String> legalRef = GeneratedColumn<String>(
    'legal_ref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    violation,
    vehicleType,
    fineMin,
    fineMax,
    additionalPenalty,
    legalRef,
    searchText,
    status,
    version,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'penalties';
  @override
  VerificationContext validateIntegrity(
    Insertable<Penalty> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('violation')) {
      context.handle(
        _violationMeta,
        violation.isAcceptableOrUnknown(data['violation']!, _violationMeta),
      );
    } else if (isInserting) {
      context.missing(_violationMeta);
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
        _vehicleTypeMeta,
        vehicleType.isAcceptableOrUnknown(
          data['vehicle_type']!,
          _vehicleTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vehicleTypeMeta);
    }
    if (data.containsKey('fine_min')) {
      context.handle(
        _fineMinMeta,
        fineMin.isAcceptableOrUnknown(data['fine_min']!, _fineMinMeta),
      );
    } else if (isInserting) {
      context.missing(_fineMinMeta);
    }
    if (data.containsKey('fine_max')) {
      context.handle(
        _fineMaxMeta,
        fineMax.isAcceptableOrUnknown(data['fine_max']!, _fineMaxMeta),
      );
    } else if (isInserting) {
      context.missing(_fineMaxMeta);
    }
    if (data.containsKey('additional_penalty')) {
      context.handle(
        _additionalPenaltyMeta,
        additionalPenalty.isAcceptableOrUnknown(
          data['additional_penalty']!,
          _additionalPenaltyMeta,
        ),
      );
    }
    if (data.containsKey('legal_ref')) {
      context.handle(
        _legalRefMeta,
        legalRef.isAcceptableOrUnknown(data['legal_ref']!, _legalRefMeta),
      );
    } else if (isInserting) {
      context.missing(_legalRefMeta);
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    } else if (isInserting) {
      context.missing(_searchTextMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Penalty map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Penalty(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      violation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}violation'],
      )!,
      vehicleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_type'],
      )!,
      fineMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fine_min'],
      )!,
      fineMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fine_max'],
      )!,
      additionalPenalty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}additional_penalty'],
      ),
      legalRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_ref'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
    );
  }

  @override
  $PenaltiesTable createAlias(String alias) {
    return $PenaltiesTable(attachedDatabase, alias);
  }
}

class Penalty extends DataClass implements Insertable<Penalty> {
  final String id;
  final String violation;
  final String vehicleType;
  final int fineMin;
  final int fineMax;
  final String? additionalPenalty;
  final String legalRef;
  final String searchText;
  final String status;
  final int version;
  const Penalty({
    required this.id,
    required this.violation,
    required this.vehicleType,
    required this.fineMin,
    required this.fineMax,
    this.additionalPenalty,
    required this.legalRef,
    required this.searchText,
    required this.status,
    required this.version,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['violation'] = Variable<String>(violation);
    map['vehicle_type'] = Variable<String>(vehicleType);
    map['fine_min'] = Variable<int>(fineMin);
    map['fine_max'] = Variable<int>(fineMax);
    if (!nullToAbsent || additionalPenalty != null) {
      map['additional_penalty'] = Variable<String>(additionalPenalty);
    }
    map['legal_ref'] = Variable<String>(legalRef);
    map['search_text'] = Variable<String>(searchText);
    map['status'] = Variable<String>(status);
    map['version'] = Variable<int>(version);
    return map;
  }

  PenaltiesCompanion toCompanion(bool nullToAbsent) {
    return PenaltiesCompanion(
      id: Value(id),
      violation: Value(violation),
      vehicleType: Value(vehicleType),
      fineMin: Value(fineMin),
      fineMax: Value(fineMax),
      additionalPenalty: additionalPenalty == null && nullToAbsent
          ? const Value.absent()
          : Value(additionalPenalty),
      legalRef: Value(legalRef),
      searchText: Value(searchText),
      status: Value(status),
      version: Value(version),
    );
  }

  factory Penalty.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Penalty(
      id: serializer.fromJson<String>(json['id']),
      violation: serializer.fromJson<String>(json['violation']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
      fineMin: serializer.fromJson<int>(json['fineMin']),
      fineMax: serializer.fromJson<int>(json['fineMax']),
      additionalPenalty: serializer.fromJson<String?>(
        json['additionalPenalty'],
      ),
      legalRef: serializer.fromJson<String>(json['legalRef']),
      searchText: serializer.fromJson<String>(json['searchText']),
      status: serializer.fromJson<String>(json['status']),
      version: serializer.fromJson<int>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'violation': serializer.toJson<String>(violation),
      'vehicleType': serializer.toJson<String>(vehicleType),
      'fineMin': serializer.toJson<int>(fineMin),
      'fineMax': serializer.toJson<int>(fineMax),
      'additionalPenalty': serializer.toJson<String?>(additionalPenalty),
      'legalRef': serializer.toJson<String>(legalRef),
      'searchText': serializer.toJson<String>(searchText),
      'status': serializer.toJson<String>(status),
      'version': serializer.toJson<int>(version),
    };
  }

  Penalty copyWith({
    String? id,
    String? violation,
    String? vehicleType,
    int? fineMin,
    int? fineMax,
    Value<String?> additionalPenalty = const Value.absent(),
    String? legalRef,
    String? searchText,
    String? status,
    int? version,
  }) => Penalty(
    id: id ?? this.id,
    violation: violation ?? this.violation,
    vehicleType: vehicleType ?? this.vehicleType,
    fineMin: fineMin ?? this.fineMin,
    fineMax: fineMax ?? this.fineMax,
    additionalPenalty: additionalPenalty.present
        ? additionalPenalty.value
        : this.additionalPenalty,
    legalRef: legalRef ?? this.legalRef,
    searchText: searchText ?? this.searchText,
    status: status ?? this.status,
    version: version ?? this.version,
  );
  Penalty copyWithCompanion(PenaltiesCompanion data) {
    return Penalty(
      id: data.id.present ? data.id.value : this.id,
      violation: data.violation.present ? data.violation.value : this.violation,
      vehicleType: data.vehicleType.present
          ? data.vehicleType.value
          : this.vehicleType,
      fineMin: data.fineMin.present ? data.fineMin.value : this.fineMin,
      fineMax: data.fineMax.present ? data.fineMax.value : this.fineMax,
      additionalPenalty: data.additionalPenalty.present
          ? data.additionalPenalty.value
          : this.additionalPenalty,
      legalRef: data.legalRef.present ? data.legalRef.value : this.legalRef,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      status: data.status.present ? data.status.value : this.status,
      version: data.version.present ? data.version.value : this.version,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Penalty(')
          ..write('id: $id, ')
          ..write('violation: $violation, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('fineMin: $fineMin, ')
          ..write('fineMax: $fineMax, ')
          ..write('additionalPenalty: $additionalPenalty, ')
          ..write('legalRef: $legalRef, ')
          ..write('searchText: $searchText, ')
          ..write('status: $status, ')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    violation,
    vehicleType,
    fineMin,
    fineMax,
    additionalPenalty,
    legalRef,
    searchText,
    status,
    version,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Penalty &&
          other.id == this.id &&
          other.violation == this.violation &&
          other.vehicleType == this.vehicleType &&
          other.fineMin == this.fineMin &&
          other.fineMax == this.fineMax &&
          other.additionalPenalty == this.additionalPenalty &&
          other.legalRef == this.legalRef &&
          other.searchText == this.searchText &&
          other.status == this.status &&
          other.version == this.version);
}

class PenaltiesCompanion extends UpdateCompanion<Penalty> {
  final Value<String> id;
  final Value<String> violation;
  final Value<String> vehicleType;
  final Value<int> fineMin;
  final Value<int> fineMax;
  final Value<String?> additionalPenalty;
  final Value<String> legalRef;
  final Value<String> searchText;
  final Value<String> status;
  final Value<int> version;
  final Value<int> rowid;
  const PenaltiesCompanion({
    this.id = const Value.absent(),
    this.violation = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.fineMin = const Value.absent(),
    this.fineMax = const Value.absent(),
    this.additionalPenalty = const Value.absent(),
    this.legalRef = const Value.absent(),
    this.searchText = const Value.absent(),
    this.status = const Value.absent(),
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PenaltiesCompanion.insert({
    required String id,
    required String violation,
    required String vehicleType,
    required int fineMin,
    required int fineMax,
    this.additionalPenalty = const Value.absent(),
    required String legalRef,
    required String searchText,
    required String status,
    required int version,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       violation = Value(violation),
       vehicleType = Value(vehicleType),
       fineMin = Value(fineMin),
       fineMax = Value(fineMax),
       legalRef = Value(legalRef),
       searchText = Value(searchText),
       status = Value(status),
       version = Value(version);
  static Insertable<Penalty> custom({
    Expression<String>? id,
    Expression<String>? violation,
    Expression<String>? vehicleType,
    Expression<int>? fineMin,
    Expression<int>? fineMax,
    Expression<String>? additionalPenalty,
    Expression<String>? legalRef,
    Expression<String>? searchText,
    Expression<String>? status,
    Expression<int>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (violation != null) 'violation': violation,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (fineMin != null) 'fine_min': fineMin,
      if (fineMax != null) 'fine_max': fineMax,
      if (additionalPenalty != null) 'additional_penalty': additionalPenalty,
      if (legalRef != null) 'legal_ref': legalRef,
      if (searchText != null) 'search_text': searchText,
      if (status != null) 'status': status,
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PenaltiesCompanion copyWith({
    Value<String>? id,
    Value<String>? violation,
    Value<String>? vehicleType,
    Value<int>? fineMin,
    Value<int>? fineMax,
    Value<String?>? additionalPenalty,
    Value<String>? legalRef,
    Value<String>? searchText,
    Value<String>? status,
    Value<int>? version,
    Value<int>? rowid,
  }) {
    return PenaltiesCompanion(
      id: id ?? this.id,
      violation: violation ?? this.violation,
      vehicleType: vehicleType ?? this.vehicleType,
      fineMin: fineMin ?? this.fineMin,
      fineMax: fineMax ?? this.fineMax,
      additionalPenalty: additionalPenalty ?? this.additionalPenalty,
      legalRef: legalRef ?? this.legalRef,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (violation.present) {
      map['violation'] = Variable<String>(violation.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (fineMin.present) {
      map['fine_min'] = Variable<int>(fineMin.value);
    }
    if (fineMax.present) {
      map['fine_max'] = Variable<int>(fineMax.value);
    }
    if (additionalPenalty.present) {
      map['additional_penalty'] = Variable<String>(additionalPenalty.value);
    }
    if (legalRef.present) {
      map['legal_ref'] = Variable<String>(legalRef.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PenaltiesCompanion(')
          ..write('id: $id, ')
          ..write('violation: $violation, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('fineMin: $fineMin, ')
          ..write('fineMax: $fineMax, ')
          ..write('additionalPenalty: $additionalPenalty, ')
          ..write('legalRef: $legalRef, ')
          ..write('searchText: $searchText, ')
          ..write('status: $status, ')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnswerEventsTable extends AnswerEvents
    with TableInfo<$AnswerEventsTable, AnswerEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswerEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientEventIdMeta = const VerificationMeta(
    'clientEventId',
  );
  @override
  late final GeneratedColumn<String> clientEventId = GeneratedColumn<String>(
    'client_event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionNumberMeta = const VerificationMeta(
    'questionNumber',
  );
  @override
  late final GeneratedColumn<int> questionNumber = GeneratedColumn<int>(
    'question_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedKeyMeta = const VerificationMeta(
    'selectedKey',
  );
  @override
  late final GeneratedColumn<String> selectedKey = GeneratedColumn<String>(
    'selected_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _responseMsMeta = const VerificationMeta(
    'responseMs',
  );
  @override
  late final GeneratedColumn<int> responseMs = GeneratedColumn<int>(
    'response_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _examClientIdMeta = const VerificationMeta(
    'examClientId',
  );
  @override
  late final GeneratedColumn<String> examClientId = GeneratedColumn<String>(
    'exam_client_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _answeredAtMeta = const VerificationMeta(
    'answeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> answeredAt = GeneratedColumn<DateTime>(
    'answered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientEventId,
    userId,
    questionId,
    questionNumber,
    selectedKey,
    isCorrect,
    responseMs,
    source,
    examClientId,
    answeredAt,
    deviceId,
    seq,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'answer_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnswerEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_event_id')) {
      context.handle(
        _clientEventIdMeta,
        clientEventId.isAcceptableOrUnknown(
          data['client_event_id']!,
          _clientEventIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientEventIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('question_number')) {
      context.handle(
        _questionNumberMeta,
        questionNumber.isAcceptableOrUnknown(
          data['question_number']!,
          _questionNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionNumberMeta);
    }
    if (data.containsKey('selected_key')) {
      context.handle(
        _selectedKeyMeta,
        selectedKey.isAcceptableOrUnknown(
          data['selected_key']!,
          _selectedKeyMeta,
        ),
      );
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('response_ms')) {
      context.handle(
        _responseMsMeta,
        responseMs.isAcceptableOrUnknown(data['response_ms']!, _responseMsMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('exam_client_id')) {
      context.handle(
        _examClientIdMeta,
        examClientId.isAcceptableOrUnknown(
          data['exam_client_id']!,
          _examClientIdMeta,
        ),
      );
    }
    if (data.containsKey('answered_at')) {
      context.handle(
        _answeredAtMeta,
        answeredAt.isAcceptableOrUnknown(data['answered_at']!, _answeredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_answeredAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientEventId};
  @override
  AnswerEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerEvent(
      clientEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_event_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      questionNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}question_number'],
      )!,
      selectedKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_key'],
      ),
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      responseMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}response_ms'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      examClientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exam_client_id'],
      ),
      answeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}answered_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $AnswerEventsTable createAlias(String alias) {
    return $AnswerEventsTable(attachedDatabase, alias);
  }
}

class AnswerEvent extends DataClass implements Insertable<AnswerEvent> {
  final String clientEventId;
  final String? userId;
  final String questionId;
  final int questionNumber;
  final String? selectedKey;
  final bool isCorrect;
  final int? responseMs;
  final String source;
  final String? examClientId;
  final DateTime answeredAt;
  final String deviceId;
  final int? seq;
  final bool synced;
  const AnswerEvent({
    required this.clientEventId,
    this.userId,
    required this.questionId,
    required this.questionNumber,
    this.selectedKey,
    required this.isCorrect,
    this.responseMs,
    required this.source,
    this.examClientId,
    required this.answeredAt,
    required this.deviceId,
    this.seq,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_event_id'] = Variable<String>(clientEventId);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['question_id'] = Variable<String>(questionId);
    map['question_number'] = Variable<int>(questionNumber);
    if (!nullToAbsent || selectedKey != null) {
      map['selected_key'] = Variable<String>(selectedKey);
    }
    map['is_correct'] = Variable<bool>(isCorrect);
    if (!nullToAbsent || responseMs != null) {
      map['response_ms'] = Variable<int>(responseMs);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || examClientId != null) {
      map['exam_client_id'] = Variable<String>(examClientId);
    }
    map['answered_at'] = Variable<DateTime>(answeredAt);
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || seq != null) {
      map['seq'] = Variable<int>(seq);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  AnswerEventsCompanion toCompanion(bool nullToAbsent) {
    return AnswerEventsCompanion(
      clientEventId: Value(clientEventId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      questionId: Value(questionId),
      questionNumber: Value(questionNumber),
      selectedKey: selectedKey == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedKey),
      isCorrect: Value(isCorrect),
      responseMs: responseMs == null && nullToAbsent
          ? const Value.absent()
          : Value(responseMs),
      source: Value(source),
      examClientId: examClientId == null && nullToAbsent
          ? const Value.absent()
          : Value(examClientId),
      answeredAt: Value(answeredAt),
      deviceId: Value(deviceId),
      seq: seq == null && nullToAbsent ? const Value.absent() : Value(seq),
      synced: Value(synced),
    );
  }

  factory AnswerEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerEvent(
      clientEventId: serializer.fromJson<String>(json['clientEventId']),
      userId: serializer.fromJson<String?>(json['userId']),
      questionId: serializer.fromJson<String>(json['questionId']),
      questionNumber: serializer.fromJson<int>(json['questionNumber']),
      selectedKey: serializer.fromJson<String?>(json['selectedKey']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      responseMs: serializer.fromJson<int?>(json['responseMs']),
      source: serializer.fromJson<String>(json['source']),
      examClientId: serializer.fromJson<String?>(json['examClientId']),
      answeredAt: serializer.fromJson<DateTime>(json['answeredAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      seq: serializer.fromJson<int?>(json['seq']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientEventId': serializer.toJson<String>(clientEventId),
      'userId': serializer.toJson<String?>(userId),
      'questionId': serializer.toJson<String>(questionId),
      'questionNumber': serializer.toJson<int>(questionNumber),
      'selectedKey': serializer.toJson<String?>(selectedKey),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'responseMs': serializer.toJson<int?>(responseMs),
      'source': serializer.toJson<String>(source),
      'examClientId': serializer.toJson<String?>(examClientId),
      'answeredAt': serializer.toJson<DateTime>(answeredAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'seq': serializer.toJson<int?>(seq),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  AnswerEvent copyWith({
    String? clientEventId,
    Value<String?> userId = const Value.absent(),
    String? questionId,
    int? questionNumber,
    Value<String?> selectedKey = const Value.absent(),
    bool? isCorrect,
    Value<int?> responseMs = const Value.absent(),
    String? source,
    Value<String?> examClientId = const Value.absent(),
    DateTime? answeredAt,
    String? deviceId,
    Value<int?> seq = const Value.absent(),
    bool? synced,
  }) => AnswerEvent(
    clientEventId: clientEventId ?? this.clientEventId,
    userId: userId.present ? userId.value : this.userId,
    questionId: questionId ?? this.questionId,
    questionNumber: questionNumber ?? this.questionNumber,
    selectedKey: selectedKey.present ? selectedKey.value : this.selectedKey,
    isCorrect: isCorrect ?? this.isCorrect,
    responseMs: responseMs.present ? responseMs.value : this.responseMs,
    source: source ?? this.source,
    examClientId: examClientId.present ? examClientId.value : this.examClientId,
    answeredAt: answeredAt ?? this.answeredAt,
    deviceId: deviceId ?? this.deviceId,
    seq: seq.present ? seq.value : this.seq,
    synced: synced ?? this.synced,
  );
  AnswerEvent copyWithCompanion(AnswerEventsCompanion data) {
    return AnswerEvent(
      clientEventId: data.clientEventId.present
          ? data.clientEventId.value
          : this.clientEventId,
      userId: data.userId.present ? data.userId.value : this.userId,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      questionNumber: data.questionNumber.present
          ? data.questionNumber.value
          : this.questionNumber,
      selectedKey: data.selectedKey.present
          ? data.selectedKey.value
          : this.selectedKey,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      responseMs: data.responseMs.present
          ? data.responseMs.value
          : this.responseMs,
      source: data.source.present ? data.source.value : this.source,
      examClientId: data.examClientId.present
          ? data.examClientId.value
          : this.examClientId,
      answeredAt: data.answeredAt.present
          ? data.answeredAt.value
          : this.answeredAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      seq: data.seq.present ? data.seq.value : this.seq,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnswerEvent(')
          ..write('clientEventId: $clientEventId, ')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('questionNumber: $questionNumber, ')
          ..write('selectedKey: $selectedKey, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('responseMs: $responseMs, ')
          ..write('source: $source, ')
          ..write('examClientId: $examClientId, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('seq: $seq, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientEventId,
    userId,
    questionId,
    questionNumber,
    selectedKey,
    isCorrect,
    responseMs,
    source,
    examClientId,
    answeredAt,
    deviceId,
    seq,
    synced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswerEvent &&
          other.clientEventId == this.clientEventId &&
          other.userId == this.userId &&
          other.questionId == this.questionId &&
          other.questionNumber == this.questionNumber &&
          other.selectedKey == this.selectedKey &&
          other.isCorrect == this.isCorrect &&
          other.responseMs == this.responseMs &&
          other.source == this.source &&
          other.examClientId == this.examClientId &&
          other.answeredAt == this.answeredAt &&
          other.deviceId == this.deviceId &&
          other.seq == this.seq &&
          other.synced == this.synced);
}

class AnswerEventsCompanion extends UpdateCompanion<AnswerEvent> {
  final Value<String> clientEventId;
  final Value<String?> userId;
  final Value<String> questionId;
  final Value<int> questionNumber;
  final Value<String?> selectedKey;
  final Value<bool> isCorrect;
  final Value<int?> responseMs;
  final Value<String> source;
  final Value<String?> examClientId;
  final Value<DateTime> answeredAt;
  final Value<String> deviceId;
  final Value<int?> seq;
  final Value<bool> synced;
  final Value<int> rowid;
  const AnswerEventsCompanion({
    this.clientEventId = const Value.absent(),
    this.userId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.questionNumber = const Value.absent(),
    this.selectedKey = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.responseMs = const Value.absent(),
    this.source = const Value.absent(),
    this.examClientId = const Value.absent(),
    this.answeredAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.seq = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnswerEventsCompanion.insert({
    required String clientEventId,
    this.userId = const Value.absent(),
    required String questionId,
    required int questionNumber,
    this.selectedKey = const Value.absent(),
    required bool isCorrect,
    this.responseMs = const Value.absent(),
    required String source,
    this.examClientId = const Value.absent(),
    required DateTime answeredAt,
    required String deviceId,
    this.seq = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientEventId = Value(clientEventId),
       questionId = Value(questionId),
       questionNumber = Value(questionNumber),
       isCorrect = Value(isCorrect),
       source = Value(source),
       answeredAt = Value(answeredAt),
       deviceId = Value(deviceId);
  static Insertable<AnswerEvent> custom({
    Expression<String>? clientEventId,
    Expression<String>? userId,
    Expression<String>? questionId,
    Expression<int>? questionNumber,
    Expression<String>? selectedKey,
    Expression<bool>? isCorrect,
    Expression<int>? responseMs,
    Expression<String>? source,
    Expression<String>? examClientId,
    Expression<DateTime>? answeredAt,
    Expression<String>? deviceId,
    Expression<int>? seq,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientEventId != null) 'client_event_id': clientEventId,
      if (userId != null) 'user_id': userId,
      if (questionId != null) 'question_id': questionId,
      if (questionNumber != null) 'question_number': questionNumber,
      if (selectedKey != null) 'selected_key': selectedKey,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (responseMs != null) 'response_ms': responseMs,
      if (source != null) 'source': source,
      if (examClientId != null) 'exam_client_id': examClientId,
      if (answeredAt != null) 'answered_at': answeredAt,
      if (deviceId != null) 'device_id': deviceId,
      if (seq != null) 'seq': seq,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnswerEventsCompanion copyWith({
    Value<String>? clientEventId,
    Value<String?>? userId,
    Value<String>? questionId,
    Value<int>? questionNumber,
    Value<String?>? selectedKey,
    Value<bool>? isCorrect,
    Value<int?>? responseMs,
    Value<String>? source,
    Value<String?>? examClientId,
    Value<DateTime>? answeredAt,
    Value<String>? deviceId,
    Value<int?>? seq,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return AnswerEventsCompanion(
      clientEventId: clientEventId ?? this.clientEventId,
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      questionNumber: questionNumber ?? this.questionNumber,
      selectedKey: selectedKey ?? this.selectedKey,
      isCorrect: isCorrect ?? this.isCorrect,
      responseMs: responseMs ?? this.responseMs,
      source: source ?? this.source,
      examClientId: examClientId ?? this.examClientId,
      answeredAt: answeredAt ?? this.answeredAt,
      deviceId: deviceId ?? this.deviceId,
      seq: seq ?? this.seq,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientEventId.present) {
      map['client_event_id'] = Variable<String>(clientEventId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (questionNumber.present) {
      map['question_number'] = Variable<int>(questionNumber.value);
    }
    if (selectedKey.present) {
      map['selected_key'] = Variable<String>(selectedKey.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (responseMs.present) {
      map['response_ms'] = Variable<int>(responseMs.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (examClientId.present) {
      map['exam_client_id'] = Variable<String>(examClientId.value);
    }
    if (answeredAt.present) {
      map['answered_at'] = Variable<DateTime>(answeredAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerEventsCompanion(')
          ..write('clientEventId: $clientEventId, ')
          ..write('userId: $userId, ')
          ..write('questionId: $questionId, ')
          ..write('questionNumber: $questionNumber, ')
          ..write('selectedKey: $selectedKey, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('responseMs: $responseMs, ')
          ..write('source: $source, ')
          ..write('examClientId: $examClientId, ')
          ..write('answeredAt: $answeredAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('seq: $seq, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionProgressTable extends QuestionProgress
    with TableInfo<$QuestionProgressTable, ProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _efMeta = const VerificationMeta('ef');
  @override
  late final GeneratedColumn<double> ef = GeneratedColumn<double>(
    'ef',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalMeta = const VerificationMeta(
    'interval',
  );
  @override
  late final GeneratedColumn<int> interval = GeneratedColumn<int>(
    'interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _consecutiveCorrectMeta =
      const VerificationMeta('consecutiveCorrect');
  @override
  late final GeneratedColumn<int> consecutiveCorrect = GeneratedColumn<int>(
    'consecutive_correct',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inWrongBookMeta = const VerificationMeta(
    'inWrongBook',
  );
  @override
  late final GeneratedColumn<bool> inWrongBook = GeneratedColumn<bool>(
    'in_wrong_book',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("in_wrong_book" IN (0, 1))',
    ),
  );
  static const VerificationMeta _lastAnsweredAtMeta = const VerificationMeta(
    'lastAnsweredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAnsweredAt =
      GeneratedColumn<DateTime>(
        'last_answered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    questionId,
    ef,
    interval,
    reps,
    dueDate,
    correctCount,
    wrongCount,
    consecutiveCorrect,
    inWrongBook,
    lastAnsweredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('ef')) {
      context.handle(_efMeta, ef.isAcceptableOrUnknown(data['ef']!, _efMeta));
    } else if (isInserting) {
      context.missing(_efMeta);
    }
    if (data.containsKey('interval')) {
      context.handle(
        _intervalMeta,
        interval.isAcceptableOrUnknown(data['interval']!, _intervalMeta),
      );
    } else if (isInserting) {
      context.missing(_intervalMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    } else if (isInserting) {
      context.missing(_wrongCountMeta);
    }
    if (data.containsKey('consecutive_correct')) {
      context.handle(
        _consecutiveCorrectMeta,
        consecutiveCorrect.isAcceptableOrUnknown(
          data['consecutive_correct']!,
          _consecutiveCorrectMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_consecutiveCorrectMeta);
    }
    if (data.containsKey('in_wrong_book')) {
      context.handle(
        _inWrongBookMeta,
        inWrongBook.isAcceptableOrUnknown(
          data['in_wrong_book']!,
          _inWrongBookMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_inWrongBookMeta);
    }
    if (data.containsKey('last_answered_at')) {
      context.handle(
        _lastAnsweredAtMeta,
        lastAnsweredAt.isAcceptableOrUnknown(
          data['last_answered_at']!,
          _lastAnsweredAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId};
  @override
  ProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressRow(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      ef: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ef'],
      )!,
      interval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      ),
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      consecutiveCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}consecutive_correct'],
      )!,
      inWrongBook: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}in_wrong_book'],
      )!,
      lastAnsweredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_answered_at'],
      ),
    );
  }

  @override
  $QuestionProgressTable createAlias(String alias) {
    return $QuestionProgressTable(attachedDatabase, alias);
  }
}

class ProgressRow extends DataClass implements Insertable<ProgressRow> {
  final String questionId;
  final double ef;
  final int interval;
  final int reps;
  final String? dueDate;
  final int correctCount;
  final int wrongCount;
  final int consecutiveCorrect;
  final bool inWrongBook;
  final DateTime? lastAnsweredAt;
  const ProgressRow({
    required this.questionId,
    required this.ef,
    required this.interval,
    required this.reps,
    this.dueDate,
    required this.correctCount,
    required this.wrongCount,
    required this.consecutiveCorrect,
    required this.inWrongBook,
    this.lastAnsweredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['ef'] = Variable<double>(ef);
    map['interval'] = Variable<int>(interval);
    map['reps'] = Variable<int>(reps);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<String>(dueDate);
    }
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    map['consecutive_correct'] = Variable<int>(consecutiveCorrect);
    map['in_wrong_book'] = Variable<bool>(inWrongBook);
    if (!nullToAbsent || lastAnsweredAt != null) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt);
    }
    return map;
  }

  QuestionProgressCompanion toCompanion(bool nullToAbsent) {
    return QuestionProgressCompanion(
      questionId: Value(questionId),
      ef: Value(ef),
      interval: Value(interval),
      reps: Value(reps),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      consecutiveCorrect: Value(consecutiveCorrect),
      inWrongBook: Value(inWrongBook),
      lastAnsweredAt: lastAnsweredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAnsweredAt),
    );
  }

  factory ProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressRow(
      questionId: serializer.fromJson<String>(json['questionId']),
      ef: serializer.fromJson<double>(json['ef']),
      interval: serializer.fromJson<int>(json['interval']),
      reps: serializer.fromJson<int>(json['reps']),
      dueDate: serializer.fromJson<String?>(json['dueDate']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      consecutiveCorrect: serializer.fromJson<int>(json['consecutiveCorrect']),
      inWrongBook: serializer.fromJson<bool>(json['inWrongBook']),
      lastAnsweredAt: serializer.fromJson<DateTime?>(json['lastAnsweredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'ef': serializer.toJson<double>(ef),
      'interval': serializer.toJson<int>(interval),
      'reps': serializer.toJson<int>(reps),
      'dueDate': serializer.toJson<String?>(dueDate),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'consecutiveCorrect': serializer.toJson<int>(consecutiveCorrect),
      'inWrongBook': serializer.toJson<bool>(inWrongBook),
      'lastAnsweredAt': serializer.toJson<DateTime?>(lastAnsweredAt),
    };
  }

  ProgressRow copyWith({
    String? questionId,
    double? ef,
    int? interval,
    int? reps,
    Value<String?> dueDate = const Value.absent(),
    int? correctCount,
    int? wrongCount,
    int? consecutiveCorrect,
    bool? inWrongBook,
    Value<DateTime?> lastAnsweredAt = const Value.absent(),
  }) => ProgressRow(
    questionId: questionId ?? this.questionId,
    ef: ef ?? this.ef,
    interval: interval ?? this.interval,
    reps: reps ?? this.reps,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
    inWrongBook: inWrongBook ?? this.inWrongBook,
    lastAnsweredAt: lastAnsweredAt.present
        ? lastAnsweredAt.value
        : this.lastAnsweredAt,
  );
  ProgressRow copyWithCompanion(QuestionProgressCompanion data) {
    return ProgressRow(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      ef: data.ef.present ? data.ef.value : this.ef,
      interval: data.interval.present ? data.interval.value : this.interval,
      reps: data.reps.present ? data.reps.value : this.reps,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      consecutiveCorrect: data.consecutiveCorrect.present
          ? data.consecutiveCorrect.value
          : this.consecutiveCorrect,
      inWrongBook: data.inWrongBook.present
          ? data.inWrongBook.value
          : this.inWrongBook,
      lastAnsweredAt: data.lastAnsweredAt.present
          ? data.lastAnsweredAt.value
          : this.lastAnsweredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressRow(')
          ..write('questionId: $questionId, ')
          ..write('ef: $ef, ')
          ..write('interval: $interval, ')
          ..write('reps: $reps, ')
          ..write('dueDate: $dueDate, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('consecutiveCorrect: $consecutiveCorrect, ')
          ..write('inWrongBook: $inWrongBook, ')
          ..write('lastAnsweredAt: $lastAnsweredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    questionId,
    ef,
    interval,
    reps,
    dueDate,
    correctCount,
    wrongCount,
    consecutiveCorrect,
    inWrongBook,
    lastAnsweredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressRow &&
          other.questionId == this.questionId &&
          other.ef == this.ef &&
          other.interval == this.interval &&
          other.reps == this.reps &&
          other.dueDate == this.dueDate &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.consecutiveCorrect == this.consecutiveCorrect &&
          other.inWrongBook == this.inWrongBook &&
          other.lastAnsweredAt == this.lastAnsweredAt);
}

class QuestionProgressCompanion extends UpdateCompanion<ProgressRow> {
  final Value<String> questionId;
  final Value<double> ef;
  final Value<int> interval;
  final Value<int> reps;
  final Value<String?> dueDate;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<int> consecutiveCorrect;
  final Value<bool> inWrongBook;
  final Value<DateTime?> lastAnsweredAt;
  final Value<int> rowid;
  const QuestionProgressCompanion({
    this.questionId = const Value.absent(),
    this.ef = const Value.absent(),
    this.interval = const Value.absent(),
    this.reps = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.consecutiveCorrect = const Value.absent(),
    this.inWrongBook = const Value.absent(),
    this.lastAnsweredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionProgressCompanion.insert({
    required String questionId,
    required double ef,
    required int interval,
    required int reps,
    this.dueDate = const Value.absent(),
    required int correctCount,
    required int wrongCount,
    required int consecutiveCorrect,
    required bool inWrongBook,
    this.lastAnsweredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       ef = Value(ef),
       interval = Value(interval),
       reps = Value(reps),
       correctCount = Value(correctCount),
       wrongCount = Value(wrongCount),
       consecutiveCorrect = Value(consecutiveCorrect),
       inWrongBook = Value(inWrongBook);
  static Insertable<ProgressRow> custom({
    Expression<String>? questionId,
    Expression<double>? ef,
    Expression<int>? interval,
    Expression<int>? reps,
    Expression<String>? dueDate,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<int>? consecutiveCorrect,
    Expression<bool>? inWrongBook,
    Expression<DateTime>? lastAnsweredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (ef != null) 'ef': ef,
      if (interval != null) 'interval': interval,
      if (reps != null) 'reps': reps,
      if (dueDate != null) 'due_date': dueDate,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (consecutiveCorrect != null) 'consecutive_correct': consecutiveCorrect,
      if (inWrongBook != null) 'in_wrong_book': inWrongBook,
      if (lastAnsweredAt != null) 'last_answered_at': lastAnsweredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionProgressCompanion copyWith({
    Value<String>? questionId,
    Value<double>? ef,
    Value<int>? interval,
    Value<int>? reps,
    Value<String?>? dueDate,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<int>? consecutiveCorrect,
    Value<bool>? inWrongBook,
    Value<DateTime?>? lastAnsweredAt,
    Value<int>? rowid,
  }) {
    return QuestionProgressCompanion(
      questionId: questionId ?? this.questionId,
      ef: ef ?? this.ef,
      interval: interval ?? this.interval,
      reps: reps ?? this.reps,
      dueDate: dueDate ?? this.dueDate,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      consecutiveCorrect: consecutiveCorrect ?? this.consecutiveCorrect,
      inWrongBook: inWrongBook ?? this.inWrongBook,
      lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (ef.present) {
      map['ef'] = Variable<double>(ef.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(interval.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (consecutiveCorrect.present) {
      map['consecutive_correct'] = Variable<int>(consecutiveCorrect.value);
    }
    if (inWrongBook.present) {
      map['in_wrong_book'] = Variable<bool>(inWrongBook.value);
    }
    if (lastAnsweredAt.present) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionProgressCompanion(')
          ..write('questionId: $questionId, ')
          ..write('ef: $ef, ')
          ..write('interval: $interval, ')
          ..write('reps: $reps, ')
          ..write('dueDate: $dueDate, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('consecutiveCorrect: $consecutiveCorrect, ')
          ..write('inWrongBook: $inWrongBook, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookmarkedMeta = const VerificationMeta(
    'bookmarked',
  );
  @override
  late final GeneratedColumn<bool> bookmarked = GeneratedColumn<bool>(
    'bookmarked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bookmarked" IN (0, 1))',
    ),
  );
  static const VerificationMeta _clientUpdatedAtMeta = const VerificationMeta(
    'clientUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> clientUpdatedAt =
      GeneratedColumn<DateTime>(
        'client_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    questionId,
    bookmarked,
    clientUpdatedAt,
    userId,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('bookmarked')) {
      context.handle(
        _bookmarkedMeta,
        bookmarked.isAcceptableOrUnknown(data['bookmarked']!, _bookmarkedMeta),
      );
    } else if (isInserting) {
      context.missing(_bookmarkedMeta);
    }
    if (data.containsKey('client_updated_at')) {
      context.handle(
        _clientUpdatedAtMeta,
        clientUpdatedAt.isAcceptableOrUnknown(
          data['client_updated_at']!,
          _clientUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clientUpdatedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      bookmarked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bookmarked'],
      )!,
      clientUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_updated_at'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final String questionId;
  final bool bookmarked;
  final DateTime clientUpdatedAt;
  final String? userId;
  final bool synced;
  const Bookmark({
    required this.questionId,
    required this.bookmarked,
    required this.clientUpdatedAt,
    this.userId,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_id'] = Variable<String>(questionId);
    map['bookmarked'] = Variable<bool>(bookmarked);
    map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      questionId: Value(questionId),
      bookmarked: Value(bookmarked),
      clientUpdatedAt: Value(clientUpdatedAt),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      synced: Value(synced),
    );
  }

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      questionId: serializer.fromJson<String>(json['questionId']),
      bookmarked: serializer.fromJson<bool>(json['bookmarked']),
      clientUpdatedAt: serializer.fromJson<DateTime>(json['clientUpdatedAt']),
      userId: serializer.fromJson<String?>(json['userId']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionId': serializer.toJson<String>(questionId),
      'bookmarked': serializer.toJson<bool>(bookmarked),
      'clientUpdatedAt': serializer.toJson<DateTime>(clientUpdatedAt),
      'userId': serializer.toJson<String?>(userId),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  Bookmark copyWith({
    String? questionId,
    bool? bookmarked,
    DateTime? clientUpdatedAt,
    Value<String?> userId = const Value.absent(),
    bool? synced,
  }) => Bookmark(
    questionId: questionId ?? this.questionId,
    bookmarked: bookmarked ?? this.bookmarked,
    clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
    userId: userId.present ? userId.value : this.userId,
    synced: synced ?? this.synced,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      bookmarked: data.bookmarked.present
          ? data.bookmarked.value
          : this.bookmarked,
      clientUpdatedAt: data.clientUpdatedAt.present
          ? data.clientUpdatedAt.value
          : this.clientUpdatedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('questionId: $questionId, ')
          ..write('bookmarked: $bookmarked, ')
          ..write('clientUpdatedAt: $clientUpdatedAt, ')
          ..write('userId: $userId, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(questionId, bookmarked, clientUpdatedAt, userId, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bookmark &&
          other.questionId == this.questionId &&
          other.bookmarked == this.bookmarked &&
          other.clientUpdatedAt == this.clientUpdatedAt &&
          other.userId == this.userId &&
          other.synced == this.synced);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<String> questionId;
  final Value<bool> bookmarked;
  final Value<DateTime> clientUpdatedAt;
  final Value<String?> userId;
  final Value<bool> synced;
  final Value<int> rowid;
  const BookmarksCompanion({
    this.questionId = const Value.absent(),
    this.bookmarked = const Value.absent(),
    this.clientUpdatedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookmarksCompanion.insert({
    required String questionId,
    required bool bookmarked,
    required DateTime clientUpdatedAt,
    this.userId = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : questionId = Value(questionId),
       bookmarked = Value(bookmarked),
       clientUpdatedAt = Value(clientUpdatedAt);
  static Insertable<Bookmark> custom({
    Expression<String>? questionId,
    Expression<bool>? bookmarked,
    Expression<DateTime>? clientUpdatedAt,
    Expression<String>? userId,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionId != null) 'question_id': questionId,
      if (bookmarked != null) 'bookmarked': bookmarked,
      if (clientUpdatedAt != null) 'client_updated_at': clientUpdatedAt,
      if (userId != null) 'user_id': userId,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookmarksCompanion copyWith({
    Value<String>? questionId,
    Value<bool>? bookmarked,
    Value<DateTime>? clientUpdatedAt,
    Value<String?>? userId,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return BookmarksCompanion(
      questionId: questionId ?? this.questionId,
      bookmarked: bookmarked ?? this.bookmarked,
      clientUpdatedAt: clientUpdatedAt ?? this.clientUpdatedAt,
      userId: userId ?? this.userId,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (bookmarked.present) {
      map['bookmarked'] = Variable<bool>(bookmarked.value);
    }
    if (clientUpdatedAt.present) {
      map['client_updated_at'] = Variable<DateTime>(clientUpdatedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('questionId: $questionId, ')
          ..write('bookmarked: $bookmarked, ')
          ..write('clientUpdatedAt: $clientUpdatedAt, ')
          ..write('userId: $userId, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamSessionsTable extends ExamSessions
    with TableInfo<$ExamSessionsTable, ExamSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _licenseClassMeta = const VerificationMeta(
    'licenseClass',
  );
  @override
  late final GeneratedColumn<String> licenseClass = GeneratedColumn<String>(
    'license_class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionIdsJsonMeta = const VerificationMeta(
    'questionIdsJson',
  );
  @override
  late final GeneratedColumn<String> questionIdsJson = GeneratedColumn<String>(
    'question_ids_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passScoreMeta = const VerificationMeta(
    'passScore',
  );
  @override
  late final GeneratedColumn<int> passScore = GeneratedColumn<int>(
    'pass_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deadlineAtMeta = const VerificationMeta(
    'deadlineAt',
  );
  @override
  late final GeneratedColumn<DateTime> deadlineAt = GeneratedColumn<DateTime>(
    'deadline_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    licenseClass,
    mode,
    questionIdsJson,
    answersJson,
    passScore,
    startedAt,
    deadlineAt,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('license_class')) {
      context.handle(
        _licenseClassMeta,
        licenseClass.isAcceptableOrUnknown(
          data['license_class']!,
          _licenseClassMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseClassMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('question_ids_json')) {
      context.handle(
        _questionIdsJsonMeta,
        questionIdsJson.isAcceptableOrUnknown(
          data['question_ids_json']!,
          _questionIdsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionIdsJsonMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answersJsonMeta);
    }
    if (data.containsKey('pass_score')) {
      context.handle(
        _passScoreMeta,
        passScore.isAcceptableOrUnknown(data['pass_score']!, _passScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_passScoreMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('deadline_at')) {
      context.handle(
        _deadlineAtMeta,
        deadlineAt.isAcceptableOrUnknown(data['deadline_at']!, _deadlineAtMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      licenseClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_class'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      questionIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_ids_json'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      passScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pass_score'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      deadlineAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ExamSessionsTable createAlias(String alias) {
    return $ExamSessionsTable(attachedDatabase, alias);
  }
}

class ExamSession extends DataClass implements Insertable<ExamSession> {
  final String id;
  final String licenseClass;
  final String mode;
  final String questionIdsJson;
  final String answersJson;
  final int passScore;
  final DateTime startedAt;
  final DateTime deadlineAt;
  final String status;
  const ExamSession({
    required this.id,
    required this.licenseClass,
    required this.mode,
    required this.questionIdsJson,
    required this.answersJson,
    required this.passScore,
    required this.startedAt,
    required this.deadlineAt,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['license_class'] = Variable<String>(licenseClass);
    map['mode'] = Variable<String>(mode);
    map['question_ids_json'] = Variable<String>(questionIdsJson);
    map['answers_json'] = Variable<String>(answersJson);
    map['pass_score'] = Variable<int>(passScore);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['deadline_at'] = Variable<DateTime>(deadlineAt);
    map['status'] = Variable<String>(status);
    return map;
  }

  ExamSessionsCompanion toCompanion(bool nullToAbsent) {
    return ExamSessionsCompanion(
      id: Value(id),
      licenseClass: Value(licenseClass),
      mode: Value(mode),
      questionIdsJson: Value(questionIdsJson),
      answersJson: Value(answersJson),
      passScore: Value(passScore),
      startedAt: Value(startedAt),
      deadlineAt: Value(deadlineAt),
      status: Value(status),
    );
  }

  factory ExamSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamSession(
      id: serializer.fromJson<String>(json['id']),
      licenseClass: serializer.fromJson<String>(json['licenseClass']),
      mode: serializer.fromJson<String>(json['mode']),
      questionIdsJson: serializer.fromJson<String>(json['questionIdsJson']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      passScore: serializer.fromJson<int>(json['passScore']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      deadlineAt: serializer.fromJson<DateTime>(json['deadlineAt']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'licenseClass': serializer.toJson<String>(licenseClass),
      'mode': serializer.toJson<String>(mode),
      'questionIdsJson': serializer.toJson<String>(questionIdsJson),
      'answersJson': serializer.toJson<String>(answersJson),
      'passScore': serializer.toJson<int>(passScore),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'deadlineAt': serializer.toJson<DateTime>(deadlineAt),
      'status': serializer.toJson<String>(status),
    };
  }

  ExamSession copyWith({
    String? id,
    String? licenseClass,
    String? mode,
    String? questionIdsJson,
    String? answersJson,
    int? passScore,
    DateTime? startedAt,
    DateTime? deadlineAt,
    String? status,
  }) => ExamSession(
    id: id ?? this.id,
    licenseClass: licenseClass ?? this.licenseClass,
    mode: mode ?? this.mode,
    questionIdsJson: questionIdsJson ?? this.questionIdsJson,
    answersJson: answersJson ?? this.answersJson,
    passScore: passScore ?? this.passScore,
    startedAt: startedAt ?? this.startedAt,
    deadlineAt: deadlineAt ?? this.deadlineAt,
    status: status ?? this.status,
  );
  ExamSession copyWithCompanion(ExamSessionsCompanion data) {
    return ExamSession(
      id: data.id.present ? data.id.value : this.id,
      licenseClass: data.licenseClass.present
          ? data.licenseClass.value
          : this.licenseClass,
      mode: data.mode.present ? data.mode.value : this.mode,
      questionIdsJson: data.questionIdsJson.present
          ? data.questionIdsJson.value
          : this.questionIdsJson,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      passScore: data.passScore.present ? data.passScore.value : this.passScore,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      deadlineAt: data.deadlineAt.present
          ? data.deadlineAt.value
          : this.deadlineAt,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamSession(')
          ..write('id: $id, ')
          ..write('licenseClass: $licenseClass, ')
          ..write('mode: $mode, ')
          ..write('questionIdsJson: $questionIdsJson, ')
          ..write('answersJson: $answersJson, ')
          ..write('passScore: $passScore, ')
          ..write('startedAt: $startedAt, ')
          ..write('deadlineAt: $deadlineAt, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    licenseClass,
    mode,
    questionIdsJson,
    answersJson,
    passScore,
    startedAt,
    deadlineAt,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamSession &&
          other.id == this.id &&
          other.licenseClass == this.licenseClass &&
          other.mode == this.mode &&
          other.questionIdsJson == this.questionIdsJson &&
          other.answersJson == this.answersJson &&
          other.passScore == this.passScore &&
          other.startedAt == this.startedAt &&
          other.deadlineAt == this.deadlineAt &&
          other.status == this.status);
}

class ExamSessionsCompanion extends UpdateCompanion<ExamSession> {
  final Value<String> id;
  final Value<String> licenseClass;
  final Value<String> mode;
  final Value<String> questionIdsJson;
  final Value<String> answersJson;
  final Value<int> passScore;
  final Value<DateTime> startedAt;
  final Value<DateTime> deadlineAt;
  final Value<String> status;
  final Value<int> rowid;
  const ExamSessionsCompanion({
    this.id = const Value.absent(),
    this.licenseClass = const Value.absent(),
    this.mode = const Value.absent(),
    this.questionIdsJson = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.passScore = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.deadlineAt = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamSessionsCompanion.insert({
    required String id,
    required String licenseClass,
    required String mode,
    required String questionIdsJson,
    required String answersJson,
    required int passScore,
    required DateTime startedAt,
    required DateTime deadlineAt,
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       licenseClass = Value(licenseClass),
       mode = Value(mode),
       questionIdsJson = Value(questionIdsJson),
       answersJson = Value(answersJson),
       passScore = Value(passScore),
       startedAt = Value(startedAt),
       deadlineAt = Value(deadlineAt),
       status = Value(status);
  static Insertable<ExamSession> custom({
    Expression<String>? id,
    Expression<String>? licenseClass,
    Expression<String>? mode,
    Expression<String>? questionIdsJson,
    Expression<String>? answersJson,
    Expression<int>? passScore,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? deadlineAt,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (licenseClass != null) 'license_class': licenseClass,
      if (mode != null) 'mode': mode,
      if (questionIdsJson != null) 'question_ids_json': questionIdsJson,
      if (answersJson != null) 'answers_json': answersJson,
      if (passScore != null) 'pass_score': passScore,
      if (startedAt != null) 'started_at': startedAt,
      if (deadlineAt != null) 'deadline_at': deadlineAt,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? licenseClass,
    Value<String>? mode,
    Value<String>? questionIdsJson,
    Value<String>? answersJson,
    Value<int>? passScore,
    Value<DateTime>? startedAt,
    Value<DateTime>? deadlineAt,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ExamSessionsCompanion(
      id: id ?? this.id,
      licenseClass: licenseClass ?? this.licenseClass,
      mode: mode ?? this.mode,
      questionIdsJson: questionIdsJson ?? this.questionIdsJson,
      answersJson: answersJson ?? this.answersJson,
      passScore: passScore ?? this.passScore,
      startedAt: startedAt ?? this.startedAt,
      deadlineAt: deadlineAt ?? this.deadlineAt,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (licenseClass.present) {
      map['license_class'] = Variable<String>(licenseClass.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (questionIdsJson.present) {
      map['question_ids_json'] = Variable<String>(questionIdsJson.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (passScore.present) {
      map['pass_score'] = Variable<int>(passScore.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (deadlineAt.present) {
      map['deadline_at'] = Variable<DateTime>(deadlineAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamSessionsCompanion(')
          ..write('id: $id, ')
          ..write('licenseClass: $licenseClass, ')
          ..write('mode: $mode, ')
          ..write('questionIdsJson: $questionIdsJson, ')
          ..write('answersJson: $answersJson, ')
          ..write('passScore: $passScore, ')
          ..write('startedAt: $startedAt, ')
          ..write('deadlineAt: $deadlineAt, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamAttemptsTable extends ExamAttempts
    with TableInfo<$ExamAttemptsTable, ExamAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _licenseClassMeta = const VerificationMeta(
    'licenseClass',
  );
  @override
  late final GeneratedColumn<String> licenseClass = GeneratedColumn<String>(
    'license_class',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passScoreMeta = const VerificationMeta(
    'passScore',
  );
  @override
  late final GeneratedColumn<int> passScore = GeneratedColumn<int>(
    'pass_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passedMeta = const VerificationMeta('passed');
  @override
  late final GeneratedColumn<bool> passed = GeneratedColumn<bool>(
    'passed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("passed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _failedByCriticalMeta = const VerificationMeta(
    'failedByCritical',
  );
  @override
  late final GeneratedColumn<bool> failedByCritical = GeneratedColumn<bool>(
    'failed_by_critical',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("failed_by_critical" IN (0, 1))',
    ),
  );
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _submittedAtMeta = const VerificationMeta(
    'submittedAt',
  );
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
    'submitted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seqMeta = const VerificationMeta('seq');
  @override
  late final GeneratedColumn<int> seq = GeneratedColumn<int>(
    'seq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientId,
    userId,
    licenseClass,
    mode,
    itemsJson,
    correctCount,
    total,
    passScore,
    passed,
    failedByCritical,
    durationSec,
    startedAt,
    submittedAt,
    deviceId,
    seq,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExamAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('license_class')) {
      context.handle(
        _licenseClassMeta,
        licenseClass.isAcceptableOrUnknown(
          data['license_class']!,
          _licenseClassMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_licenseClassMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_itemsJsonMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('pass_score')) {
      context.handle(
        _passScoreMeta,
        passScore.isAcceptableOrUnknown(data['pass_score']!, _passScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_passScoreMeta);
    }
    if (data.containsKey('passed')) {
      context.handle(
        _passedMeta,
        passed.isAcceptableOrUnknown(data['passed']!, _passedMeta),
      );
    } else if (isInserting) {
      context.missing(_passedMeta);
    }
    if (data.containsKey('failed_by_critical')) {
      context.handle(
        _failedByCriticalMeta,
        failedByCritical.isAcceptableOrUnknown(
          data['failed_by_critical']!,
          _failedByCriticalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_failedByCriticalMeta);
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
        _submittedAtMeta,
        submittedAt.isAcceptableOrUnknown(
          data['submitted_at']!,
          _submittedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_submittedAtMeta);
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('seq')) {
      context.handle(
        _seqMeta,
        seq.isAcceptableOrUnknown(data['seq']!, _seqMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId};
  @override
  ExamAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamAttempt(
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      licenseClass: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}license_class'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mode'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      passScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pass_score'],
      )!,
      passed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}passed'],
      )!,
      failedByCritical: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}failed_by_critical'],
      )!,
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      submittedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}submitted_at'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      seq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}seq'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $ExamAttemptsTable createAlias(String alias) {
    return $ExamAttemptsTable(attachedDatabase, alias);
  }
}

class ExamAttempt extends DataClass implements Insertable<ExamAttempt> {
  final String clientId;
  final String? userId;
  final String licenseClass;
  final String mode;
  final String itemsJson;
  final int correctCount;
  final int total;
  final int passScore;
  final bool passed;
  final bool failedByCritical;
  final int durationSec;
  final DateTime startedAt;
  final DateTime submittedAt;
  final String deviceId;
  final int? seq;
  final bool synced;
  const ExamAttempt({
    required this.clientId,
    this.userId,
    required this.licenseClass,
    required this.mode,
    required this.itemsJson,
    required this.correctCount,
    required this.total,
    required this.passScore,
    required this.passed,
    required this.failedByCritical,
    required this.durationSec,
    required this.startedAt,
    required this.submittedAt,
    required this.deviceId,
    this.seq,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<String>(clientId);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['license_class'] = Variable<String>(licenseClass);
    map['mode'] = Variable<String>(mode);
    map['items_json'] = Variable<String>(itemsJson);
    map['correct_count'] = Variable<int>(correctCount);
    map['total'] = Variable<int>(total);
    map['pass_score'] = Variable<int>(passScore);
    map['passed'] = Variable<bool>(passed);
    map['failed_by_critical'] = Variable<bool>(failedByCritical);
    map['duration_sec'] = Variable<int>(durationSec);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['submitted_at'] = Variable<DateTime>(submittedAt);
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || seq != null) {
      map['seq'] = Variable<int>(seq);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  ExamAttemptsCompanion toCompanion(bool nullToAbsent) {
    return ExamAttemptsCompanion(
      clientId: Value(clientId),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      licenseClass: Value(licenseClass),
      mode: Value(mode),
      itemsJson: Value(itemsJson),
      correctCount: Value(correctCount),
      total: Value(total),
      passScore: Value(passScore),
      passed: Value(passed),
      failedByCritical: Value(failedByCritical),
      durationSec: Value(durationSec),
      startedAt: Value(startedAt),
      submittedAt: Value(submittedAt),
      deviceId: Value(deviceId),
      seq: seq == null && nullToAbsent ? const Value.absent() : Value(seq),
      synced: Value(synced),
    );
  }

  factory ExamAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamAttempt(
      clientId: serializer.fromJson<String>(json['clientId']),
      userId: serializer.fromJson<String?>(json['userId']),
      licenseClass: serializer.fromJson<String>(json['licenseClass']),
      mode: serializer.fromJson<String>(json['mode']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      total: serializer.fromJson<int>(json['total']),
      passScore: serializer.fromJson<int>(json['passScore']),
      passed: serializer.fromJson<bool>(json['passed']),
      failedByCritical: serializer.fromJson<bool>(json['failedByCritical']),
      durationSec: serializer.fromJson<int>(json['durationSec']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      submittedAt: serializer.fromJson<DateTime>(json['submittedAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      seq: serializer.fromJson<int?>(json['seq']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<String>(clientId),
      'userId': serializer.toJson<String?>(userId),
      'licenseClass': serializer.toJson<String>(licenseClass),
      'mode': serializer.toJson<String>(mode),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'correctCount': serializer.toJson<int>(correctCount),
      'total': serializer.toJson<int>(total),
      'passScore': serializer.toJson<int>(passScore),
      'passed': serializer.toJson<bool>(passed),
      'failedByCritical': serializer.toJson<bool>(failedByCritical),
      'durationSec': serializer.toJson<int>(durationSec),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'submittedAt': serializer.toJson<DateTime>(submittedAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'seq': serializer.toJson<int?>(seq),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  ExamAttempt copyWith({
    String? clientId,
    Value<String?> userId = const Value.absent(),
    String? licenseClass,
    String? mode,
    String? itemsJson,
    int? correctCount,
    int? total,
    int? passScore,
    bool? passed,
    bool? failedByCritical,
    int? durationSec,
    DateTime? startedAt,
    DateTime? submittedAt,
    String? deviceId,
    Value<int?> seq = const Value.absent(),
    bool? synced,
  }) => ExamAttempt(
    clientId: clientId ?? this.clientId,
    userId: userId.present ? userId.value : this.userId,
    licenseClass: licenseClass ?? this.licenseClass,
    mode: mode ?? this.mode,
    itemsJson: itemsJson ?? this.itemsJson,
    correctCount: correctCount ?? this.correctCount,
    total: total ?? this.total,
    passScore: passScore ?? this.passScore,
    passed: passed ?? this.passed,
    failedByCritical: failedByCritical ?? this.failedByCritical,
    durationSec: durationSec ?? this.durationSec,
    startedAt: startedAt ?? this.startedAt,
    submittedAt: submittedAt ?? this.submittedAt,
    deviceId: deviceId ?? this.deviceId,
    seq: seq.present ? seq.value : this.seq,
    synced: synced ?? this.synced,
  );
  ExamAttempt copyWithCompanion(ExamAttemptsCompanion data) {
    return ExamAttempt(
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      userId: data.userId.present ? data.userId.value : this.userId,
      licenseClass: data.licenseClass.present
          ? data.licenseClass.value
          : this.licenseClass,
      mode: data.mode.present ? data.mode.value : this.mode,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      total: data.total.present ? data.total.value : this.total,
      passScore: data.passScore.present ? data.passScore.value : this.passScore,
      passed: data.passed.present ? data.passed.value : this.passed,
      failedByCritical: data.failedByCritical.present
          ? data.failedByCritical.value
          : this.failedByCritical,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      submittedAt: data.submittedAt.present
          ? data.submittedAt.value
          : this.submittedAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      seq: data.seq.present ? data.seq.value : this.seq,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamAttempt(')
          ..write('clientId: $clientId, ')
          ..write('userId: $userId, ')
          ..write('licenseClass: $licenseClass, ')
          ..write('mode: $mode, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('correctCount: $correctCount, ')
          ..write('total: $total, ')
          ..write('passScore: $passScore, ')
          ..write('passed: $passed, ')
          ..write('failedByCritical: $failedByCritical, ')
          ..write('durationSec: $durationSec, ')
          ..write('startedAt: $startedAt, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('seq: $seq, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientId,
    userId,
    licenseClass,
    mode,
    itemsJson,
    correctCount,
    total,
    passScore,
    passed,
    failedByCritical,
    durationSec,
    startedAt,
    submittedAt,
    deviceId,
    seq,
    synced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamAttempt &&
          other.clientId == this.clientId &&
          other.userId == this.userId &&
          other.licenseClass == this.licenseClass &&
          other.mode == this.mode &&
          other.itemsJson == this.itemsJson &&
          other.correctCount == this.correctCount &&
          other.total == this.total &&
          other.passScore == this.passScore &&
          other.passed == this.passed &&
          other.failedByCritical == this.failedByCritical &&
          other.durationSec == this.durationSec &&
          other.startedAt == this.startedAt &&
          other.submittedAt == this.submittedAt &&
          other.deviceId == this.deviceId &&
          other.seq == this.seq &&
          other.synced == this.synced);
}

class ExamAttemptsCompanion extends UpdateCompanion<ExamAttempt> {
  final Value<String> clientId;
  final Value<String?> userId;
  final Value<String> licenseClass;
  final Value<String> mode;
  final Value<String> itemsJson;
  final Value<int> correctCount;
  final Value<int> total;
  final Value<int> passScore;
  final Value<bool> passed;
  final Value<bool> failedByCritical;
  final Value<int> durationSec;
  final Value<DateTime> startedAt;
  final Value<DateTime> submittedAt;
  final Value<String> deviceId;
  final Value<int?> seq;
  final Value<bool> synced;
  final Value<int> rowid;
  const ExamAttemptsCompanion({
    this.clientId = const Value.absent(),
    this.userId = const Value.absent(),
    this.licenseClass = const Value.absent(),
    this.mode = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.total = const Value.absent(),
    this.passScore = const Value.absent(),
    this.passed = const Value.absent(),
    this.failedByCritical = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.submittedAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.seq = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamAttemptsCompanion.insert({
    required String clientId,
    this.userId = const Value.absent(),
    required String licenseClass,
    required String mode,
    required String itemsJson,
    required int correctCount,
    required int total,
    required int passScore,
    required bool passed,
    required bool failedByCritical,
    required int durationSec,
    required DateTime startedAt,
    required DateTime submittedAt,
    required String deviceId,
    this.seq = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientId = Value(clientId),
       licenseClass = Value(licenseClass),
       mode = Value(mode),
       itemsJson = Value(itemsJson),
       correctCount = Value(correctCount),
       total = Value(total),
       passScore = Value(passScore),
       passed = Value(passed),
       failedByCritical = Value(failedByCritical),
       durationSec = Value(durationSec),
       startedAt = Value(startedAt),
       submittedAt = Value(submittedAt),
       deviceId = Value(deviceId);
  static Insertable<ExamAttempt> custom({
    Expression<String>? clientId,
    Expression<String>? userId,
    Expression<String>? licenseClass,
    Expression<String>? mode,
    Expression<String>? itemsJson,
    Expression<int>? correctCount,
    Expression<int>? total,
    Expression<int>? passScore,
    Expression<bool>? passed,
    Expression<bool>? failedByCritical,
    Expression<int>? durationSec,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? submittedAt,
    Expression<String>? deviceId,
    Expression<int>? seq,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (userId != null) 'user_id': userId,
      if (licenseClass != null) 'license_class': licenseClass,
      if (mode != null) 'mode': mode,
      if (itemsJson != null) 'items_json': itemsJson,
      if (correctCount != null) 'correct_count': correctCount,
      if (total != null) 'total': total,
      if (passScore != null) 'pass_score': passScore,
      if (passed != null) 'passed': passed,
      if (failedByCritical != null) 'failed_by_critical': failedByCritical,
      if (durationSec != null) 'duration_sec': durationSec,
      if (startedAt != null) 'started_at': startedAt,
      if (submittedAt != null) 'submitted_at': submittedAt,
      if (deviceId != null) 'device_id': deviceId,
      if (seq != null) 'seq': seq,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamAttemptsCompanion copyWith({
    Value<String>? clientId,
    Value<String?>? userId,
    Value<String>? licenseClass,
    Value<String>? mode,
    Value<String>? itemsJson,
    Value<int>? correctCount,
    Value<int>? total,
    Value<int>? passScore,
    Value<bool>? passed,
    Value<bool>? failedByCritical,
    Value<int>? durationSec,
    Value<DateTime>? startedAt,
    Value<DateTime>? submittedAt,
    Value<String>? deviceId,
    Value<int?>? seq,
    Value<bool>? synced,
    Value<int>? rowid,
  }) {
    return ExamAttemptsCompanion(
      clientId: clientId ?? this.clientId,
      userId: userId ?? this.userId,
      licenseClass: licenseClass ?? this.licenseClass,
      mode: mode ?? this.mode,
      itemsJson: itemsJson ?? this.itemsJson,
      correctCount: correctCount ?? this.correctCount,
      total: total ?? this.total,
      passScore: passScore ?? this.passScore,
      passed: passed ?? this.passed,
      failedByCritical: failedByCritical ?? this.failedByCritical,
      durationSec: durationSec ?? this.durationSec,
      startedAt: startedAt ?? this.startedAt,
      submittedAt: submittedAt ?? this.submittedAt,
      deviceId: deviceId ?? this.deviceId,
      seq: seq ?? this.seq,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (licenseClass.present) {
      map['license_class'] = Variable<String>(licenseClass.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (passScore.present) {
      map['pass_score'] = Variable<int>(passScore.value);
    }
    if (passed.present) {
      map['passed'] = Variable<bool>(passed.value);
    }
    if (failedByCritical.present) {
      map['failed_by_critical'] = Variable<bool>(failedByCritical.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (seq.present) {
      map['seq'] = Variable<int>(seq.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamAttemptsCompanion(')
          ..write('clientId: $clientId, ')
          ..write('userId: $userId, ')
          ..write('licenseClass: $licenseClass, ')
          ..write('mode: $mode, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('correctCount: $correctCount, ')
          ..write('total: $total, ')
          ..write('passScore: $passScore, ')
          ..write('passed: $passed, ')
          ..write('failedByCritical: $failedByCritical, ')
          ..write('durationSec: $durationSec, ')
          ..write('startedAt: $startedAt, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('seq: $seq, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MetaTable extends Meta with TableInfo<$MetaTable, MetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<MetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  MetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $MetaTable createAlias(String alias) {
    return $MetaTable(attachedDatabase, alias);
  }
}

class MetaRow extends DataClass implements Insertable<MetaRow> {
  final String key;
  final String value;
  const MetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  MetaCompanion toCompanion(bool nullToAbsent) {
    return MetaCompanion(key: Value(key), value: Value(value));
  }

  factory MetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  MetaRow copyWith({String? key, String? value}) =>
      MetaRow(key: key ?? this.key, value: value ?? this.value);
  MetaRow copyWithCompanion(MetaCompanion data) {
    return MetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MetaRow && other.key == this.key && other.value == this.value);
}

class MetaCompanion extends UpdateCompanion<MetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const MetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<MetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return MetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $LicenseClassesTable licenseClasses = $LicenseClassesTable(this);
  late final $TrafficSignsTable trafficSigns = $TrafficSignsTable(this);
  late final $PenaltiesTable penalties = $PenaltiesTable(this);
  late final $AnswerEventsTable answerEvents = $AnswerEventsTable(this);
  late final $QuestionProgressTable questionProgress = $QuestionProgressTable(
    this,
  );
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $ExamSessionsTable examSessions = $ExamSessionsTable(this);
  late final $ExamAttemptsTable examAttempts = $ExamAttemptsTable(this);
  late final $MetaTable meta = $MetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    questions,
    categories,
    licenseClasses,
    trafficSigns,
    penalties,
    answerEvents,
    questionProgress,
    bookmarks,
    examSessions,
    examAttempts,
    meta,
  ];
}

typedef $$QuestionsTableCreateCompanionBuilder = QuestionsCompanion Function({
  required String id,
  required int number,
  required String content,
  required String searchText,
  Value<String?> imageUrl,
  Value<String?> imageHash,
  Value<String?> localImagePath,
  required String optionsJson,
  required String correctKey,
  Value<String?> explanation,
  Value<String?> legalRef,
  required String categoryCode,
  required String licenseClasses,
  required bool isCritical,
  required String status,
  required int version,
  Value<DateTime?> answerChangedAt,
  Value<int> rowid,
});
typedef $$QuestionsTableUpdateCompanionBuilder = QuestionsCompanion Function({
  Value<String> id,
  Value<int> number,
  Value<String> content,
  Value<String> searchText,
  Value<String?> imageUrl,
  Value<String?> imageHash,
  Value<String?> localImagePath,
  Value<String> optionsJson,
  Value<String> correctKey,
  Value<String?> explanation,
  Value<String?> legalRef,
  Value<String> categoryCode,
  Value<String> licenseClasses,
  Value<bool> isCritical,
  Value<String> status,
  Value<int> version,
  Value<DateTime?> answerChangedAt,
  Value<int> rowid,
});

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageHash => $composableBuilder(
    column: $table.imageHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctKey => $composableBuilder(
    column: $table.correctKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalRef => $composableBuilder(
    column: $table.legalRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryCode => $composableBuilder(
    column: $table.categoryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseClasses => $composableBuilder(
    column: $table.licenseClasses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answerChangedAt => $composableBuilder(
    column: $table.answerChangedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageHash => $composableBuilder(
    column: $table.imageHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctKey => $composableBuilder(
    column: $table.correctKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalRef => $composableBuilder(
    column: $table.legalRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryCode => $composableBuilder(
    column: $table.categoryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseClasses => $composableBuilder(
    column: $table.licenseClasses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answerChangedAt => $composableBuilder(
    column: $table.answerChangedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageHash =>
      $composableBuilder(column: $table.imageHash, builder: (column) => column);

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optionsJson => $composableBuilder(
    column: $table.optionsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correctKey => $composableBuilder(
    column: $table.correctKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get explanation => $composableBuilder(
    column: $table.explanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get legalRef =>
      $composableBuilder(column: $table.legalRef, builder: (column) => column);

  GeneratedColumn<String> get categoryCode => $composableBuilder(
    column: $table.categoryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get licenseClasses => $composableBuilder(
    column: $table.licenseClasses,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCritical => $composableBuilder(
    column: $table.isCritical,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get answerChangedAt => $composableBuilder(
    column: $table.answerChangedAt,
    builder: (column) => column,
  );
}

class $$QuestionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionsTable,
          Question,
          $$QuestionsTableFilterComposer,
          $$QuestionsTableOrderingComposer,
          $$QuestionsTableAnnotationComposer,
          $$QuestionsTableCreateCompanionBuilder,
          $$QuestionsTableUpdateCompanionBuilder,
          (Question, BaseReferences<_$AppDatabase, $QuestionsTable, Question>),
          Question,
          PrefetchHooks Function()
        > {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageHash = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<String> optionsJson = const Value.absent(),
                Value<String> correctKey = const Value.absent(),
                Value<String?> explanation = const Value.absent(),
                Value<String?> legalRef = const Value.absent(),
                Value<String> categoryCode = const Value.absent(),
                Value<String> licenseClasses = const Value.absent(),
                Value<bool> isCritical = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<DateTime?> answerChangedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion(
                id: id,
                number: number,
                content: content,
                searchText: searchText,
                imageUrl: imageUrl,
                imageHash: imageHash,
                localImagePath: localImagePath,
                optionsJson: optionsJson,
                correctKey: correctKey,
                explanation: explanation,
                legalRef: legalRef,
                categoryCode: categoryCode,
                licenseClasses: licenseClasses,
                isCritical: isCritical,
                status: status,
                version: version,
                answerChangedAt: answerChangedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int number,
                required String content,
                required String searchText,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageHash = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                required String optionsJson,
                required String correctKey,
                Value<String?> explanation = const Value.absent(),
                Value<String?> legalRef = const Value.absent(),
                required String categoryCode,
                required String licenseClasses,
                required bool isCritical,
                required String status,
                required int version,
                Value<DateTime?> answerChangedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionsCompanion.insert(
                id: id,
                number: number,
                content: content,
                searchText: searchText,
                imageUrl: imageUrl,
                imageHash: imageHash,
                localImagePath: localImagePath,
                optionsJson: optionsJson,
                correctKey: correctKey,
                explanation: explanation,
                legalRef: legalRef,
                categoryCode: categoryCode,
                licenseClasses: licenseClasses,
                isCritical: isCritical,
                status: status,
                version: version,
                answerChangedAt: answerChangedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionsTable, Question>(table),
                  BaseReferences<_$AppDatabase, $QuestionsTable, Question>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuestionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionsTable,
      Question,
      $$QuestionsTableFilterComposer,
      $$QuestionsTableOrderingComposer,
      $$QuestionsTableAnnotationComposer,
      $$QuestionsTableCreateCompanionBuilder,
      $$QuestionsTableUpdateCompanionBuilder,
      (Question, BaseReferences<_$AppDatabase, $QuestionsTable, Question>),
      Question,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String code,
  required String name,
  required int sortOrder,
  required int version,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> code,
  Value<String> name,
  Value<int> sortOrder,
  Value<int> version,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                code: code,
                name: name,
                sortOrder: sortOrder,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String name,
                required int sortOrder,
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                code: code,
                name: name,
                sortOrder: sortOrder,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  BaseReferences<_$AppDatabase, $CategoriesTable, Category>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$LicenseClassesTableCreateCompanionBuilder =
    LicenseClassesCompanion Function({
      required String code,
      required String name,
      required String description,
      required String examConfigJson,
      required int sortOrder,
      required int version,
      Value<int> rowid,
    });
typedef $$LicenseClassesTableUpdateCompanionBuilder =
    LicenseClassesCompanion Function({
      Value<String> code,
      Value<String> name,
      Value<String> description,
      Value<String> examConfigJson,
      Value<int> sortOrder,
      Value<int> version,
      Value<int> rowid,
    });

class $$LicenseClassesTableFilterComposer
    extends Composer<_$AppDatabase, $LicenseClassesTable> {
  $$LicenseClassesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examConfigJson => $composableBuilder(
    column: $table.examConfigJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LicenseClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $LicenseClassesTable> {
  $$LicenseClassesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examConfigJson => $composableBuilder(
    column: $table.examConfigJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LicenseClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LicenseClassesTable> {
  $$LicenseClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get examConfigJson => $composableBuilder(
    column: $table.examConfigJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$LicenseClassesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LicenseClassesTable,
          LicenseClassRow,
          $$LicenseClassesTableFilterComposer,
          $$LicenseClassesTableOrderingComposer,
          $$LicenseClassesTableAnnotationComposer,
          $$LicenseClassesTableCreateCompanionBuilder,
          $$LicenseClassesTableUpdateCompanionBuilder,
          (
            LicenseClassRow,
            BaseReferences<
              _$AppDatabase,
              $LicenseClassesTable,
              LicenseClassRow
            >,
          ),
          LicenseClassRow,
          PrefetchHooks Function()
        > {
  $$LicenseClassesTableTableManager(
    _$AppDatabase db,
    $LicenseClassesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LicenseClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LicenseClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LicenseClassesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> examConfigJson = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LicenseClassesCompanion(
                code: code,
                name: name,
                description: description,
                examConfigJson: examConfigJson,
                sortOrder: sortOrder,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String name,
                required String description,
                required String examConfigJson,
                required int sortOrder,
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => LicenseClassesCompanion.insert(
                code: code,
                name: name,
                description: description,
                examConfigJson: examConfigJson,
                sortOrder: sortOrder,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LicenseClassesTable, LicenseClassRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $LicenseClassesTable,
                    LicenseClassRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LicenseClassesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LicenseClassesTable,
      LicenseClassRow,
      $$LicenseClassesTableFilterComposer,
      $$LicenseClassesTableOrderingComposer,
      $$LicenseClassesTableAnnotationComposer,
      $$LicenseClassesTableCreateCompanionBuilder,
      $$LicenseClassesTableUpdateCompanionBuilder,
      (
        LicenseClassRow,
        BaseReferences<_$AppDatabase, $LicenseClassesTable, LicenseClassRow>,
      ),
      LicenseClassRow,
      PrefetchHooks Function()
    >;
typedef $$TrafficSignsTableCreateCompanionBuilder =
    TrafficSignsCompanion Function({
      required String id,
      required String code,
      required String name,
      required String groupCode,
      required String description,
      Value<String?> imageUrl,
      Value<String?> imageHash,
      Value<String?> localImagePath,
      required String searchText,
      required String status,
      required int version,
      Value<int> rowid,
    });
typedef $$TrafficSignsTableUpdateCompanionBuilder =
    TrafficSignsCompanion Function({
      Value<String> id,
      Value<String> code,
      Value<String> name,
      Value<String> groupCode,
      Value<String> description,
      Value<String?> imageUrl,
      Value<String?> imageHash,
      Value<String?> localImagePath,
      Value<String> searchText,
      Value<String> status,
      Value<int> version,
      Value<int> rowid,
    });

class $$TrafficSignsTableFilterComposer
    extends Composer<_$AppDatabase, $TrafficSignsTable> {
  $$TrafficSignsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageHash => $composableBuilder(
    column: $table.imageHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrafficSignsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrafficSignsTable> {
  $$TrafficSignsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupCode => $composableBuilder(
    column: $table.groupCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageHash => $composableBuilder(
    column: $table.imageHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrafficSignsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrafficSignsTable> {
  $$TrafficSignsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get groupCode =>
      $composableBuilder(column: $table.groupCode, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get imageHash =>
      $composableBuilder(column: $table.imageHash, builder: (column) => column);

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$TrafficSignsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrafficSignsTable,
          TrafficSign,
          $$TrafficSignsTableFilterComposer,
          $$TrafficSignsTableOrderingComposer,
          $$TrafficSignsTableAnnotationComposer,
          $$TrafficSignsTableCreateCompanionBuilder,
          $$TrafficSignsTableUpdateCompanionBuilder,
          (
            TrafficSign,
            BaseReferences<_$AppDatabase, $TrafficSignsTable, TrafficSign>,
          ),
          TrafficSign,
          PrefetchHooks Function()
        > {
  $$TrafficSignsTableTableManager(_$AppDatabase db, $TrafficSignsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrafficSignsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrafficSignsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrafficSignsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> groupCode = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageHash = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrafficSignsCompanion(
                id: id,
                code: code,
                name: name,
                groupCode: groupCode,
                description: description,
                imageUrl: imageUrl,
                imageHash: imageHash,
                localImagePath: localImagePath,
                searchText: searchText,
                status: status,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String code,
                required String name,
                required String groupCode,
                required String description,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> imageHash = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                required String searchText,
                required String status,
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => TrafficSignsCompanion.insert(
                id: id,
                code: code,
                name: name,
                groupCode: groupCode,
                description: description,
                imageUrl: imageUrl,
                imageHash: imageHash,
                localImagePath: localImagePath,
                searchText: searchText,
                status: status,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrafficSignsTable, TrafficSign>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $TrafficSignsTable,
                    TrafficSign
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrafficSignsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrafficSignsTable,
      TrafficSign,
      $$TrafficSignsTableFilterComposer,
      $$TrafficSignsTableOrderingComposer,
      $$TrafficSignsTableAnnotationComposer,
      $$TrafficSignsTableCreateCompanionBuilder,
      $$TrafficSignsTableUpdateCompanionBuilder,
      (
        TrafficSign,
        BaseReferences<_$AppDatabase, $TrafficSignsTable, TrafficSign>,
      ),
      TrafficSign,
      PrefetchHooks Function()
    >;
typedef $$PenaltiesTableCreateCompanionBuilder = PenaltiesCompanion Function({
  required String id,
  required String violation,
  required String vehicleType,
  required int fineMin,
  required int fineMax,
  Value<String?> additionalPenalty,
  required String legalRef,
  required String searchText,
  required String status,
  required int version,
  Value<int> rowid,
});
typedef $$PenaltiesTableUpdateCompanionBuilder = PenaltiesCompanion Function({
  Value<String> id,
  Value<String> violation,
  Value<String> vehicleType,
  Value<int> fineMin,
  Value<int> fineMax,
  Value<String?> additionalPenalty,
  Value<String> legalRef,
  Value<String> searchText,
  Value<String> status,
  Value<int> version,
  Value<int> rowid,
});

class $$PenaltiesTableFilterComposer
    extends Composer<_$AppDatabase, $PenaltiesTable> {
  $$PenaltiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get violation => $composableBuilder(
    column: $table.violation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fineMin => $composableBuilder(
    column: $table.fineMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fineMax => $composableBuilder(
    column: $table.fineMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get additionalPenalty => $composableBuilder(
    column: $table.additionalPenalty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalRef => $composableBuilder(
    column: $table.legalRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PenaltiesTableOrderingComposer
    extends Composer<_$AppDatabase, $PenaltiesTable> {
  $$PenaltiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get violation => $composableBuilder(
    column: $table.violation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fineMin => $composableBuilder(
    column: $table.fineMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fineMax => $composableBuilder(
    column: $table.fineMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get additionalPenalty => $composableBuilder(
    column: $table.additionalPenalty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalRef => $composableBuilder(
    column: $table.legalRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PenaltiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PenaltiesTable> {
  $$PenaltiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get violation =>
      $composableBuilder(column: $table.violation, builder: (column) => column);

  GeneratedColumn<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fineMin =>
      $composableBuilder(column: $table.fineMin, builder: (column) => column);

  GeneratedColumn<int> get fineMax =>
      $composableBuilder(column: $table.fineMax, builder: (column) => column);

  GeneratedColumn<String> get additionalPenalty => $composableBuilder(
    column: $table.additionalPenalty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get legalRef =>
      $composableBuilder(column: $table.legalRef, builder: (column) => column);

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);
}

class $$PenaltiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PenaltiesTable,
          Penalty,
          $$PenaltiesTableFilterComposer,
          $$PenaltiesTableOrderingComposer,
          $$PenaltiesTableAnnotationComposer,
          $$PenaltiesTableCreateCompanionBuilder,
          $$PenaltiesTableUpdateCompanionBuilder,
          (Penalty, BaseReferences<_$AppDatabase, $PenaltiesTable, Penalty>),
          Penalty,
          PrefetchHooks Function()
        > {
  $$PenaltiesTableTableManager(_$AppDatabase db, $PenaltiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PenaltiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PenaltiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PenaltiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> violation = const Value.absent(),
                Value<String> vehicleType = const Value.absent(),
                Value<int> fineMin = const Value.absent(),
                Value<int> fineMax = const Value.absent(),
                Value<String?> additionalPenalty = const Value.absent(),
                Value<String> legalRef = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PenaltiesCompanion(
                id: id,
                violation: violation,
                vehicleType: vehicleType,
                fineMin: fineMin,
                fineMax: fineMax,
                additionalPenalty: additionalPenalty,
                legalRef: legalRef,
                searchText: searchText,
                status: status,
                version: version,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String violation,
                required String vehicleType,
                required int fineMin,
                required int fineMax,
                Value<String?> additionalPenalty = const Value.absent(),
                required String legalRef,
                required String searchText,
                required String status,
                required int version,
                Value<int> rowid = const Value.absent(),
              }) => PenaltiesCompanion.insert(
                id: id,
                violation: violation,
                vehicleType: vehicleType,
                fineMin: fineMin,
                fineMax: fineMax,
                additionalPenalty: additionalPenalty,
                legalRef: legalRef,
                searchText: searchText,
                status: status,
                version: version,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PenaltiesTable, Penalty>(table),
                  BaseReferences<_$AppDatabase, $PenaltiesTable, Penalty>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PenaltiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PenaltiesTable,
      Penalty,
      $$PenaltiesTableFilterComposer,
      $$PenaltiesTableOrderingComposer,
      $$PenaltiesTableAnnotationComposer,
      $$PenaltiesTableCreateCompanionBuilder,
      $$PenaltiesTableUpdateCompanionBuilder,
      (Penalty, BaseReferences<_$AppDatabase, $PenaltiesTable, Penalty>),
      Penalty,
      PrefetchHooks Function()
    >;
typedef $$AnswerEventsTableCreateCompanionBuilder =
    AnswerEventsCompanion Function({
      required String clientEventId,
      Value<String?> userId,
      required String questionId,
      required int questionNumber,
      Value<String?> selectedKey,
      required bool isCorrect,
      Value<int?> responseMs,
      required String source,
      Value<String?> examClientId,
      required DateTime answeredAt,
      required String deviceId,
      Value<int?> seq,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$AnswerEventsTableUpdateCompanionBuilder =
    AnswerEventsCompanion Function({
      Value<String> clientEventId,
      Value<String?> userId,
      Value<String> questionId,
      Value<int> questionNumber,
      Value<String?> selectedKey,
      Value<bool> isCorrect,
      Value<int?> responseMs,
      Value<String> source,
      Value<String?> examClientId,
      Value<DateTime> answeredAt,
      Value<String> deviceId,
      Value<int?> seq,
      Value<bool> synced,
      Value<int> rowid,
    });

class $$AnswerEventsTableFilterComposer
    extends Composer<_$AppDatabase, $AnswerEventsTable> {
  $$AnswerEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientEventId => $composableBuilder(
    column: $table.clientEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionNumber => $composableBuilder(
    column: $table.questionNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedKey => $composableBuilder(
    column: $table.selectedKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get responseMs => $composableBuilder(
    column: $table.responseMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get examClientId => $composableBuilder(
    column: $table.examClientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnswerEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnswerEventsTable> {
  $$AnswerEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientEventId => $composableBuilder(
    column: $table.clientEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionNumber => $composableBuilder(
    column: $table.questionNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedKey => $composableBuilder(
    column: $table.selectedKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get responseMs => $composableBuilder(
    column: $table.responseMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get examClientId => $composableBuilder(
    column: $table.examClientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnswerEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnswerEventsTable> {
  $$AnswerEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientEventId => $composableBuilder(
    column: $table.clientEventId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get questionNumber => $composableBuilder(
    column: $table.questionNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedKey => $composableBuilder(
    column: $table.selectedKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<int> get responseMs => $composableBuilder(
    column: $table.responseMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get examClientId => $composableBuilder(
    column: $table.examClientId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get answeredAt => $composableBuilder(
    column: $table.answeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$AnswerEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnswerEventsTable,
          AnswerEvent,
          $$AnswerEventsTableFilterComposer,
          $$AnswerEventsTableOrderingComposer,
          $$AnswerEventsTableAnnotationComposer,
          $$AnswerEventsTableCreateCompanionBuilder,
          $$AnswerEventsTableUpdateCompanionBuilder,
          (
            AnswerEvent,
            BaseReferences<_$AppDatabase, $AnswerEventsTable, AnswerEvent>,
          ),
          AnswerEvent,
          PrefetchHooks Function()
        > {
  $$AnswerEventsTableTableManager(_$AppDatabase db, $AnswerEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnswerEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnswerEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnswerEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientEventId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<int> questionNumber = const Value.absent(),
                Value<String?> selectedKey = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int?> responseMs = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String?> examClientId = const Value.absent(),
                Value<DateTime> answeredAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int?> seq = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnswerEventsCompanion(
                clientEventId: clientEventId,
                userId: userId,
                questionId: questionId,
                questionNumber: questionNumber,
                selectedKey: selectedKey,
                isCorrect: isCorrect,
                responseMs: responseMs,
                source: source,
                examClientId: examClientId,
                answeredAt: answeredAt,
                deviceId: deviceId,
                seq: seq,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientEventId,
                Value<String?> userId = const Value.absent(),
                required String questionId,
                required int questionNumber,
                Value<String?> selectedKey = const Value.absent(),
                required bool isCorrect,
                Value<int?> responseMs = const Value.absent(),
                required String source,
                Value<String?> examClientId = const Value.absent(),
                required DateTime answeredAt,
                required String deviceId,
                Value<int?> seq = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnswerEventsCompanion.insert(
                clientEventId: clientEventId,
                userId: userId,
                questionId: questionId,
                questionNumber: questionNumber,
                selectedKey: selectedKey,
                isCorrect: isCorrect,
                responseMs: responseMs,
                source: source,
                examClientId: examClientId,
                answeredAt: answeredAt,
                deviceId: deviceId,
                seq: seq,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AnswerEventsTable, AnswerEvent>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AnswerEventsTable,
                    AnswerEvent
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnswerEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnswerEventsTable,
      AnswerEvent,
      $$AnswerEventsTableFilterComposer,
      $$AnswerEventsTableOrderingComposer,
      $$AnswerEventsTableAnnotationComposer,
      $$AnswerEventsTableCreateCompanionBuilder,
      $$AnswerEventsTableUpdateCompanionBuilder,
      (
        AnswerEvent,
        BaseReferences<_$AppDatabase, $AnswerEventsTable, AnswerEvent>,
      ),
      AnswerEvent,
      PrefetchHooks Function()
    >;
typedef $$QuestionProgressTableCreateCompanionBuilder =
    QuestionProgressCompanion Function({
      required String questionId,
      required double ef,
      required int interval,
      required int reps,
      Value<String?> dueDate,
      required int correctCount,
      required int wrongCount,
      required int consecutiveCorrect,
      required bool inWrongBook,
      Value<DateTime?> lastAnsweredAt,
      Value<int> rowid,
    });
typedef $$QuestionProgressTableUpdateCompanionBuilder =
    QuestionProgressCompanion Function({
      Value<String> questionId,
      Value<double> ef,
      Value<int> interval,
      Value<int> reps,
      Value<String?> dueDate,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<int> consecutiveCorrect,
      Value<bool> inWrongBook,
      Value<DateTime?> lastAnsweredAt,
      Value<int> rowid,
    });

class $$QuestionProgressTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionProgressTable> {
  $$QuestionProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ef => $composableBuilder(
    column: $table.ef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get consecutiveCorrect => $composableBuilder(
    column: $table.consecutiveCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inWrongBook => $composableBuilder(
    column: $table.inWrongBook,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$QuestionProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionProgressTable> {
  $$QuestionProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ef => $composableBuilder(
    column: $table.ef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interval => $composableBuilder(
    column: $table.interval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get consecutiveCorrect => $composableBuilder(
    column: $table.consecutiveCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inWrongBook => $composableBuilder(
    column: $table.inWrongBook,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$QuestionProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionProgressTable> {
  $$QuestionProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ef =>
      $composableBuilder(column: $table.ef, builder: (column) => column);

  GeneratedColumn<int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get consecutiveCorrect => $composableBuilder(
    column: $table.consecutiveCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get inWrongBook => $composableBuilder(
    column: $table.inWrongBook,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => column,
  );
}

class $$QuestionProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuestionProgressTable,
          ProgressRow,
          $$QuestionProgressTableFilterComposer,
          $$QuestionProgressTableOrderingComposer,
          $$QuestionProgressTableAnnotationComposer,
          $$QuestionProgressTableCreateCompanionBuilder,
          $$QuestionProgressTableUpdateCompanionBuilder,
          (
            ProgressRow,
            BaseReferences<_$AppDatabase, $QuestionProgressTable, ProgressRow>,
          ),
          ProgressRow,
          PrefetchHooks Function()
        > {
  $$QuestionProgressTableTableManager(
    _$AppDatabase db,
    $QuestionProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<double> ef = const Value.absent(),
                Value<int> interval = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<String?> dueDate = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<int> consecutiveCorrect = const Value.absent(),
                Value<bool> inWrongBook = const Value.absent(),
                Value<DateTime?> lastAnsweredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionProgressCompanion(
                questionId: questionId,
                ef: ef,
                interval: interval,
                reps: reps,
                dueDate: dueDate,
                correctCount: correctCount,
                wrongCount: wrongCount,
                consecutiveCorrect: consecutiveCorrect,
                inWrongBook: inWrongBook,
                lastAnsweredAt: lastAnsweredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                required double ef,
                required int interval,
                required int reps,
                Value<String?> dueDate = const Value.absent(),
                required int correctCount,
                required int wrongCount,
                required int consecutiveCorrect,
                required bool inWrongBook,
                Value<DateTime?> lastAnsweredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuestionProgressCompanion.insert(
                questionId: questionId,
                ef: ef,
                interval: interval,
                reps: reps,
                dueDate: dueDate,
                correctCount: correctCount,
                wrongCount: wrongCount,
                consecutiveCorrect: consecutiveCorrect,
                inWrongBook: inWrongBook,
                lastAnsweredAt: lastAnsweredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuestionProgressTable, ProgressRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $QuestionProgressTable,
                    ProgressRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$QuestionProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuestionProgressTable,
      ProgressRow,
      $$QuestionProgressTableFilterComposer,
      $$QuestionProgressTableOrderingComposer,
      $$QuestionProgressTableAnnotationComposer,
      $$QuestionProgressTableCreateCompanionBuilder,
      $$QuestionProgressTableUpdateCompanionBuilder,
      (
        ProgressRow,
        BaseReferences<_$AppDatabase, $QuestionProgressTable, ProgressRow>,
      ),
      ProgressRow,
      PrefetchHooks Function()
    >;
typedef $$BookmarksTableCreateCompanionBuilder = BookmarksCompanion Function({
  required String questionId,
  required bool bookmarked,
  required DateTime clientUpdatedAt,
  Value<String?> userId,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$BookmarksTableUpdateCompanionBuilder = BookmarksCompanion Function({
  Value<String> questionId,
  Value<bool> bookmarked,
  Value<DateTime> clientUpdatedAt,
  Value<String?> userId,
  Value<bool> synced,
  Value<int> rowid,
});

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bookmarked => $composableBuilder(
    column: $table.bookmarked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bookmarked => $composableBuilder(
    column: $table.bookmarked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get bookmarked => $composableBuilder(
    column: $table.bookmarked,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientUpdatedAt => $composableBuilder(
    column: $table.clientUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
          Bookmark,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionId = const Value.absent(),
                Value<bool> bookmarked = const Value.absent(),
                Value<DateTime> clientUpdatedAt = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion(
                questionId: questionId,
                bookmarked: bookmarked,
                clientUpdatedAt: clientUpdatedAt,
                userId: userId,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionId,
                required bool bookmarked,
                required DateTime clientUpdatedAt,
                Value<String?> userId = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookmarksCompanion.insert(
                questionId: questionId,
                bookmarked: bookmarked,
                clientUpdatedAt: clientUpdatedAt,
                userId: userId,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BookmarksTable, Bookmark>(table),
                  BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark>),
      Bookmark,
      PrefetchHooks Function()
    >;
typedef $$ExamSessionsTableCreateCompanionBuilder =
    ExamSessionsCompanion Function({
      required String id,
      required String licenseClass,
      required String mode,
      required String questionIdsJson,
      required String answersJson,
      required int passScore,
      required DateTime startedAt,
      required DateTime deadlineAt,
      required String status,
      Value<int> rowid,
    });
typedef $$ExamSessionsTableUpdateCompanionBuilder =
    ExamSessionsCompanion Function({
      Value<String> id,
      Value<String> licenseClass,
      Value<String> mode,
      Value<String> questionIdsJson,
      Value<String> answersJson,
      Value<int> passScore,
      Value<DateTime> startedAt,
      Value<DateTime> deadlineAt,
      Value<String> status,
      Value<int> rowid,
    });

class $$ExamSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ExamSessionsTable> {
  $$ExamSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseClass => $composableBuilder(
    column: $table.licenseClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get passScore => $composableBuilder(
    column: $table.passScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadlineAt => $composableBuilder(
    column: $table.deadlineAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExamSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamSessionsTable> {
  $$ExamSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseClass => $composableBuilder(
    column: $table.licenseClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get passScore => $composableBuilder(
    column: $table.passScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadlineAt => $composableBuilder(
    column: $table.deadlineAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExamSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamSessionsTable> {
  $$ExamSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get licenseClass => $composableBuilder(
    column: $table.licenseClass,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get questionIdsJson => $composableBuilder(
    column: $table.questionIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get passScore =>
      $composableBuilder(column: $table.passScore, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deadlineAt => $composableBuilder(
    column: $table.deadlineAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ExamSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamSessionsTable,
          ExamSession,
          $$ExamSessionsTableFilterComposer,
          $$ExamSessionsTableOrderingComposer,
          $$ExamSessionsTableAnnotationComposer,
          $$ExamSessionsTableCreateCompanionBuilder,
          $$ExamSessionsTableUpdateCompanionBuilder,
          (
            ExamSession,
            BaseReferences<_$AppDatabase, $ExamSessionsTable, ExamSession>,
          ),
          ExamSession,
          PrefetchHooks Function()
        > {
  $$ExamSessionsTableTableManager(_$AppDatabase db, $ExamSessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> licenseClass = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> questionIdsJson = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<int> passScore = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> deadlineAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamSessionsCompanion(
                id: id,
                licenseClass: licenseClass,
                mode: mode,
                questionIdsJson: questionIdsJson,
                answersJson: answersJson,
                passScore: passScore,
                startedAt: startedAt,
                deadlineAt: deadlineAt,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String licenseClass,
                required String mode,
                required String questionIdsJson,
                required String answersJson,
                required int passScore,
                required DateTime startedAt,
                required DateTime deadlineAt,
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ExamSessionsCompanion.insert(
                id: id,
                licenseClass: licenseClass,
                mode: mode,
                questionIdsJson: questionIdsJson,
                answersJson: answersJson,
                passScore: passScore,
                startedAt: startedAt,
                deadlineAt: deadlineAt,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamSessionsTable, ExamSession>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExamSessionsTable,
                    ExamSession
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExamSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamSessionsTable,
      ExamSession,
      $$ExamSessionsTableFilterComposer,
      $$ExamSessionsTableOrderingComposer,
      $$ExamSessionsTableAnnotationComposer,
      $$ExamSessionsTableCreateCompanionBuilder,
      $$ExamSessionsTableUpdateCompanionBuilder,
      (
        ExamSession,
        BaseReferences<_$AppDatabase, $ExamSessionsTable, ExamSession>,
      ),
      ExamSession,
      PrefetchHooks Function()
    >;
typedef $$ExamAttemptsTableCreateCompanionBuilder =
    ExamAttemptsCompanion Function({
      required String clientId,
      Value<String?> userId,
      required String licenseClass,
      required String mode,
      required String itemsJson,
      required int correctCount,
      required int total,
      required int passScore,
      required bool passed,
      required bool failedByCritical,
      required int durationSec,
      required DateTime startedAt,
      required DateTime submittedAt,
      required String deviceId,
      Value<int?> seq,
      Value<bool> synced,
      Value<int> rowid,
    });
typedef $$ExamAttemptsTableUpdateCompanionBuilder =
    ExamAttemptsCompanion Function({
      Value<String> clientId,
      Value<String?> userId,
      Value<String> licenseClass,
      Value<String> mode,
      Value<String> itemsJson,
      Value<int> correctCount,
      Value<int> total,
      Value<int> passScore,
      Value<bool> passed,
      Value<bool> failedByCritical,
      Value<int> durationSec,
      Value<DateTime> startedAt,
      Value<DateTime> submittedAt,
      Value<String> deviceId,
      Value<int?> seq,
      Value<bool> synced,
      Value<int> rowid,
    });

class $$ExamAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $ExamAttemptsTable> {
  $$ExamAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get licenseClass => $composableBuilder(
    column: $table.licenseClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get passScore => $composableBuilder(
    column: $table.passScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get passed => $composableBuilder(
    column: $table.passed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get failedByCritical => $composableBuilder(
    column: $table.failedByCritical,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExamAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamAttemptsTable> {
  $$ExamAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get licenseClass => $composableBuilder(
    column: $table.licenseClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get passScore => $composableBuilder(
    column: $table.passScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get passed => $composableBuilder(
    column: $table.passed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get failedByCritical => $composableBuilder(
    column: $table.failedByCritical,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get seq => $composableBuilder(
    column: $table.seq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExamAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamAttemptsTable> {
  $$ExamAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get licenseClass => $composableBuilder(
    column: $table.licenseClass,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<int> get passScore =>
      $composableBuilder(column: $table.passScore, builder: (column) => column);

  GeneratedColumn<bool> get passed =>
      $composableBuilder(column: $table.passed, builder: (column) => column);

  GeneratedColumn<bool> get failedByCritical => $composableBuilder(
    column: $table.failedByCritical,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get seq =>
      $composableBuilder(column: $table.seq, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);
}

class $$ExamAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExamAttemptsTable,
          ExamAttempt,
          $$ExamAttemptsTableFilterComposer,
          $$ExamAttemptsTableOrderingComposer,
          $$ExamAttemptsTableAnnotationComposer,
          $$ExamAttemptsTableCreateCompanionBuilder,
          $$ExamAttemptsTableUpdateCompanionBuilder,
          (
            ExamAttempt,
            BaseReferences<_$AppDatabase, $ExamAttemptsTable, ExamAttempt>,
          ),
          ExamAttempt,
          PrefetchHooks Function()
        > {
  $$ExamAttemptsTableTableManager(_$AppDatabase db, $ExamAttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clientId = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String> licenseClass = const Value.absent(),
                Value<String> mode = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<int> passScore = const Value.absent(),
                Value<bool> passed = const Value.absent(),
                Value<bool> failedByCritical = const Value.absent(),
                Value<int> durationSec = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> submittedAt = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int?> seq = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamAttemptsCompanion(
                clientId: clientId,
                userId: userId,
                licenseClass: licenseClass,
                mode: mode,
                itemsJson: itemsJson,
                correctCount: correctCount,
                total: total,
                passScore: passScore,
                passed: passed,
                failedByCritical: failedByCritical,
                durationSec: durationSec,
                startedAt: startedAt,
                submittedAt: submittedAt,
                deviceId: deviceId,
                seq: seq,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientId,
                Value<String?> userId = const Value.absent(),
                required String licenseClass,
                required String mode,
                required String itemsJson,
                required int correctCount,
                required int total,
                required int passScore,
                required bool passed,
                required bool failedByCritical,
                required int durationSec,
                required DateTime startedAt,
                required DateTime submittedAt,
                required String deviceId,
                Value<int?> seq = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExamAttemptsCompanion.insert(
                clientId: clientId,
                userId: userId,
                licenseClass: licenseClass,
                mode: mode,
                itemsJson: itemsJson,
                correctCount: correctCount,
                total: total,
                passScore: passScore,
                passed: passed,
                failedByCritical: failedByCritical,
                durationSec: durationSec,
                startedAt: startedAt,
                submittedAt: submittedAt,
                deviceId: deviceId,
                seq: seq,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExamAttemptsTable, ExamAttempt>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExamAttemptsTable,
                    ExamAttempt
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExamAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExamAttemptsTable,
      ExamAttempt,
      $$ExamAttemptsTableFilterComposer,
      $$ExamAttemptsTableOrderingComposer,
      $$ExamAttemptsTableAnnotationComposer,
      $$ExamAttemptsTableCreateCompanionBuilder,
      $$ExamAttemptsTableUpdateCompanionBuilder,
      (
        ExamAttempt,
        BaseReferences<_$AppDatabase, $ExamAttemptsTable, ExamAttempt>,
      ),
      ExamAttempt,
      PrefetchHooks Function()
    >;
typedef $$MetaTableCreateCompanionBuilder = MetaCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$MetaTableUpdateCompanionBuilder = MetaCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$MetaTableFilterComposer extends Composer<_$AppDatabase, $MetaTable> {
  $$MetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MetaTableOrderingComposer extends Composer<_$AppDatabase, $MetaTable> {
  $$MetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetaTable> {
  $$MetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$MetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetaTable,
          MetaRow,
          $$MetaTableFilterComposer,
          $$MetaTableOrderingComposer,
          $$MetaTableAnnotationComposer,
          $$MetaTableCreateCompanionBuilder,
          $$MetaTableUpdateCompanionBuilder,
          (MetaRow, BaseReferences<_$AppDatabase, $MetaTable, MetaRow>),
          MetaRow,
          PrefetchHooks Function()
        > {
  $$MetaTableTableManager(_$AppDatabase db, $MetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => MetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => MetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetaTable, MetaRow>(table),
                  BaseReferences<_$AppDatabase, $MetaTable, MetaRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetaTable,
      MetaRow,
      $$MetaTableFilterComposer,
      $$MetaTableOrderingComposer,
      $$MetaTableAnnotationComposer,
      $$MetaTableCreateCompanionBuilder,
      $$MetaTableUpdateCompanionBuilder,
      (MetaRow, BaseReferences<_$AppDatabase, $MetaTable, MetaRow>),
      MetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$LicenseClassesTableTableManager get licenseClasses =>
      $$LicenseClassesTableTableManager(_db, _db.licenseClasses);
  $$TrafficSignsTableTableManager get trafficSigns =>
      $$TrafficSignsTableTableManager(_db, _db.trafficSigns);
  $$PenaltiesTableTableManager get penalties =>
      $$PenaltiesTableTableManager(_db, _db.penalties);
  $$AnswerEventsTableTableManager get answerEvents =>
      $$AnswerEventsTableTableManager(_db, _db.answerEvents);
  $$QuestionProgressTableTableManager get questionProgress =>
      $$QuestionProgressTableTableManager(_db, _db.questionProgress);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$ExamSessionsTableTableManager get examSessions =>
      $$ExamSessionsTableTableManager(_db, _db.examSessions);
  $$ExamAttemptsTableTableManager get examAttempts =>
      $$ExamAttemptsTableTableManager(_db, _db.examAttempts);
  $$MetaTableTableManager get meta => $$MetaTableTableManager(_db, _db.meta);
}
