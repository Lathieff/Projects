import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLanguage(String code) {
    _locale = Locale(code);
    notifyListeners();
  }

  // ✅ SAFE TRANSLATION METHOD (NO NULL CRASH)
  String t(String key) {
    const Map<String, Map<String, String>> data = {
      'en': {
        'language': 'Language',
        'select_language': 'Select Language',
        'description':
            'Smartscore supports multiple languages to enhance your experience. '
                'Please select your preferred language to continue.',
        'english': 'English',
        'tamil': 'Tamil',
        'hindi': 'Hindi',
      },
      'ta': {
        'language': 'மொழி',
        'select_language': 'மொழியை தேர்ந்தெடுக்கவும்',
        'description':
            'Smartscore பல மொழிகளை ஆதரிக்கிறது. '
                'தொடர உங்கள் விருப்பமான மொழியை தேர்ந்தெடுக்கவும்.',
        'english': 'ஆங்கிலம்',
        'tamil': 'தமிழ்',
        'hindi': 'ஹிந்தி',
      },
      'hi': {
        'language': 'भाषा',
        'select_language': 'भाषा चुनें',
        'description':
            'Smartscore कई भाषाओं का समर्थन करता है। '
                'जारी रखने के लिए अपनी पसंदीदा भाषा चुनें।',
        'english': 'अंग्रेज़ी',
        'tamil': 'तमिल',
        'hindi': 'हिंदी',
      },
    };

    // ✅ CURRENT LANGUAGE MAP
    final langMap = data[_locale.languageCode] ?? data['en']!;

    // ✅ RETURN TRANSLATION OR FALLBACK TO KEY
    return langMap[key] ?? data['en']![key] ?? key;
  }
}
