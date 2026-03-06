import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import '../models/app_language.dart';

enum ModelStatus { idle, downloading, ready, error }

class TranslationProvider extends ChangeNotifier {
  // App-wide UI language (Screen 1 selector)
  String _uiLangCode = 'en';
  String get uiLangCode => _uiLangCode;

  // Translator screen From/To
  String _fromCode = 'en';
  String _toCode = 'ta';
  String get fromCode => _fromCode;
  String get toCode => _toCode;

  // Translation state
  String _result = '';
  String get result => _result;

  bool _isTranslating = false;
  bool get isTranslating => _isTranslating;

  ModelStatus _modelStatus = ModelStatus.idle;
  ModelStatus get modelStatus => _modelStatus;
  String _modelStatusMsg = '';
  String get modelStatusMsg => _modelStatusMsg;

  OnDeviceTranslator? _translator;
  final OnDeviceTranslatorModelManager _modelManager =
      OnDeviceTranslatorModelManager();

  // ── UI language ────────────────────────────────────────────────────────────
  void setUiLanguage(String code) {
    _uiLangCode = code;
    notifyListeners();
  }

  // ── Translator from/to ─────────────────────────────────────────────────────
  void setFrom(String code) {
    _fromCode = code;
    _result = '';
    notifyListeners();
  }

  void setTo(String code) {
    _toCode = code;
    _result = '';
    notifyListeners();
  }

  void swapLanguages() {
    final tmp = _fromCode;
    _fromCode = _toCode;
    _toCode = tmp;
    _result = '';
    notifyListeners();
  }

  void clearResult() {
    _result = '';
    notifyListeners();
  }

  // ── Core translate call ────────────────────────────────────────────────────
  Future<void> translate(String text) async {
    if (text.trim().isEmpty) return;

    _isTranslating = true;
    _result = '';
    _modelStatus = ModelStatus.idle;
    _modelStatusMsg = '';
    notifyListeners();

    final from = langByCode(_fromCode).mlKit;
    final to = langByCode(_toCode).mlKit;

    try {
      // 1. Ensure models are downloaded
      await _ensureModel(from);
      await _ensureModel(to);

      // 2. Close any previous translator instance
      await _translator?.close();

      // 3. Create fresh translator
      _translator = OnDeviceTranslator(
        sourceLanguage: from,
        targetLanguage: to,
      );

      // 4. Translate
      _modelStatus = ModelStatus.ready;
      _modelStatusMsg = '';
      _result = await _translator!.translateText(text);
    } catch (e) {
      _modelStatus = ModelStatus.error;
      _modelStatusMsg = 'Error: $e';
      _result = '';
    } finally {
      _isTranslating = false;
      notifyListeners();
    }
  }

  Future<void> _ensureModel(TranslateLanguage lang) async {
    final code = lang.bcpCode;
    final isDownloaded = await _modelManager.isModelDownloaded(code);
    if (!isDownloaded) {
      _modelStatus = ModelStatus.downloading;
      _modelStatusMsg =
          'Downloading ${lang.name} model (one-time, ~10 MB)…';
      notifyListeners();
      final ok = await _modelManager.downloadModel(code);
      if (!ok) throw Exception('Failed to download model for $code');
    }
  }

  @override
  void dispose() {
    _translator?.close();
    super.dispose();
  }
}

// Extension so we can get a display name from the enum
extension on TranslateLanguage {
  String get name {
    return toString().split('.').last;
  }
}