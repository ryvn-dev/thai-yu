import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tts_service.g.dart';

class TtsService {
  TtsService() {
    _ready = _init();
  }

  final FlutterTts _tts = FlutterTts();
  late final Future<void> _ready;

  Future<void> _init() async {
    await _tts.setLanguage('th-TH');
    await _tts.setSpeechRate(0.4);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    // iOS: ensure shared audio session allows playback
    await _tts.setIosAudioCategory(
      IosTextToSpeechAudioCategory.playback,
      [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker],
    );
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

@Riverpod(keepAlive: true)
TtsService ttsService(TtsServiceRef ref) {
  final service = TtsService();
  ref.onDispose(service.dispose);
  return service;
}
