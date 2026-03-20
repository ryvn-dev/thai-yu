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

abstract class _$AnalysisDatabase extends GeneratedDatabase {
  _$AnalysisDatabase(QueryExecutor e) : super(e);
  $AnalysisDatabaseManager get managers => $AnalysisDatabaseManager(this);
  late final $CachedAnalysesTable cachedAnalyses = $CachedAnalysesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedAnalyses];
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

class $AnalysisDatabaseManager {
  final _$AnalysisDatabase _db;
  $AnalysisDatabaseManager(this._db);
  $$CachedAnalysesTableTableManager get cachedAnalyses =>
      $$CachedAnalysesTableTableManager(_db, _db.cachedAnalyses);
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
