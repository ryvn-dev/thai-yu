import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'analysis_cache.g.dart';

class CachedAnalyses extends Table {
  TextColumn get hash => text()();
  TextColumn get input => text()();
  TextColumn get response => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {hash};
}

@DriftDatabase(tables: [CachedAnalyses])
class AnalysisDatabase extends _$AnalysisDatabase {
  AnalysisDatabase() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  Future<CachedAnalyse?> getCachedAnalysis(String inputHash) {
    return (select(cachedAnalyses)
          ..where((t) => t.hash.equals(inputHash)))
        .getSingleOrNull();
  }

  Future<void> cacheAnalysis({
    required String inputHash,
    required String input,
    required String response,
  }) {
    return into(cachedAnalyses).insertOnConflictUpdate(
      CachedAnalysesCompanion.insert(
        hash: inputHash,
        input: input,
        response: response,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  /// Get recent analyses ordered by creation time (newest first)
  Future<List<CachedAnalyse>> getRecentAnalyses({int limit = 10}) {
    return (select(cachedAnalyses)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  /// Compute SHA-256 hash of input text for cache key
  static String computeHash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}

@Riverpod(keepAlive: true)
AnalysisDatabase analysisDatabase(AnalysisDatabaseRef ref) {
  final db = AnalysisDatabase();
  ref.onDispose(db.close);
  return db;
}
