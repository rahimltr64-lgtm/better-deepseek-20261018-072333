import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// خدمة النطق الصوتي باللغة العربية.
class TtsService {
  TtsService._();

  static final TtsService instance = TtsService._();

  final FlutterTts _tts = FlutterTts();

  bool _ready = false;
  double _rate = 0.45;

  Future<void> _ensureInit() async {
    if (_ready) return;
    try {
      await _tts.setLanguage('ar-SA');
      await _tts.setSpeechRate(_rate);
      await _tts.setPitch(1.05);
      await _tts.setVolume(1.0);
    } catch (error) {
      debugPrint('TTS init error: $error');
    }
    _ready = true;
  }

  /// تغيير سرعة النطق (0.25 بطيء جداً – 0.65 سريع).
  Future<void> setRate(double rate) async {
    _rate = rate;
    await _ensureInit();
    try {
      await _tts.setSpeechRate(rate);
    } catch (error) {
      debugPrint('TTS setRate error: $error');
    }
  }

  /// نطق نص عربي.
  Future<void> speak(String text) async {
    if (text.trim().isEmpty) return;
    await _ensureInit();
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (error) {
      debugPrint('TTS speak error: $error');
    }
  }

  Future<void> stop() async {
    try {
      await _tts.stop();
    } catch (error) {
      debugPrint('TTS stop error: $error');
    }
  }
}
