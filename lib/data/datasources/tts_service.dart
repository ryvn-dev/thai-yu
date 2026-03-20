import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tts_service.g.dart';

/// TTS speech rate presets.
enum TtsSpeed {
  normal(0.45, '正常'),
  slow(0.3, '慢速'),
  verySlow(0.15, '極慢');

  const TtsSpeed(this.rate, this.label);
  final double rate;
  final String label;
}

class TtsService {
  TtsService() {
    _ready = _init();
  }

  final FlutterTts _tts = FlutterTts();
  late final Future<void> _ready;
  TtsSpeed _speed = TtsSpeed.normal;

  TtsSpeed get speed => _speed;

  Future<void> _init() async {
    await _tts.setLanguage('th-TH');
    await _tts.setSpeechRate(_speed.rate);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    // iOS: ensure shared audio session allows playback
    await _tts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker],
    );
  }

  Future<void> setSpeed(TtsSpeed speed) async {
    _speed = speed;
    await _ready;
    await _tts.setSpeechRate(speed.rate);
  }

  Future<void> speak(String text) async {
    await _ready;
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  void dispose() {
    _tts.stop();
  }
}

const _kTtsSpeedKey = 'tts_speed';

@Riverpod(keepAlive: true)
TtsService ttsService(TtsServiceRef ref) {
  final service = TtsService();
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
class TtsSpeedNotifier extends _$TtsSpeedNotifier {
  @override
  TtsSpeed build() {
    _loadFromPrefs();
    return TtsSpeed.normal;
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final idx = prefs.getInt(_kTtsSpeedKey) ?? 0;
    if (idx < TtsSpeed.values.length) {
      final speed = TtsSpeed.values[idx];
      state = speed;
      await ref.read(ttsServiceProvider).setSpeed(speed);
    }
  }

  Future<void> cycle() async {
    final next = TtsSpeed.values[(state.index + 1) % TtsSpeed.values.length];
    state = next;
    await ref.read(ttsServiceProvider).setSpeed(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kTtsSpeedKey, next.index);
  }
}
