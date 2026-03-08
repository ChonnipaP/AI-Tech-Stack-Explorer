// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NewsAnalysesTable extends NewsAnalyses
    with TableInfo<$NewsAnalysesTable, NewsAnalyse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsAnalysesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id', aliasedName, false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints:
        GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title', aliasedName, false,
    type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _extractedTextMeta =
      const VerificationMeta('extractedText');
  @override
  late final GeneratedColumn<String> extractedText = GeneratedColumn<String>(
    'extracted_text', aliasedName, false,
    type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _aiSummaryMeta =
      const VerificationMeta('aiSummary');
  @override
  late final GeneratedColumn<String> aiSummary = GeneratedColumn<String>(
    'ai_summary', aliasedName, false,
    type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _analysisTypeMeta =
      const VerificationMeta('analysisType');
  @override
  late final GeneratedColumn<String> analysisType = GeneratedColumn<String>(
    'analysis_type', aliasedName, false,
    type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at', aliasedName, false,
    type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite', aliasedName, false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints:
        GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
    defaultValue: const Constant(false));
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags', aliasedName, false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''));
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, extractedText, aiSummary, analysisType, createdAt, isFavorite, tags];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news_analyses';
  @override
  VerificationContext validateIntegrity(Insertable<NewsAnalyse> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('extracted_text')) {
      context.handle(_extractedTextMeta,
          extractedText.isAcceptableOrUnknown(data['extracted_text']!, _extractedTextMeta));
    } else if (isInserting) {
      context.missing(_extractedTextMeta);
    }
    if (data.containsKey('ai_summary')) {
      context.handle(_aiSummaryMeta,
          aiSummary.isAcceptableOrUnknown(data['ai_summary']!, _aiSummaryMeta));
    } else if (isInserting) {
      context.missing(_aiSummaryMeta);
    }
    if (data.containsKey('analysis_type')) {
      context.handle(_analysisTypeMeta,
          analysisType.isAcceptableOrUnknown(data['analysis_type']!, _analysisTypeMeta));
    } else if (isInserting) {
      context.missing(_analysisTypeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(_isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewsAnalyse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewsAnalyse(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      extractedText: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}extracted_text'])!,
      aiSummary: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}ai_summary'])!,
      analysisType: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}analysis_type'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isFavorite: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      tags: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
    );
  }

  @override
  $NewsAnalysesTable createAlias(String alias) {
    return $NewsAnalysesTable(attachedDatabase, alias);
  }
}

class NewsAnalyse extends DataClass implements Insertable<NewsAnalyse> {
  final int id;
  final String title;
  final String extractedText;
  final String aiSummary;
  final String analysisType;
  final DateTime createdAt;
  final bool isFavorite;
  final String tags;
  const NewsAnalyse(
      {required this.id,
      required this.title,
      required this.extractedText,
      required this.aiSummary,
      required this.analysisType,
      required this.createdAt,
      required this.isFavorite,
      required this.tags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['extracted_text'] = Variable<String>(extractedText);
    map['ai_summary'] = Variable<String>(aiSummary);
    map['analysis_type'] = Variable<String>(analysisType);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['tags'] = Variable<String>(tags);
    return map;
  }

  NewsAnalysesCompanion toCompanion(bool nullToAbsent) {
    return NewsAnalysesCompanion(
      id: Value(id),
      title: Value(title),
      extractedText: Value(extractedText),
      aiSummary: Value(aiSummary),
      analysisType: Value(analysisType),
      createdAt: Value(createdAt),
      isFavorite: Value(isFavorite),
      tags: Value(tags),
    );
  }

  factory NewsAnalyse.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewsAnalyse(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      extractedText: serializer.fromJson<String>(json['extractedText']),
      aiSummary: serializer.fromJson<String>(json['aiSummary']),
      analysisType: serializer.fromJson<String>(json['analysisType']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'extractedText': serializer.toJson<String>(extractedText),
      'aiSummary': serializer.toJson<String>(aiSummary),
      'analysisType': serializer.toJson<String>(analysisType),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'tags': serializer.toJson<String>(tags),
    };
  }

  NewsAnalyse copyWith(
          {int? id,
          String? title,
          String? extractedText,
          String? aiSummary,
          String? analysisType,
          DateTime? createdAt,
          bool? isFavorite,
          String? tags}) =>
      NewsAnalyse(
        id: id ?? this.id,
        title: title ?? this.title,
        extractedText: extractedText ?? this.extractedText,
        aiSummary: aiSummary ?? this.aiSummary,
        analysisType: analysisType ?? this.analysisType,
        createdAt: createdAt ?? this.createdAt,
        isFavorite: isFavorite ?? this.isFavorite,
        tags: tags ?? this.tags,
      );
  @override
  String toString() {
    return (StringBuffer('NewsAnalyse(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('extractedText: $extractedText, ')
          ..write('aiSummary: $aiSummary, ')
          ..write('analysisType: $analysisType, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, extractedText, aiSummary,
      analysisType, createdAt, isFavorite, tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewsAnalyse &&
          other.id == this.id &&
          other.title == this.title &&
          other.extractedText == this.extractedText &&
          other.aiSummary == this.aiSummary &&
          other.analysisType == this.analysisType &&
          other.createdAt == this.createdAt &&
          other.isFavorite == this.isFavorite &&
          other.tags == this.tags);
}

class NewsAnalysesCompanion extends UpdateCompanion<NewsAnalyse> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> extractedText;
  final Value<String> aiSummary;
  final Value<String> analysisType;
  final Value<DateTime> createdAt;
  final Value<bool> isFavorite;
  final Value<String> tags;
  const NewsAnalysesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.extractedText = const Value.absent(),
    this.aiSummary = const Value.absent(),
    this.analysisType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.tags = const Value.absent(),
  });
  NewsAnalysesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String extractedText,
    required String aiSummary,
    required String analysisType,
    required DateTime createdAt,
    this.isFavorite = const Value.absent(),
    this.tags = const Value.absent(),
  })  : title = Value(title),
        extractedText = Value(extractedText),
        aiSummary = Value(aiSummary),
        analysisType = Value(analysisType),
        createdAt = Value(createdAt);
  static Insertable<NewsAnalyse> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? extractedText,
    Expression<String>? aiSummary,
    Expression<String>? analysisType,
    Expression<DateTime>? createdAt,
    Expression<bool>? isFavorite,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (extractedText != null) 'extracted_text': extractedText,
      if (aiSummary != null) 'ai_summary': aiSummary,
      if (analysisType != null) 'analysis_type': analysisType,
      if (createdAt != null) 'created_at': createdAt,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (tags != null) 'tags': tags,
    });
  }

  NewsAnalysesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? extractedText,
      Value<String>? aiSummary,
      Value<String>? analysisType,
      Value<DateTime>? createdAt,
      Value<bool>? isFavorite,
      Value<String>? tags}) {
    return NewsAnalysesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      extractedText: extractedText ?? this.extractedText,
      aiSummary: aiSummary ?? this.aiSummary,
      analysisType: analysisType ?? this.analysisType,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (title.present) map['title'] = Variable<String>(title.value);
    if (extractedText.present) map['extracted_text'] = Variable<String>(extractedText.value);
    if (aiSummary.present) map['ai_summary'] = Variable<String>(aiSummary.value);
    if (analysisType.present) map['analysis_type'] = Variable<String>(analysisType.value);
    if (createdAt.present) map['created_at'] = Variable<DateTime>(createdAt.value);
    if (isFavorite.present) map['is_favorite'] = Variable<bool>(isFavorite.value);
    if (tags.present) map['tags'] = Variable<String>(tags.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsAnalysesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('extractedText: $extractedText, ')
          ..write('aiSummary: $aiSummary, ')
          ..write('analysisType: $analysisType, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id', aliasedName, false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints:
        GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title', aliasedName, false,
    type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content', aliasedName, false,
    type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood', aliasedName, true,
    type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date', aliasedName, false,
    type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _relatedIdMeta =
      const VerificationMeta('relatedId');
  @override
  late final GeneratedColumn<int> relatedId = GeneratedColumn<int>(
    'related_id', aliasedName, true,
    type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, mood, date, relatedId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(Insertable<JournalEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('related_id')) {
      context.handle(_relatedIdMeta,
          relatedId.isAcceptableOrUnknown(data['related_id']!, _relatedIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      content: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      mood: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}mood']),
      date: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      relatedId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}related_id']),
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final String title;
  final String content;
  final String? mood;
  final DateTime date;
  final int? relatedId;
  const JournalEntry(
      {required this.id,
      required this.title,
      required this.content,
      this.mood,
      required this.date,
      this.relatedId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || relatedId != null) {
      map['related_id'] = Variable<int>(relatedId);
    }
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      date: Value(date),
      relatedId: relatedId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedId),
    );
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      mood: serializer.fromJson<String?>(json['mood']),
      date: serializer.fromJson<DateTime>(json['date']),
      relatedId: serializer.fromJson<int?>(json['relatedId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'mood': serializer.toJson<String?>(mood),
      'date': serializer.toJson<DateTime>(date),
      'relatedId': serializer.toJson<int?>(relatedId),
    };
  }

  JournalEntry copyWith(
          {int? id,
          String? title,
          String? content,
          Value<String?> mood = const Value.absent(),
          DateTime? date,
          Value<int?> relatedId = const Value.absent()}) =>
      JournalEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        mood: mood.present ? mood.value : this.mood,
        date: date ?? this.date,
        relatedId: relatedId.present ? relatedId.value : this.relatedId,
      );
  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('date: $date, ')
          ..write('relatedId: $relatedId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, mood, date, relatedId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.mood == this.mood &&
          other.date == this.date &&
          other.relatedId == this.relatedId);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> content;
  final Value<String?> mood;
  final Value<DateTime> date;
  final Value<int?> relatedId;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.mood = const Value.absent(),
    this.date = const Value.absent(),
    this.relatedId = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String content,
    this.mood = const Value.absent(),
    required DateTime date,
    this.relatedId = const Value.absent(),
  })  : title = Value(title),
        content = Value(content),
        date = Value(date);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? mood,
    Expression<DateTime>? date,
    Expression<int>? relatedId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (mood != null) 'mood': mood,
      if (date != null) 'date': date,
      if (relatedId != null) 'related_id': relatedId,
    });
  }

  JournalEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? content,
      Value<String?>? mood,
      Value<DateTime>? date,
      Value<int?>? relatedId}) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      date: date ?? this.date,
      relatedId: relatedId ?? this.relatedId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (title.present) map['title'] = Variable<String>(title.value);
    if (content.present) map['content'] = Variable<String>(content.value);
    if (mood.present) map['mood'] = Variable<String>(mood.value);
    if (date.present) map['date'] = Variable<DateTime>(date.value);
    if (relatedId.present) map['related_id'] = Variable<int>(relatedId.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('date: $date, ')
          ..write('relatedId: $relatedId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $NewsAnalysesTable newsAnalyses = $NewsAnalysesTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [newsAnalyses, journalEntries];
}