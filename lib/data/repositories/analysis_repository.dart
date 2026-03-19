import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasources/analysis_cache.dart';
import '../datasources/backend_service.dart';
import '../models/analysis_result.dart';
import '../models/word_block.dart';

part 'analysis_repository.g.dart';

class AnalysisRepository {
  AnalysisRepository({
    required this.backendService,
    required this.database,
  });

  final BackendService backendService;
  final AnalysisDatabase database;

  Future<AnalysisResult> analyze(String thaiText) async {
    final inputHash = AnalysisDatabase.computeHash(thaiText);

    // Check cache first
    final cached = await database.getCachedAnalysis(inputHash);
    if (cached != null) {
      final words = _parseCache(cached.response);
      return AnalysisResult(
        input: thaiText,
        words: words,
        analyzedAt: DateTime.fromMillisecondsSinceEpoch(cached.createdAt),
      );
    }

    // Cache miss — call backend
    final words = await backendService.analyzeText(thaiText);

    // Store in cache
    final responseJson = jsonEncode(words.map((w) => w.toJson()).toList());
    await database.cacheAnalysis(
      inputHash: inputHash,
      input: thaiText,
      response: responseJson,
    );

    return AnalysisResult(
      input: thaiText,
      words: words,
      analyzedAt: DateTime.now(),
    );
  }

  List<WordBlock> _parseCache(String response) {
    final decoded = jsonDecode(response) as List<dynamic>;
    return decoded
        .map((e) => WordBlock.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
AnalysisRepository analysisRepository(AnalysisRepositoryRef ref) {
  final backend = ref.watch(backendServiceProvider);
  final database = ref.watch(analysisDatabaseProvider);
  return AnalysisRepository(backendService: backend, database: database);
}
