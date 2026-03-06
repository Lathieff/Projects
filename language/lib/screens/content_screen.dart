import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import '../models/app_language.dart';
import '../providers/translation_provider.dart';
import '../widget/gradient_bg.dart';
import 'translator_screen.dart';

// ── Static content for the 4 primary UI languages ─────────────────────────────
const Map<String, Map<String, String>> _staticContent = {
  'en': {
    'title': 'Discover India',
    'subtitle': 'A land of diversity, culture & heritage',
    'body':
        'India is a vibrant tapestry of languages, traditions, and landscapes. '
        'From the snow-capped Himalayas to the tropical beaches of Kerala, '
        'every corner tells a unique story. With over 1.4 billion people '
        'speaking hundreds of languages, India stands as a testament to '
        'unity in diversity.',
    'sec2title': 'Languages of India',
    'sec2body':
        'India recognises 22 official languages in its constitution. Tamil is '
        'one of the oldest living languages in the world with a literary '
        'tradition spanning over 2,000 years. Hindi serves as the official '
        'language of the Union. Kannada, Telugu and many more enrich this '
        'incredible linguistic landscape.',
  },
  'ta': {
    'title': 'இந்தியாவை கண்டறியுங்கள்',
    'subtitle': 'பன்முகத்தன்மை, கலாச்சாரம் மற்றும் பாரம்பரியத்தின் நிலம்',
    'body':
        'இந்தியா மொழிகள், மரபுகள் மற்றும் நிலப்பரப்புகளின் துடிப்பான கலப்பு. '
        'வடக்கில் உள்ள பனி மூடிய இமயமலையிலிருந்து கேரளாவின் வெப்பமண்டல '
        'கடற்கரைகள் வரை, ஒவ்வொரு மூலையும் ஒரு தனித்துவமான கதையை சொல்கிறது.',
    'sec2title': 'இந்தியாவின் மொழிகள்',
    'sec2body':
        'இந்தியா தனது அரசியலமைப்பில் 22 அதிகாரப்பூர்வ மொழிகளை அங்கீகரிக்கிறது. '
        'தமிழ் உலகின் மிகவும் பழமையான உயிரோடிருக்கும் மொழிகளில் ஒன்றாகும்.',
  },
  'hi': {
    'title': 'भारत की खोज करें',
    'subtitle': 'विविधता, संस्कृति और विरासत की भूमि',
    'body':
        'भारत भाषाओं, परंपराओं और परिदृश्यों की एक जीवंत टेपेस्ट्री है। '
        'उत्तर में बर्फ से ढके हिमालय से लेकर केरल के उष्णकटिबंधीय '
        'समुद्र तटों तक, हर कोना एक अनूठी कहानी कहता है।',
    'sec2title': 'भारत की भाषाएं',
    'sec2body':
        'भारत अपने संविधान में 22 आधिकारिक भाषाओं को मान्यता देता है। '
        'तमिल दुनिया की सबसे पुरानी जीवित भाषाओं में से एक है।',
  },
  'kn': {
    'title': 'ಭಾರತವನ್ನು ಅನ್ವೇಷಿಸಿ',
    'subtitle': 'ವೈವಿಧ್ಯತೆ, ಸಂಸ್ಕೃತಿ ಮತ್ತು ಪರಂಪರೆಯ ನೆಲ',
    'body':
        'ಭಾರತವು ಭಾಷೆಗಳು, ಸಂಪ್ರದಾಯಗಳು ಮತ್ತು ಭೂದೃಶ್ಯಗಳ ರೋಮಾಂಚಕ ಮಿಶ್ರಣ. '
        'ಉತ್ತರದ ಹಿಮಾವೃತ ಹಿಮಾಲಯದಿಂದ ಕೇರಳದ ಉಷ್ಣವಲಯ ಕಡಲತೀರಗಳವರೆಗೆ '
        'ಪ್ರತಿ ಮೂಲೆಯೂ ಒಂದು ಅನನ್ಯ ಕಥೆಯನ್ನು ಹೇಳುತ್ತದೆ.',
    'sec2title': 'ಭಾರತದ ಭಾಷೆಗಳು',
    'sec2body':
        'ಭಾರತವು ತನ್ನ ಸಂವಿಧಾನದಲ್ಲಿ 22 ಅಧಿಕೃತ ಭಾಷೆಗಳನ್ನು ಗುರುತಿಸುತ್ತದೆ. '
        'ತಮಿಳು ಪ್ರಪಂಚದ ಅತ್ಯಂತ ಹಳೆಯ ಜೀವಂತ ಭಾಷೆಗಳಲ್ಲಿ ಒಂದಾಗಿದೆ.',
  },
};

// English source strings to translate via ML Kit for other languages
const Map<String, String> _englishSource = {
  'title': 'Discover India',
  'subtitle': 'A land of diversity, culture & heritage',
  'body':
      'India is a vibrant tapestry of languages, traditions, and landscapes. '
      'From the snow-capped Himalayas to the tropical beaches of Kerala, '
      'every corner tells a unique story. With over 1.4 billion people '
      'speaking hundreds of languages, India stands as a testament to '
      'unity in diversity.',
  'sec2title': 'Languages of India',
  'sec2body':
      'India recognises 22 official languages in its constitution. Tamil is '
      'one of the oldest living languages in the world with a literary '
      'tradition spanning over 2,000 years. Hindi serves as the official '
      'language of the Union. Kannada, Telugu and many more enrich this '
      'incredible linguistic landscape.',
};

// ─────────────────────────────────────────────────────────────────────────────

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  // Cache translated content so we don't re-translate on every rebuild
  final Map<String, Map<String, String>> _translatedCache = {};
  Map<String, String>? _currentContent;
  bool _isTranslating = false;
  String _lastTranslatedCode = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final langCode = context.read<TranslationProvider>().uiLangCode;
    _loadContent(langCode);
  }

  Future<void> _loadContent(String langCode) async {
    // Already loaded for this language
    if (_lastTranslatedCode == langCode && _currentContent != null) return;

    // Use static content for the 4 pre-translated languages
    if (_staticContent.containsKey(langCode)) {
      setState(() {
        _currentContent = _staticContent[langCode];
        _lastTranslatedCode = langCode;
        _isTranslating = false;
      });
      return;
    }

    // Use cache if available
    if (_translatedCache.containsKey(langCode)) {
      setState(() {
        _currentContent = _translatedCache[langCode];
        _lastTranslatedCode = langCode;
        _isTranslating = false;
      });
      return;
    }

    // Translate via ML Kit
    setState(() => _isTranslating = true);

    try {
      final targetLang = langByCode(langCode).mlKit;
      final translator = OnDeviceTranslator(
        sourceLanguage: TranslateLanguage.english,
        targetLanguage: targetLang,
      );

      // Download model if needed (reuse logic from TranslationProvider)
      final modelManager = OnDeviceTranslatorModelManager();
      final isReady = await modelManager.isModelDownloaded(targetLang.bcpCode);
      if (!isReady) {
        await modelManager.downloadModel(targetLang.bcpCode);
      }

      // Translate all 5 strings
      final translated = <String, String>{};
      for (final entry in _englishSource.entries) {
        translated[entry.key] = await translator.translateText(entry.value);
      }
      await translator.close();

      _translatedCache[langCode] = translated;

      if (mounted) {
        setState(() {
          _currentContent = translated;
          _lastTranslatedCode = langCode;
          _isTranslating = false;
        });
      }
    } catch (e) {
      // Fallback to English on error
      if (mounted) {
        setState(() {
          _currentContent = _staticContent['en'];
          _lastTranslatedCode = langCode;
          _isTranslating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TranslationProvider>();
    final langCode = prov.uiLangCode;

    // Trigger translation when language changes
    if (_lastTranslatedCode != langCode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _loadContent(langCode);
      });
    }

    final content = _currentContent ?? _staticContent['en']!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          content['title'] ?? 'Discover India',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: [
          // Language switcher — all 15 languages
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.language, color: Colors.white),
              color: const Color(0xFF1A1A2E),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              onSelected: (code) {
                context.read<TranslationProvider>().setUiLanguage(code);
              },
              itemBuilder: (_) => kLanguages
                  .map((l) => PopupMenuItem(
                        value: l.code,
                        child: Row(
                          children: [
                            Text(l.flag,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 10),
                            Text(l.nativeName,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            if (l.code == langCode) ...[
                              const Spacer(),
                              const Icon(Icons.check,
                                  color: Color(0xFF6C63FF), size: 16),
                            ],
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      body: GradientBg(
        colors: const [
          Color(0xFF1A1A2E),
          Color(0xFF16213E),
          Color(0xFF0F3460),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        child: SafeArea(
          child: _isTranslating
              ? _TranslatingPlaceholder(langCode: langCode)
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding:
                          const EdgeInsets.fromLTRB(20, 10, 20, 110),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          _HeroBanner(content: content),
                          const SizedBox(height: 22),
                          _Card(
                            icon: Icons.explore_rounded,
                            color: const Color(0xFFFF6584),
                            title: content['title'] ?? '',
                            body: content['body'] ?? '',
                          ),
                          const SizedBox(height: 16),
                          _Card(
                            icon: Icons.record_voice_over_rounded,
                            color: const Color(0xFF43E97B),
                            title: content['sec2title'] ?? '',
                            body: content['sec2body'] ?? '',
                          ),
                          const SizedBox(height: 16),
                          _LanguageShowcase(),
                        ]),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: _TranslateButton(langCode: langCode),
    );
  }
}

// ── Translating placeholder ───────────────────────────────────────────────────
class _TranslatingPlaceholder extends StatelessWidget {
  final String langCode;
  const _TranslatingPlaceholder({required this.langCode});

  @override
  Widget build(BuildContext context) {
    final lang = langByCode(langCode);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: Color(0xFF6C63FF)),
          const SizedBox(height: 20),
          Text(
            'Translating to ${lang.flag} ${lang.nativeName}…',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Downloading language model if needed',
            style: TextStyle(
                color: Colors.white.withOpacity(0.45), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ── Hero Banner ───────────────────────────────────────────────────────────────
class _HeroBanner extends StatelessWidget {
  final Map<String, String> content;
  const _HeroBanner({required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.4),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content['subtitle'] ?? '',
            style: TextStyle(
                color: Colors.white.withOpacity(0.8), fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            content['title'] ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: kLanguages
                .map((l) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text('${l.flag} ${l.nativeName}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

// ── Content Card ──────────────────────────────────────────────────────────────
class _Card extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  const _Card({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(
            color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(body,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 14.5,
                  height: 1.65)),
        ],
      ),
    );
  }
}

// ── Language Showcase ─────────────────────────────────────────────────────────
class _LanguageShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6C63FF).withOpacity(0.15),
            const Color(0xFFFF6584).withOpacity(0.1),
          ],
        ),
        border: Border.all(
            color: const Color(0xFF6C63FF).withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('15 Languages Supported',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text('Tap translate to use all of them',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.5), fontSize: 12)),
          const SizedBox(height: 14),
          ...kLanguages.map(
            (l) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text(l.flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Text(l.nativeName,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                  const SizedBox(width: 6),
                  Text('(${l.name})',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.45),
                          fontSize: 12)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom Translate Button ───────────────────────────────────────────────────
class _TranslateButton extends StatelessWidget {
  final String langCode;
  const _TranslateButton({required this.langCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0F3460).withOpacity(0),
            const Color(0xFF0F3460),
          ],
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, a, __) => const TranslatorScreen(),
              transitionsBuilder: (_, a, __, child) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                    CurvedAnimation(parent: a, curve: Curves.easeOut)),
                child: child,
              ),
              transitionDuration: const Duration(milliseconds: 380),
            ),
          ),
          icon: const Icon(Icons.translate_rounded),
          label: const Text('Translate',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            elevation: 10,
            shadowColor: const Color(0xFF6C63FF).withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}