import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _tts = FlutterTts();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if (_isInitialized) return;

    await _tts.awaitSpeakCompletion(true);

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    // Replace the current queued speech instead of adding to it.
    await _tts.setQueueMode(0);

    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    await initialize();

    if (text.trim().isEmpty) {
      return;
    }

    await _tts.speak(text);
  }

  Future<void> pause() async {
    await _tts.pause();
  }

  Future<void> stop() async {
    await _tts.stop();
  }

  Future<void> setSpeechRate(double rate) async {
    await _tts.setSpeechRate(rate);
  }

  Future<void> setVolume(double volume) async {
    await _tts.setVolume(volume);
  }

  Future<void> setPitch(double pitch) async {
    await _tts.setPitch(pitch);
  }

  Future<void> setLanguage(String language) async {
    await _tts.setLanguage(language);
  }

  Future<List<dynamic>> getLanguages() async {
    return await _tts.getLanguages;
  }

  Future<List<Map>> getVoices() async {
    final voices = await _tts.getVoices;

    return List<Map>.from(voices);
  }

  Future<void> setVoice({
    required String name,
    required String locale,
  }) async {
    await _tts.setVoice({
      'name': name,
      'locale': locale,
    });
  }

  Future<bool> isLanguageAvailable(String language) async {
    final result = await _tts.isLanguageAvailable(language);
    return result == true;
  }

  void setStartHandler(void Function() handler) {
    _tts.setStartHandler(handler);
  }

  void setCompletionHandler(void Function() handler) {
    _tts.setCompletionHandler(handler);
  }

  void setPauseHandler(void Function() handler) {
    _tts.setPauseHandler(handler);
  }

  void setContinueHandler(void Function() handler) {
    _tts.setContinueHandler(handler);
  }

  void setCancelHandler(void Function() handler) {
    _tts.setCancelHandler(handler);
  }

  void setErrorHandler(ErrorHandler handler) {
  _tts.setErrorHandler(handler);
  }

  void setProgressHandler(
    void Function(
      String text,
      int startOffset,
      int endOffset,
      String word,
    ) handler,
  ) {
    _tts.setProgressHandler(handler);
  }

  Future<void> dispose() async {
    await _tts.stop();
  }
}