import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_language.dart';
import '../providers/translation_provider.dart';
import '../widget/gradient_bg.dart';
import 'content_screen.dart';

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({super.key});

  @override
  State<LanguageSelectorScreen> createState() =>
      _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.22),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // Separate "UI display" languages (the 4 original ones)
  static const _uiLanguages = ['en', 'ta', 'hi', 'kn'];

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TranslationProvider>();
    final selected = prov.uiLangCode;

    return Scaffold(
      body: GradientBg(
        colors: const [
          Color(0xFF0F0C29),
          Color(0xFF302B63),
          Color(0xFF24243E),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Glowing globe icon
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6C63FF), Color(0xFFFF6584)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.55),
                          blurRadius: 28,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.translate_rounded,
                        color: Colors.white, size: 44),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your app language',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Powered by Google ML Kit · Works Offline',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.38),
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Language cards — only the 4 UI languages
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: [
                        ..._uiLanguages.map((code) {
                          final lang = langByCode(code);
                          final isSelected = selected == code;
                          return _LangCard(
                            lang: lang,
                            isSelected: isSelected,
                            onTap: () {
                              context
                                  .read<TranslationProvider>()
                                  .setUiLanguage(code);
                            },
                          );
                        }),
                        const SizedBox(height: 16),

                        // Continue button
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              // Pre-set the From language to match UI selection
                              context
                                  .read<TranslationProvider>()
                                  .setFrom(selected);
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, a, __) =>
                                      const ContentScreen(),
                                  transitionsBuilder: (_, a, __, child) =>
                                      FadeTransition(
                                          opacity: a, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 450),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C63FF),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 10,
                              shadowColor:
                                  const Color(0xFF6C63FF).withOpacity(0.5),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Continue',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward_rounded),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LangCard extends StatelessWidget {
  final AppLanguage lang;
  final bool isSelected;
  final VoidCallback onTap;

  const _LangCard({
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 12),
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF3A3897)],
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.07),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C63FF)
                : Colors.white.withOpacity(0.14),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.38),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Text(lang.flag, style: const TextStyle(fontSize: 30)),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lang.nativeName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500)),
                  Text(lang.name,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 13)),
                ],
              ),
            ),
            isSelected
                ? const Icon(Icons.check_circle_rounded,
                    color: Colors.white, size: 24)
                : Icon(Icons.radio_button_unchecked,
                    color: Colors.white.withOpacity(0.3), size: 24),
          ],
        ),
      ),
    );
  }
}