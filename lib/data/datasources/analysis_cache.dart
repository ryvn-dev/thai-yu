import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
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

class SavedWords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get thai => text()();
  TextColumn get roman => text()();
  TextColumn get gloss => text()();
  TextColumn get toneJson => text()();
  TextColumn get sourceText => text().withDefault(const Constant(''))();
  TextColumn get wordJson => text()();
  IntColumn get savedAt => integer()();
}

@DriftDatabase(tables: [CachedAnalyses, SavedWords])
class AnalysisDatabase extends _$AnalysisDatabase {
  AnalysisDatabase(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.createTable(savedWords);
          }
        },
      );

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

  /// Get all analyses ordered by creation time (newest first)
  Future<List<CachedAnalyse>> getAllAnalyses() {
    return (select(cachedAnalyses)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Search analyses by input text
  Future<List<CachedAnalyse>> searchAnalyses(String query) {
    // Escape SQL LIKE wildcards in user input
    final escaped = query
        .replaceAll('\\', '\\\\')
        .replaceAll('%', '\\%')
        .replaceAll('_', '\\_');
    return (select(cachedAnalyses)
          ..where((t) => t.input.like('%$escaped%'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Delete a single analysis by hash
  Future<void> deleteAnalysis(String inputHash) {
    return (delete(cachedAnalyses)
          ..where((t) => t.hash.equals(inputHash)))
        .go();
  }

  // ── Saved Words ──

  /// Save a word to vocabulary notebook
  Future<int> saveWord({
    required String thai,
    required String roman,
    required String gloss,
    required String toneJson,
    required String sourceText,
    required String wordJson,
  }) {
    return into(savedWords).insert(
      SavedWordsCompanion.insert(
        thai: thai,
        roman: roman,
        gloss: gloss,
        toneJson: toneJson,
        sourceText: Value(sourceText),
        wordJson: wordJson,
        savedAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  /// Check if a word is already saved
  Future<bool> isWordSaved(String thai) async {
    final result = await (select(savedWords)
          ..where((t) => t.thai.equals(thai))
          ..limit(1))
        .get();
    return result.isNotEmpty;
  }

  /// Get all saved words (newest first)
  Future<List<SavedWord>> getAllSavedWords() {
    return (select(savedWords)
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .get();
  }

  /// Delete a saved word by id
  Future<void> deleteSavedWord(int id) {
    return (delete(savedWords)..where((t) => t.id.equals(id))).go();
  }

  /// Delete a saved word by Thai text
  Future<void> deleteSavedWordByThai(String thai) {
    return (delete(savedWords)..where((t) => t.thai.equals(thai))).go();
  }

  /// Compute SHA-256 hash of input text for cache key
  static String computeHash(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }
}

@Riverpod(keepAlive: true)
Future<AnalysisDatabase> analysisDatabase(AnalysisDatabaseRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final file = File('${dir.path}/thai_yu_cache.db');
  final db = AnalysisDatabase(NativeDatabase(file));
  ref.onDispose(db.close);
  return db;
}
