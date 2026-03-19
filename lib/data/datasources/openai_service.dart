import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/word_block.dart';
import 'api_key_storage.dart';

part 'openai_service.g.dart';

class OpenAiService {
  OpenAiService({required this.apiKey});

  final String apiKey;

  static const _model = 'gpt-4o-mini';
  static const _apiUrl = 'https://api.openai.com/v1/chat/completions';

  static const _systemPrompt = '''
You are a Thai language analysis tool designed for Chinese (Mandarin/Cantonese) speakers.

Given Thai text, segment it into words and analyze each word. Return a JSON array where each element is a word object with this exact structure:

{
  "thai": "ข้าว",
  "roman": "khâo",
  "gloss": "飯",
  "sentenceIndex": 0,
  "initialConsonant": "ข",
  "consonantClass": "high",
  "toneMark": "mai_tho",
  "syllableType": "live",
  "parts": [
    {
      "label": "聲母",
      "char": "ข",
      "sound": "/kh/",
      "zhApprox": "送氣音，像「可」的 kh-",
      "isSilent": false
    },
    {
      "label": "韻母",
      "char": "า",
      "sound": "/aː/",
      "zhApprox": "長元音，像「啊——」",
      "isSilent": false
    },
    {
      "label": "韻尾",
      "char": "ว",
      "sound": "/-o/",
      "zhApprox": "收尾滑音",
      "isSilent": false
    }
  ],
  "toneReason": "้ 這個符號寫在這裡 → 音往下降"
}

Rules:
- "sentenceIndex": integer starting from 0, increment when a new sentence/clause begins. Split at sentence-ending particles (ครับ/ค่ะ), punctuation, or natural clause boundaries.
- DO NOT include a "tone" field — the app computes tone from the three variables below
- "initialConsonant": the first consonant of the syllable (Thai character)
- "consonantClass": must be one of "low", "mid", "high" — the class of the initial consonant
- "toneMark": must be one of null (no mark), "mai_ek" (่), "mai_tho" (้), "mai_tri" (๊), "mai_chattawa" (๋)
- "syllableType": must be one of "live" (open or sonorant coda), "dead_long" (stop coda + long vowel), "dead_short" (stop coda + short vowel)
- "parts" label must be one of: "聲母" (onset), "韻母" (vowel), "韻尾" (coda)
- "zhApprox" MUST use Chinese approximate sounds, NOT English phonetics. Example: "像「可」的 kh-" not "like English k with aspiration"
- "toneReason" MUST only describe visually observable symbols or letter shapes. NEVER use terms like "高類輔音", "中類輔音", "低類輔音" or any Thai phonological classification terms.
- For silent codas (closed syllables ending in -บ/-ด/-ก), set "isSilent": true and describe as "停在嘴型上，不送氣"
- "roman" uses RTGS romanization with tone diacritics
- "gloss" should be the most contextually appropriate Chinese meaning
- For particles (ครับ/ค่ะ/นะ/เลย etc.), add "(語氣詞)" in the gloss
- Return ONLY the JSON array, no other text
''';

  Future<String> analyzeTextRaw(String thaiText) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': _model,
        'messages': [
          {'role': 'system', 'content': _systemPrompt},
          {'role': 'user', 'content': thaiText},
        ],
        'temperature': 0.1,
        'response_format': {'type': 'json_object'},
      }),
    );

    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final error = body['error'] as Map<String, dynamic>?;
      throw OpenAiException(
        statusCode: response.statusCode,
        message: error?['message'] as String? ?? 'Unknown error',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = body['choices'] as List<dynamic>;
    final message = choices.first['message'] as Map<String, dynamic>;
    return message['content'] as String;
  }

  Future<List<WordBlock>> analyzeText(String thaiText) async {
    final raw = await analyzeTextRaw(thaiText);
    return parseResponse(raw);
  }

  static List<WordBlock> parseResponse(String raw) {
    final decoded = jsonDecode(raw);

    // Handle both direct array and {"words": [...]} wrapper
    final List<dynamic> jsonList;
    if (decoded is List) {
      jsonList = decoded;
    } else if (decoded is Map<String, dynamic>) {
      jsonList =
          (decoded['words'] ?? decoded['data'] ?? decoded.values.first)
              as List<dynamic>;
    } else {
      throw const FormatException('Unexpected API response format');
    }

    return jsonList
        .map((e) => WordBlock.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Validate that an API key works by sending a minimal request
  static Future<bool> validateApiKey(String key) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $key',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {'role': 'user', 'content': 'test'},
          ],
          'max_tokens': 1,
        }),
      );
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}

class OpenAiException implements Exception {
  const OpenAiException({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  String toString() => 'OpenAiException($statusCode): $message';
}

@riverpod
OpenAiService? openAiService(OpenAiServiceRef ref) {
  final apiKeyAsync = ref.watch(apiKeyNotifierProvider);
  final apiKey = apiKeyAsync.valueOrNull;
  if (apiKey == null || apiKey.isEmpty) return null;
  return OpenAiService(apiKey: apiKey);
}
