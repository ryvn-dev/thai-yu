import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/datasources/backend_service.dart';
import '../../../data/models/analysis_result.dart';
import '../../../data/models/thai_font.dart';
import '../../../data/models/tone_type.dart';
import '../../../data/models/word_block.dart';
import '../../../data/repositories/analysis_repository.dart';

part 'analysis_controller.g.dart';

const _kLearningModeKey = 'learning_mode';
const _kThaiFontKey = 'thai_font';

/// Demo data used when no API key is set or for initial display
final demoWords = [
  const WordBlock(
    thai: 'ฉัน',
    roman: 'chǎn',
    gloss: '我',
    tones: [ToneType.rise],

    parts: [
      PhonemeBreakdown(
        label: '聲母',
        char_: 'ฉ',
        sound: '/ch/',
        zhApprox: '像「車」的 ch-',
      ),
      PhonemeBreakdown(
        label: '韻母',
        char_: 'ั',
        sound: '/a/',
        zhApprox: '短元音，像「啊」',
      ),
      PhonemeBreakdown(
        label: '韻尾',
        char_: 'น',
        sound: '/-n/',
        zhApprox: '收 -n 尾',
      ),
    ],
    toneReason: 'ฉ 這個聲母自帶升調屬性 → 音往上走',
  ),
  const WordBlock(
    thai: 'ชอบ',
    roman: 'chôp',
    gloss: '喜歡',
    tones: [ToneType.fall],
    parts: [
      PhonemeBreakdown(
        label: '聲母',
        char_: 'ช',
        sound: '/ch/',
        zhApprox: '氣流輕柔版的 ch-',
      ),
      PhonemeBreakdown(
        label: '韻母',
        char_: 'อ',
        sound: '/ɔː/',
        zhApprox: '長元音，嘴圓，像「哦——」',
      ),
      PhonemeBreakdown(
        label: '韻尾',
        char_: 'บ',
        sound: '/-p/',
        zhApprox: '停在嘴唇，幾乎不送氣',
        isSilent: true,
      ),
    ],
    toneReason: 'ช 低類聲母 + 長元音閉音節 → 音從高處急降',
  ),
  const WordBlock(
    thai: 'กิน',
    roman: 'kin',
    gloss: '吃',
    tones: [ToneType.mid],
    parts: [
      PhonemeBreakdown(
        label: '聲母',
        char_: 'ก',
        sound: '/k/',
        zhApprox: '不送氣，像「格」的 k',
      ),
      PhonemeBreakdown(
        label: '韻母',
        char_: 'ิ',
        sound: '/i/',
        zhApprox: '短元音，像「衣」',
      ),
      PhonemeBreakdown(
        label: '韻尾',
        char_: 'น',
        sound: '/-n/',
        zhApprox: '收 -n 尾',
      ),
    ],
    toneReason: 'ก 這個聲母自帶中調屬性 → 平穩',
  ),
  const WordBlock(
    thai: 'ข้าว',
    roman: 'khâo',
    gloss: '飯',
    tones: [ToneType.fall],
    parts: [
      PhonemeBreakdown(
        label: '聲母',
        char_: 'ข',
        sound: '/kh/',
        zhApprox: '送氣音，像「可」的 kh-',
      ),
      PhonemeBreakdown(
        label: '韻母',
        char_: 'า',
        sound: '/aː/',
        zhApprox: '長元音，像「啊——」',
      ),
      PhonemeBreakdown(
        label: '韻尾',
        char_: 'ว',
        sound: '/-o/',
        zhApprox: '收尾滑音',
      ),
    ],
    toneReason: '้ 這個符號寫在這裡 → 音往下降',
  ),
  const WordBlock(
    thai: 'ผัด',
    roman: 'phàt',
    gloss: '炒',
    tones: [ToneType.low],
    parts: [
      PhonemeBreakdown(
        label: '聲母',
        char_: 'ผ',
        sound: '/ph/',
        zhApprox: '送氣音，像「坡」的 ph-',
      ),
      PhonemeBreakdown(
        label: '韻母',
        char_: 'ั',
        sound: '/a/',
        zhApprox: '短元音，像「啊」',
      ),
      PhonemeBreakdown(
        label: '韻尾',
        char_: 'ด',
        sound: '/-t/',
        zhApprox: '停在舌尖，幾乎不送氣',
        isSilent: true,
      ),
    ],
    toneReason: 'ผ + 閉音節 → 音沉低',
  ),
];

@riverpod
class AnalysisController extends _$AnalysisController {
  @override
  AnalysisResult? build() => null;

  Future<void> analyze(String thaiText) async {
    final text = thaiText.trim();
    if (text.isEmpty) return;

    try {
      final repo = await ref.read(analysisRepositoryProvider.future);
      final result = await repo.analyze(text);
      state = result;
    } on BackendException catch (e) {
      throw Exception(e.message);
    }
  }
}

@riverpod
class LearningModeNotifier extends _$LearningModeNotifier {
  @override
  bool build() {
    _loadFromPrefs();
    return false;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_kLearningModeKey) ?? false;
    state = value;
  }

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kLearningModeKey, state);
  }
}

@riverpod
class ThaiFontNotifier extends _$ThaiFontNotifier {
  @override
  ThaiFontStyle build() {
    _loadFromPrefs();
    return ThaiFontStyle.standard;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final idx = prefs.getInt(_kThaiFontKey) ?? 0;
    if (idx < ThaiFontStyle.values.length) {
      state = ThaiFontStyle.values[idx];
    }
  }

  Future<void> setFont(ThaiFontStyle font) async {
    state = font;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThaiFontKey, font.index);
  }
}
