import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/thai_glosses.dart' show ThaiGlosses;
import '../models/word_block.dart';

part 'backend_service.g.dart';

class BackendService {
  BackendService({this.baseUrl = 'http://127.0.0.1:8000'});

  final String baseUrl;

  Future<List<WordBlock>> analyzeText(String thaiText) async {
    final response = await http.post(
      Uri.parse('$baseUrl/analyze'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': thaiText}),
    );

    if (response.statusCode != 200) {
      throw BackendException(
        statusCode: response.statusCode,
        message: 'Backend error: ${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final sentencesJson = body['sentences'] as List<dynamic>;

    final allWords = <WordBlock>[];
    for (var sentIdx = 0; sentIdx < sentencesJson.length; sentIdx++) {
      final sentence = sentencesJson[sentIdx] as Map<String, dynamic>;
      final wordsJson = sentence['words'] as List<dynamic>;
      for (final w in wordsJson) {
        allWords.add(_parseWord(w as Map<String, dynamic>, sentIdx));
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
          'parts': parts,
          'isHoNam': sylPart['is_ho_nam'] ?? false,
          'hasImplicitVowel': sylPart['has_implicit_vowel'] ?? false,
        };
      }).toList();

      final wordJson = <String, dynamic>{
        'thai': word['thai'] as String,
        'roman': word['rtgs'] as String? ?? '',
        'gloss': ThaiGlosses.lookup(word['thai'] as String),
        'tones': word['tones'] as List<dynamic>? ?? ['mid'],
        'parts': <Map<String, dynamic>>[],
        'toneReason': _buildToneReason(firstSyl),
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

  static String _buildToneReason(Map<String, dynamic> syl) {
    final cls = syl['consonant_class'] as String? ?? '';
    final mark = syl['tone_mark'] as String?;
    final sylType = syl['syllable_type'] as String? ?? '';
    final tone = syl['tone'] as String? ?? '';

    final clsLabel = switch (cls) {
      'high' => '高類',
      'mid' => '中類',
      'low' => '低類',
      _ => cls,
    };

    final markLabel = switch (mark) {
      'mai_ek' => ' + ่',
      'mai_tho' => ' + ้',
      'mai_tri' => ' + ๊',
      'mai_jattawa' => ' + ๋',
      _ => '',
    };

    final sylLabel = switch (sylType) {
      'live' => '活音節',
      'dead_long' => '長元音閉音節',
      'dead_short' => '短元音閉音節',
      _ => sylType,
    };

    return '$clsLabel聲母$markLabel + $sylLabel → $tone';
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
