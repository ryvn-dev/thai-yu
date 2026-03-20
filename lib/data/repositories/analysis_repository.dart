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
      final (words, sentenceGlosses) = _parseCache(cached.response);
      return AnalysisResult(
        input: thaiText,
        words: words,
        analyzedAt: DateTime.fromMillisecondsSinceEpoch(cached.createdAt),
        sentenceGlosses: sentenceGlosses,
      );
    }

    // Cache miss — call backend
    final (words, sentenceGlosses) = await backendService.analyzeText(thaiText);

    // Store in cache (words + sentence glosses)
    final cacheData = {
      'words': words.map((w) => w.toJson()).toList(),
      'sentenceGlosses': sentenceGlosses.map(
        (k, v) => MapEntry(k.toString(), v),
      ),
    };
    await database.cacheAnalysis(
      inputHash: inputHash,
      input: thaiText,
      response: jsonEncode(cacheData),
    );

    return AnalysisResult(
      input: thaiText,
      words: words,
      analyzedAt: DateTime.now(),
      sentenceGlosses: sentenceGlosses,
    );
  }

  (List<WordBlock>, Map<int, String>) _parseCache(String response) {
    final decoded = jsonDecode(response);

    // New format: { words: [...], sentenceGlosses: {...} }
    if (decoded is Map<String, dynamic> && decoded.containsKey('words')) {
      final words = (decoded['words'] as List<dynamic>)
          .map((e) => WordBlock.fromJson(e as Map<String, dynamic>))
          .toList();
      final glossesRaw =
          decoded['sentenceGlosses'] as Map<String, dynamic>? ?? {};
      final glosses = glossesRaw.map(
        (k, v) => MapEntry(int.parse(k), v as String),
      );
      return (words, glosses);
    }

    // Legacy format: plain list of words
    final words = (decoded as List<dynamic>)
        .map((e) => WordBlock.fromJson(e as Map<String, dynamic>))
        .toList();
    return (words, <int, String>{});
  }
}

@riverpod
Future<AnalysisRepository> analysisRepository(
  AnalysisRepositoryRef ref,
) async {
  final backend = ref.watch(backendServiceProvider);
  final database = await ref.watch(analysisDatabaseProvider.future);
  return AnalysisRepository(backendService: backend, database: database);
}
