// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_cache.dart';

// ignore_for_file: type=lint
class $CachedAnalysesTable extends CachedAnalyses
    with TableInfo<$CachedAnalysesTable, CachedAnalyse> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedAnalysesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inputMeta = const VerificationMeta('input');
  @override
  late final GeneratedColumn<String> input = GeneratedColumn<String>(
    'input',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _responseMeta = const VerificationMeta(
    'response',
  );
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
    'response',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [hash, input, response, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_analyses';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedAnalyse> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('hash')) {
      context.handle(
        _hashMeta,
        hash.isAcceptableOrUnknown(data['hash']!, _hashMeta),
      );
    } else if (isInserting) {
      context.missing(_hashMeta);
    }
    if (data.containsKey('input')) {
      context.handle(
        _inputMeta,
        input.isAcceptableOrUnknown(data['input']!, _inputMeta),
      );
    } else if (isInserting) {
      context.missing(_inputMeta);
    }
    if (data.containsKey('response')) {
      context.handle(
        _responseMeta,
        response.isAcceptableOrUnknown(data['response']!, _responseMeta),
      );
    } else if (isInserting) {
      context.missing(_responseMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {hash};
  @override
  CachedAnalyse map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedAnalyse(
      hash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash'],
      )!,
      input: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}input'],
      )!,
      response: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedAnalysesTable createAlias(String alias) {
    return $CachedAnalysesTable(attachedDatabase, alias);
  }
}

class CachedAnalyse extends DataClass implements Insertable<CachedAnalyse> {
  final String hash;
  final String input;
  final String response;
  final int createdAt;
  const CachedAnalyse({
    required this.hash,
    required this.input,
    required this.response,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['hash'] = Variable<String>(hash);
    map['input'] = Variable<String>(input);
    map['response'] = Variable<String>(response);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  CachedAnalysesCompanion toCompanion(bool nullToAbsent) {
    return CachedAnalysesCompanion(
      hash: Value(hash),
      input: Value(input),
      response: Value(response),
      createdAt: Value(createdAt),
    );
  }

  factory CachedAnalyse.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedAnalyse(
      hash: serializer.fromJson<String>(json['hash']),
      input: serializer.fromJson<String>(json['input']),
      response: serializer.fromJson<String>(json['response']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hash': serializer.toJson<String>(hash),
      'input': serializer.toJson<String>(input),
      'response': serializer.toJson<String>(response),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  CachedAnalyse copyWith({
    String? hash,
    String? input,
    String? response,
    int? createdAt,
  }) => CachedAnalyse(
    hash: hash ?? this.hash,
    input: input ?? this.input,
    response: response ?? this.response,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedAnalyse copyWithCompanion(CachedAnalysesCompanion data) {
    return CachedAnalyse(
      hash: data.hash.present ? data.hash.value : this.hash,
      input: data.input.present ? data.input.value : this.input,
      response: data.response.present ? data.response.value : this.response,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedAnalyse(')
          ..write('hash: $hash, ')
          ..write('input: $input, ')
          ..write('response: $response, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(hash, input, response, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedAnalyse &&
          other.hash == this.hash &&
          other.input == this.input &&
          other.response == this.response &&
          other.createdAt == this.createdAt);
}

class CachedAnalysesCompanion extends UpdateCompanion<CachedAnalyse> {
  final Value<String> hash;
  final Value<String> input;
  final Value<String> response;
  final Value<int> createdAt;
  final Value<int> rowid;
  const CachedAnalysesCompanion({
    this.hash = const Value.absent(),
    this.input = const Value.absent(),
    this.response = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedAnalysesCompanion.insert({
    required String hash,
    required String input,
    required String response,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : hash = Value(hash),
       input = Value(input),
       response = Value(response),
       createdAt = Value(createdAt);
  static Insertable<CachedAnalyse> custom({
    Expression<String>? hash,
    Expression<String>? input,
    Expression<String>? response,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (hash != null) 'hash': hash,
      if (input != null) 'input': input,
      if (response != null) 'response': response,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedAnalysesCompanion copyWith({
    Value<String>? hash,
    Value<String>? input,
    Value<String>? response,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return CachedAnalysesCompanion(
      hash: hash ?? this.hash,
      input: input ?? this.input,
      response: response ?? this.response,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (input.present) {
      map['input'] = Variable<String>(input.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedAnalysesCompanion(')
          ..write('hash: $hash, ')
          ..write('input: $input, ')
          ..write('response: $response, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedWordsTable extends SavedWords
    with TableInfo<$SavedWordsTable, SavedWord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedWordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _thaiMeta = const VerificationMeta('thai');
  @override
  late final GeneratedColumn<String> thai = GeneratedColumn<String>(
    'thai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _romanMeta = const VerificationMeta('roman');
  @override
  late final GeneratedColumn<String> roman = GeneratedColumn<String>(
    'roman',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _glossMeta = const VerificationMeta('gloss');
  @override
  late final GeneratedColumn<String> gloss = GeneratedColumn<String>(
    'gloss',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toneJsonMeta = const VerificationMeta(
    'toneJson',
  );
  @override
  late final GeneratedColumn<String> toneJson = GeneratedColumn<String>(
    'tone_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTextMeta = const VerificationMeta(
    'sourceText',
  );
  @override
  late final GeneratedColumn<String> sourceText = GeneratedColumn<String>(
    'source_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _wordJsonMeta = const VerificationMeta(
    'wordJson',
  );
  @override
  late final GeneratedColumn<String> wordJson = GeneratedColumn<String>(
    'word_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<int> savedAt = GeneratedColumn<int>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    thai,
    roman,
    gloss,
    toneJson,
    sourceText,
    wordJson,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_words';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedWord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('thai')) {
      context.handle(
        _thaiMeta,
        thai.isAcceptableOrUnknown(data['thai']!, _thaiMeta),
      );
    } else if (isInserting) {
      context.missing(_thaiMeta);
    }
    if (data.containsKey('roman')) {
      context.handle(
        _romanMeta,
        roman.isAcceptableOrUnknown(data['roman']!, _romanMeta),
      );
    } else if (isInserting) {
      context.missing(_romanMeta);
    }
    if (data.containsKey('gloss')) {
      context.handle(
        _glossMeta,
        gloss.isAcceptableOrUnknown(data['gloss']!, _glossMeta),
      );
    } else if (isInserting) {
      context.missing(_glossMeta);
    }
    if (data.containsKey('tone_json')) {
      context.handle(
        _toneJsonMeta,
        toneJson.isAcceptableOrUnknown(data['tone_json']!, _toneJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_toneJsonMeta);
    }
    if (data.containsKey('source_text')) {
      context.handle(
        _sourceTextMeta,
        sourceText.isAcceptableOrUnknown(data['source_text']!, _sourceTextMeta),
      );
    }
    if (data.containsKey('word_json')) {
      context.handle(
        _wordJsonMeta,
        wordJson.isAcceptableOrUnknown(data['word_json']!, _wordJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_wordJsonMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedWord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedWord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      thai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thai'],
      )!,
      roman: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roman'],
      )!,
      gloss: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gloss'],
      )!,
      toneJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tone_json'],
      )!,
      sourceText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_text'],
      )!,
      wordJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_json'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $SavedWordsTable createAlias(String alias) {
    return $SavedWordsTable(attachedDatabase, alias);
  }
}

class SavedWord extends DataClass implements Insertable<SavedWord> {
  final int id;
  final String thai;
  final String roman;
  final String gloss;
  final String toneJson;
  final String sourceText;
  final String wordJson;
  final int savedAt;
  const SavedWord({
    required this.id,
    required this.thai,
    required this.roman,
    required this.gloss,
    required this.toneJson,
    required this.sourceText,
    required this.wordJson,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['thai'] = Variable<String>(thai);
    map['roman'] = Variable<String>(roman);
    map['gloss'] = Variable<String>(gloss);
    map['tone_json'] = Variable<String>(toneJson);
    map['source_text'] = Variable<String>(sourceText);
    map['word_json'] = Variable<String>(wordJson);
    map['saved_at'] = Variable<int>(savedAt);
    return map;
  }

  SavedWordsCompanion toCompanion(bool nullToAbsent) {
    return SavedWordsCompanion(
      id: Value(id),
      thai: Value(thai),
      roman: Value(roman),
      gloss: Value(gloss),
      toneJson: Value(toneJson),
      sourceText: Value(sourceText),
      wordJson: Value(wordJson),
      savedAt: Value(savedAt),
    );
  }

  factory SavedWord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedWord(
      id: serializer.fromJson<int>(json['id']),
      thai: serializer.fromJson<String>(json['thai']),
      roman: serializer.fromJson<String>(json['roman']),
      gloss: serializer.fromJson<String>(json['gloss']),
      toneJson: serializer.fromJson<String>(json['toneJson']),
      sourceText: serializer.fromJson<String>(json['sourceText']),
      wordJson: serializer.fromJson<String>(json['wordJson']),
      savedAt: serializer.fromJson<int>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'thai': serializer.toJson<String>(thai),
      'roman': serializer.toJson<String>(roman),
      'gloss': serializer.toJson<String>(gloss),
      'toneJson': serializer.toJson<String>(toneJson),
      'sourceText': serializer.toJson<String>(sourceText),
      'wordJson': serializer.toJson<String>(wordJson),
      'savedAt': serializer.toJson<int>(savedAt),
    };
  }

  SavedWord copyWith({
    int? id,
    String? thai,
    String? roman,
    String? gloss,
    String? toneJson,
    String? sourceText,
    String? wordJson,
    int? savedAt,
  }) => SavedWord(
    id: id ?? this.id,
    thai: thai ?? this.thai,
    roman: roman ?? this.roman,
    gloss: gloss ?? this.gloss,
    toneJson: toneJson ?? this.toneJson,
    sourceText: sourceText ?? this.sourceText,
    wordJson: wordJson ?? this.wordJson,
    savedAt: savedAt ?? this.savedAt,
  );
  SavedWord copyWithCompanion(SavedWordsCompanion data) {
    return SavedWord(
      id: data.id.present ? data.id.value : this.id,
      thai: data.thai.present ? data.thai.value : this.thai,
      roman: data.roman.present ? data.roman.value : this.roman,
      gloss: data.gloss.present ? data.gloss.value : this.gloss,
      toneJson: data.toneJson.present ? data.toneJson.value : this.toneJson,
      sourceText: data.sourceText.present
          ? data.sourceText.value
          : this.sourceText,
      wordJson: data.wordJson.present ? data.wordJson.value : this.wordJson,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedWord(')
          ..write('id: $id, ')
          ..write('thai: $thai, ')
          ..write('roman: $roman, ')
          ..write('gloss: $gloss, ')
          ..write('toneJson: $toneJson, ')
          ..write('sourceText: $sourceText, ')
          ..write('wordJson: $wordJson, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    thai,
    roman,
    gloss,
    toneJson,
    sourceText,
    wordJson,
    savedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedWord &&
          other.id == this.id &&
          other.thai == this.thai &&
          other.roman == this.roman &&
          other.gloss == this.gloss &&
          other.toneJson == this.toneJson &&
          other.sourceText == this.sourceText &&
          other.wordJson == this.wordJson &&
          other.savedAt == this.savedAt);
}

class SavedWordsCompanion extends UpdateCompanion<SavedWord> {
  final Value<int> id;
  final Value<String> thai;
  final Value<String> roman;
  final Value<String> gloss;
  final Value<String> toneJson;
  final Value<String> sourceText;
  final Value<String> wordJson;
  final Value<int> savedAt;
  const SavedWordsCompanion({
    this.id = const Value.absent(),
    this.thai = const Value.absent(),
    this.roman = const Value.absent(),
    this.gloss = const Value.absent(),
    this.toneJson = const Value.absent(),
    this.sourceText = const Value.absent(),
    this.wordJson = const Value.absent(),
    this.savedAt = const Value.absent(),
  });
  SavedWordsCompanion.insert({
    this.id = const Value.absent(),
    required String thai,
    required String roman,
    required String gloss,
    required String toneJson,
    this.sourceText = const Value.absent(),
    required String wordJson,
    required int savedAt,
  }) : thai = Value(thai),
       roman = Value(roman),
       gloss = Value(gloss),
       toneJson = Value(toneJson),
       wordJson = Value(wordJson),
       savedAt = Value(savedAt);
  static Insertable<SavedWord> custom({
    Expression<int>? id,
    Expression<String>? thai,
    Expression<String>? roman,
    Expression<String>? gloss,
    Expression<String>? toneJson,
    Expression<String>? sourceText,
    Expression<String>? wordJson,
    Expression<int>? savedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (thai != null) 'thai': thai,
      if (roman != null) 'roman': roman,
      if (gloss != null) 'gloss': gloss,
      if (toneJson != null) 'tone_json': toneJson,
      if (sourceText != null) 'source_text': sourceText,
      if (wordJson != null) 'word_json': wordJson,
      if (savedAt != null) 'saved_at': savedAt,
    });
  }

  SavedWordsCompanion copyWith({
    Value<int>? id,
    Value<String>? thai,
    Value<String>? roman,
    Value<String>? gloss,
    Value<String>? toneJson,
    Value<String>? sourceText,
    Value<String>? wordJson,
    Value<int>? savedAt,
  }) {
    return SavedWordsCompanion(
      id: id ?? this.id,
      thai: thai ?? this.thai,
      roman: roman ?? this.roman,
      gloss: gloss ?? this.gloss,
      toneJson: toneJson ?? this.toneJson,
      sourceText: sourceText ?? this.sourceText,
      wordJson: wordJson ?? this.wordJson,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (thai.present) {
      map['thai'] = Variable<String>(thai.value);
    }
    if (roman.present) {
      map['roman'] = Variable<String>(roman.value);
    }
    if (gloss.present) {
      map['gloss'] = Variable<String>(gloss.value);
    }
    if (toneJson.present) {
      map['tone_json'] = Variable<String>(toneJson.value);
    }
    if (sourceText.present) {
      map['source_text'] = Variable<String>(sourceText.value);
    }
    if (wordJson.present) {
      map['word_json'] = Variable<String>(wordJson.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<int>(savedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedWordsCompanion(')
          ..write('id: $id, ')
          ..write('thai: $thai, ')
          ..write('roman: $roman, ')
          ..write('gloss: $gloss, ')
          ..write('toneJson: $toneJson, ')
          ..write('sourceText: $sourceText, ')
          ..write('wordJson: $wordJson, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AnalysisDatabase extends GeneratedDatabase {
  _$AnalysisDatabase(QueryExecutor e) : super(e);
  $AnalysisDatabaseManager get managers => $AnalysisDatabaseManager(this);
  late final $CachedAnalysesTable cachedAnalyses = $CachedAnalysesTable(this);
  late final $SavedWordsTable savedWords = $SavedWordsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedAnalyses,
    savedWords,
  ];
}

typedef $$CachedAnalysesTableCreateCompanionBuilder =
    CachedAnalysesCompanion Function({
      required String hash,
      required String input,
      required String response,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$CachedAnalysesTableUpdateCompanionBuilder =
    CachedAnalysesCompanion Function({
      Value<String> hash,
      Value<String> input,
      Value<String> response,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$CachedAnalysesTableFilterComposer
    extends Composer<_$AnalysisDatabase, $CachedAnalysesTable> {
  $$CachedAnalysesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get input => $composableBuilder(
    column: $table.input,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedAnalysesTableOrderingComposer
    extends Composer<_$AnalysisDatabase, $CachedAnalysesTable> {
  $$CachedAnalysesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get input => $composableBuilder(
    column: $table.input,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedAnalysesTableAnnotationComposer
    extends Composer<_$AnalysisDatabase, $CachedAnalysesTable> {
  $$CachedAnalysesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<String> get input =>
      $composableBuilder(column: $table.input, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedAnalysesTableTableManager
    extends
        RootTableManager<
          _$AnalysisDatabase,
          $CachedAnalysesTable,
          CachedAnalyse,
          $$CachedAnalysesTableFilterComposer,
          $$CachedAnalysesTableOrderingComposer,
          $$CachedAnalysesTableAnnotationComposer,
          $$CachedAnalysesTableCreateCompanionBuilder,
          $$CachedAnalysesTableUpdateCompanionBuilder,
          (
            CachedAnalyse,
            BaseReferences<
              _$AnalysisDatabase,
              $CachedAnalysesTable,
              CachedAnalyse
            >,
          ),
          CachedAnalyse,
          PrefetchHooks Function()
        > {
  $$CachedAnalysesTableTableManager(
    _$AnalysisDatabase db,
    $CachedAnalysesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedAnalysesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedAnalysesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedAnalysesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> hash = const Value.absent(),
                Value<String> input = const Value.absent(),
                Value<String> response = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedAnalysesCompanion(
                hash: hash,
                input: input,
                response: response,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String hash,
                required String input,
                required String response,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedAnalysesCompanion.insert(
                hash: hash,
                input: input,
                response: response,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedAnalysesTableProcessedTableManager =
    ProcessedTableManager<
      _$AnalysisDatabase,
      $CachedAnalysesTable,
      CachedAnalyse,
      $$CachedAnalysesTableFilterComposer,
      $$CachedAnalysesTableOrderingComposer,
      $$CachedAnalysesTableAnnotationComposer,
      $$CachedAnalysesTableCreateCompanionBuilder,
      $$CachedAnalysesTableUpdateCompanionBuilder,
      (
        CachedAnalyse,
        BaseReferences<_$AnalysisDatabase, $CachedAnalysesTable, CachedAnalyse>,
      ),
      CachedAnalyse,
      PrefetchHooks Function()
    >;
typedef $$SavedWordsTableCreateCompanionBuilder =
    SavedWordsCompanion Function({
      Value<int> id,
      required String thai,
      required String roman,
      required String gloss,
      required String toneJson,
      Value<String> sourceText,
      required String wordJson,
      required int savedAt,
    });
typedef $$SavedWordsTableUpdateCompanionBuilder =
    SavedWordsCompanion Function({
      Value<int> id,
      Value<String> thai,
      Value<String> roman,
      Value<String> gloss,
      Value<String> toneJson,
      Value<String> sourceText,
      Value<String> wordJson,
      Value<int> savedAt,
    });

class $$SavedWordsTableFilterComposer
    extends Composer<_$AnalysisDatabase, $SavedWordsTable> {
  $$SavedWordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thai => $composableBuilder(
    column: $table.thai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roman => $composableBuilder(
    column: $table.roman,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gloss => $composableBuilder(
    column: $table.gloss,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toneJson => $composableBuilder(
    column: $table.toneJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wordJson => $composableBuilder(
    column: $table.wordJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedWordsTableOrderingComposer
    extends Composer<_$AnalysisDatabase, $SavedWordsTable> {
  $$SavedWordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thai => $composableBuilder(
    column: $table.thai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roman => $composableBuilder(
    column: $table.roman,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gloss => $composableBuilder(
    column: $table.gloss,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toneJson => $composableBuilder(
    column: $table.toneJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wordJson => $composableBuilder(
    column: $table.wordJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedWordsTableAnnotationComposer
    extends Composer<_$AnalysisDatabase, $SavedWordsTable> {
  $$SavedWordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get thai =>
      $composableBuilder(column: $table.thai, builder: (column) => column);

  GeneratedColumn<String> get roman =>
      $composableBuilder(column: $table.roman, builder: (column) => column);

  GeneratedColumn<String> get gloss =>
      $composableBuilder(column: $table.gloss, builder: (column) => column);

  GeneratedColumn<String> get toneJson =>
      $composableBuilder(column: $table.toneJson, builder: (column) => column);

  GeneratedColumn<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wordJson =>
      $composableBuilder(column: $table.wordJson, builder: (column) => column);

  GeneratedColumn<int> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedWordsTableTableManager
    extends
        RootTableManager<
          _$AnalysisDatabase,
          $SavedWordsTable,
          SavedWord,
          $$SavedWordsTableFilterComposer,
          $$SavedWordsTableOrderingComposer,
          $$SavedWordsTableAnnotationComposer,
          $$SavedWordsTableCreateCompanionBuilder,
          $$SavedWordsTableUpdateCompanionBuilder,
          (
            SavedWord,
            BaseReferences<_$AnalysisDatabase, $SavedWordsTable, SavedWord>,
          ),
          SavedWord,
          PrefetchHooks Function()
        > {
  $$SavedWordsTableTableManager(_$AnalysisDatabase db, $SavedWordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedWordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedWordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedWordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> thai = const Value.absent(),
                Value<String> roman = const Value.absent(),
                Value<String> gloss = const Value.absent(),
                Value<String> toneJson = const Value.absent(),
                Value<String> sourceText = const Value.absent(),
                Value<String> wordJson = const Value.absent(),
                Value<int> savedAt = const Value.absent(),
              }) => SavedWordsCompanion(
                id: id,
                thai: thai,
                roman: roman,
                gloss: gloss,
                toneJson: toneJson,
                sourceText: sourceText,
                wordJson: wordJson,
                savedAt: savedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String thai,
                required String roman,
                required String gloss,
                required String toneJson,
                Value<String> sourceText = const Value.absent(),
                required String wordJson,
                required int savedAt,
              }) => SavedWordsCompanion.insert(
                id: id,
                thai: thai,
                roman: roman,
                gloss: gloss,
                toneJson: toneJson,
                sourceText: sourceText,
                wordJson: wordJson,
                savedAt: savedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedWordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AnalysisDatabase,
      $SavedWordsTable,
      SavedWord,
      $$SavedWordsTableFilterComposer,
      $$SavedWordsTableOrderingComposer,
      $$SavedWordsTableAnnotationComposer,
      $$SavedWordsTableCreateCompanionBuilder,
      $$SavedWordsTableUpdateCompanionBuilder,
      (
        SavedWord,
        BaseReferences<_$AnalysisDatabase, $SavedWordsTable, SavedWord>,
      ),
      SavedWord,
      PrefetchHooks Function()
    >;

class $AnalysisDatabaseManager {
  final _$AnalysisDatabase _db;
  $AnalysisDatabaseManager(this._db);
  $$CachedAnalysesTableTableManager get cachedAnalyses =>
      $$CachedAnalysesTableTableManager(_db, _db.cachedAnalyses);
  $$SavedWordsTableTableManager get savedWords =>
      $$SavedWordsTableTableManager(_db, _db.savedWords);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$analysisDatabaseHash() => r'bb506dceaf24b600eff8955749da418591b04429';

/// See also [analysisDatabase].
@ProviderFor(analysisDatabase)
final analysisDatabaseProvider = FutureProvider<AnalysisDatabase>.internal(
  analysisDatabase,
  name: r'analysisDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$analysisDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnalysisDatabaseRef = FutureProviderRef<AnalysisDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
