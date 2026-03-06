import 'package:google_mlkit_translation/google_mlkit_translation.dart';

/// Represents one language option in the UI.
class AppLanguage {
  final String code;           // BCP-47 / internal key
  final String name;           // English name
  final String nativeName;     // Script-native name
  final String flag;           // Emoji flag
  final TranslateLanguage mlKit; // ML Kit enum value
  final String speechLocale;   // speech_to_text locale string

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    required this.mlKit,
    required this.speechLocale,
  });
}

/// All supported languages — Indian + Asian focus.
const List<AppLanguage> kLanguages = [
  // ── Indian languages ──────────────────────────────────────────────────────
  AppLanguage(
    code: 'en',
    name: 'English',
    nativeName: 'English',
    flag: '🇬🇧',
    mlKit: TranslateLanguage.english,
    speechLocale: 'en_US',
  ),
  AppLanguage(
    code: 'ta',
    name: 'Tamil',
    nativeName: 'தமிழ்',
    flag: '🇮🇳',
    mlKit: TranslateLanguage.tamil,
    speechLocale: 'ta_IN',
  ),
  AppLanguage(
    code: 'hi',
    name: 'Hindi',
    nativeName: 'हिंदी',
    flag: '🇮🇳',
    mlKit: TranslateLanguage.hindi,
    speechLocale: 'hi_IN',
  ),
  AppLanguage(
    code: 'kn',
    name: 'Kannada',
    nativeName: 'ಕನ್ನಡ',
    flag: '🇮🇳',
    mlKit: TranslateLanguage.kannada,
    speechLocale: 'kn_IN',
  ),
  AppLanguage(
    code: 'te',
    name: 'Telugu',
    nativeName: 'తెలుగు',
    flag: '🇮🇳',
    mlKit: TranslateLanguage.telugu,
    speechLocale: 'te_IN',
  ),
  // NOTE: ML Kit does NOT support Malayalam or Punjabi.
  // Supported Indian languages from the official list:
  AppLanguage(
    code: 'mr',
    name: 'Marathi',
    nativeName: 'मराठी',
    flag: '🇮🇳',
    mlKit: TranslateLanguage.marathi,
    speechLocale: 'mr_IN',
  ),
  AppLanguage(
    code: 'bn',
    name: 'Bengali',
    nativeName: 'বাংলা',
    flag: '🇧🇩',
    mlKit: TranslateLanguage.bengali,
    speechLocale: 'bn_IN',
  ),
  AppLanguage(
    code: 'gu',
    name: 'Gujarati',
    nativeName: 'ગુજરાતી',
    flag: '🇮🇳',
    mlKit: TranslateLanguage.gujarati,
    speechLocale: 'gu_IN',
  ),
  AppLanguage(
    code: 'ur',
    name: 'Urdu',
    nativeName: 'اردو',
    flag: '🇵🇰',
    mlKit: TranslateLanguage.urdu,
    speechLocale: 'ur_PK',
  ),
  AppLanguage(
    code: 'fa',
    name: 'Persian',
    nativeName: 'فارسی',
    flag: '🇮🇷',
    mlKit: TranslateLanguage.persian,
    speechLocale: 'fa_IR',
  ),

  // ── Other Asian languages ─────────────────────────────────────────────────
  AppLanguage(
    code: 'zh',
    name: 'Chinese',
    nativeName: '中文',
    flag: '🇨🇳',
    mlKit: TranslateLanguage.chinese,
    speechLocale: 'zh_CN',
  ),
  AppLanguage(
    code: 'ja',
    name: 'Japanese',
    nativeName: '日本語',
    flag: '🇯🇵',
    mlKit: TranslateLanguage.japanese,
    speechLocale: 'ja_JP',
  ),
  AppLanguage(
    code: 'ko',
    name: 'Korean',
    nativeName: '한국어',
    flag: '🇰🇷',
    mlKit: TranslateLanguage.korean,
    speechLocale: 'ko_KR',
  ),
  AppLanguage(
    code: 'th',
    name: 'Thai',
    nativeName: 'ภาษาไทย',
    flag: '🇹🇭',
    mlKit: TranslateLanguage.thai,
    speechLocale: 'th_TH',
  ),
  AppLanguage(
    code: 'ar',
    name: 'Arabic',
    nativeName: 'العربية',
    flag: '🇸🇦',
    mlKit: TranslateLanguage.arabic,
    speechLocale: 'ar_SA',
  ),
];

AppLanguage langByCode(String code) =>
    kLanguages.firstWhere((l) => l.code == code,
        orElse: () => kLanguages.first);