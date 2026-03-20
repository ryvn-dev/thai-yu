import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/word_block.dart';

part 'backend_service.g.dart';

class BackendService {
  BackendService({this.baseUrl = 'http://127.0.0.1:8000'});

  final String baseUrl;

  Future<List<WordBlock>> analyzeText(String thaiText) async {
    final response = await http
        .post(
          Uri.parse('$baseUrl/analyze'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'text': thaiText}),
        )
        .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw BackendException(
        statusCode: response.statusCode,
        message: 'Backend error: ${response.body}',
      );
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(response.body);
    } on FormatException catch (e) {
      throw BackendException(
        statusCode: response.statusCode,
        message: '回應格式錯誤: $e',
      );
    }

    if (decoded is! Map<String, dynamic>) {
      throw const BackendException(
        statusCode: 0,
        message: '回應格式錯誤: 預期 JSON 物件',
      );
    }

    final sentencesJson = decoded['sentences'];
    if (sentencesJson is! List<dynamic>) {
      throw const BackendException(
        statusCode: 0,
        message: '回應格式錯誤: 缺少 sentences 欄位',
      );
    }

    final allWords = <WordBlock>[];
    for (var sentIdx = 0; sentIdx < sentencesJson.length; sentIdx++) {
      final sentence = sentencesJson[sentIdx];
      if (sentence is! Map<String, dynamic>) continue;
      final wordsJson = sentence['words'];
      if (wordsJson is! List<dynamic>) continue;
      for (final w in wordsJson) {
        if (w is! Map<String, dynamic>) continue;
        allWords.add(_parseWord(w, sentIdx));
      }
    }
    return allWords;
  }

  WordBlock _parseWord(Map<String, dynamic> w, int sentenceIndex) {
      final word = w;
      final syllables = word['syllables'] as List<dynamic>;
      final firstSyl = syllables.isNotEmpty
          ? syllables[0] as Map<String, dynamic>
          : <String, dynamic>{};

      // Map syllable_parts to Flutter SyllableBreakdown format
      final backendSylParts =
          word['syllable_parts'] as List<dynamic>? ?? [];
      final syllableBreakdowns = backendSylParts.map((sp) {
        final sylPart = sp as Map<String, dynamic>;
        final parts = (sylPart['parts'] as List<dynamic>).map((p) {
          final part = p as Map<String, dynamic>;
          return <String, dynamic>{
            'label': part['label'],
            'char': part['char'],
            'sound': part['sound'],
            'zhApprox': part['zh_approx'],
            'isSilent': part['is_silent'] ?? false,
          };
        }).toList();
        return <String, dynamic>{
          'thai': sylPart['thai'],
          'originalThai': sylPart['original_thai'] ?? sylPart['thai'],
          'rtgs': sylPart['rtgs'] ?? '',
          'tone': sylPart['tone'] ?? 'mid',
          'toneReason': sylPart['tone_reason'] ?? '',
          'gloss': sylPart['gloss'] ?? '…',
          'parts': parts,
          'isHoNam': sylPart['is_ho_nam'] ?? false,
          'hasImplicitVowel': sylPart['has_implicit_vowel'] ?? false,
        };
      }).toList();

      // Use tone_reason from first syllable_parts (backend-computed)
      final firstSylPart = syllableBreakdowns.isNotEmpty
          ? syllableBreakdowns[0]
          : <String, dynamic>{};

      final wordJson = <String, dynamic>{
        'thai': word['thai'] as String,
        'roman': word['rtgs'] as String? ?? '',
        'gloss': word['gloss'] as String? ?? '…',
        'tones': word['tones'] as List<dynamic>? ?? ['mid'],
        'parts': <Map<String, dynamic>>[],
        'toneReason': firstSylPart['toneReason'] as String? ?? '',
        'initialConsonant': firstSyl['initial_consonant'],
        'consonantClass': firstSyl['consonant_class'],
        'toneMark': firstSyl['tone_mark'],
        'syllableType': firstSyl['syllable_type'],
        'sentenceIndex': sentenceIndex,
        'originalSyllables': word['original_syllables'] as List<dynamic>? ?? [],
        'syllableBreakdowns': syllableBreakdowns,
      };

      return WordBlock.fromJson(wordJson);
  }

  Future<bool> isHealthy() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/health'))
          .timeout(const Duration(seconds: 2));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

class BackendException implements Exception {
  const BackendException({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  String toString() => 'BackendException($statusCode): $message';
}

@Riverpod(keepAlive: true)
BackendService backendService(BackendServiceRef ref) {
  return BackendService();
}
