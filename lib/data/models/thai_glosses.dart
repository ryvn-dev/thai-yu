import 'dart:convert';

import 'package:flutter/services.dart';

/// 泰語高頻詞中文釋義表 v1
/// ~500 詞，從 assets/data/thai_zh_glosses.json 載入。
class ThaiGlosses {
  ThaiGlosses._();

  static Map<String, String>? _cache;

  /// Load glosses from asset bundle. Call once at app startup.
  static Future<void> init() async {
    if (_cache != null) return;
    final jsonStr =
        await rootBundle.loadString('assets/data/thai_zh_glosses.json');
    final Map<String, dynamic> raw = jsonDecode(jsonStr) as Map<String, dynamic>;
    _cache = raw.map((k, v) => MapEntry(k, v as String));
  }

  /// Exact match only. Compound split is done by backend.
  /// Used for sub-word gloss display in bottom sheet.
  static String lookup(String thai) => _cache?[thai] ?? '…';
}
