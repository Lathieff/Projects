import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../models/app_language.dart';
import '../providers/translation_provider.dart';
import '../widget/gradient_bg.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechReady = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    _speechReady = await _speech.initialize(
      onStatus: (s) {
        if (s == 'done' || s == 'notListening') {
          if (mounted) setState(() => _isListening = false);
        }
      },
      onError: (_) {
        if (mounted) setState(() => _isListening = false);
      },
    );
    if (mounted) setState(() {});
  }

  void _toggleMic() async {
    if (!_speechReady) {
      _showSnack('Speech recognition not available on this device');
      return;
    }
    final prov = context.read<TranslationProvider>();
    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    } else {
      final locale = langByCode(prov.fromCode).speechLocale;
      setState(() => _isListening = true);
      await _speech.listen(
        localeId: locale,
        onResult: (r) {
          if (mounted) setState(() => _ctrl.text = r.recognizedWords);
        },
      );
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  void _runTranslate() {
    FocusScope.of(context).unfocus();
    context.read<TranslationProvider>().translate(_ctrl.text);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<TranslationProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Translator',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20)),
        centerTitle: true,
        actions: [
          // Clear button
          if (prov.result.isNotEmpty || _ctrl.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.refresh_rounded,
                  color: Colors.white70),
              onPressed: () {
                _ctrl.clear();
                prov.clearResult();
              },
            ),
        ],
      ),
      body: GradientBg(
        colors: const [
          Color(0xFF0D0D1A),
          Color(0xFF1A0A2E),
          Color(0xFF2D0845),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
            child: Column(
              children: [
                // ── From / To selector ─────────────────────────────────────
                _LangSwapRow(
                  fromCode: prov.fromCode,
                  toCode: prov.toCode,
                  onFromChanged: (c) =>
                      context.read<TranslationProvider>().setFrom(c),
                  onToChanged: (c) =>
                      context.read<TranslationProvider>().setTo(c),
                  onSwap: () =>
                      context.read<TranslationProvider>().swapLanguages(),
                ),

                const SizedBox(height: 20),

                // ── Input card ─────────────────────────────────────────────
                _InputCard(
                  controller: _ctrl,
                  isListening: _isListening,
                  onMicTap: _toggleMic,
                ),

                const SizedBox(height: 18),

                // ── Model download status ──────────────────────────────────
                if (prov.modelStatus == ModelStatus.downloading)
                  _ModelBanner(msg: prov.modelStatusMsg),

                if (prov.modelStatus == ModelStatus.error)
                  _ErrorBanner(msg: prov.modelStatusMsg),

                const SizedBox(height: 4),

                // ── Translate button ───────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed:
                        prov.isTranslating ? null : _runTranslate,
                    icon: prov.isTranslating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white),
                          )
                        : const Icon(Icons.translate_rounded),
                    label: Text(
                      prov.isTranslating
                          ? 'Translating…'
                          : 'Translate',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          const Color(0xFF6C63FF).withOpacity(0.45),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 8,
                      shadowColor:
                          const Color(0xFF6C63FF).withOpacity(0.4),
                    ),
                  ),
                ),

                // ── Result card ────────────────────────────────────────────
                if (prov.result.isNotEmpty) ...[
                  const SizedBox(height: 26),
                  _ResultCard(
                    result: prov.result,
                    toLang: langByCode(prov.toCode),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── From / To Swap Row ────────────────────────────────────────────────────────
class _LangSwapRow extends StatelessWidget {
  final String fromCode;
  final String toCode;
  final ValueChanged<String> onFromChanged;
  final ValueChanged<String> onToChanged;
  final VoidCallback onSwap;

  const _LangSwapRow({
    required this.fromCode,
    required this.toCode,
    required this.onFromChanged,
    required this.onToChanged,
    required this.onSwap,
  });

  void _pick(BuildContext ctx, String current, ValueChanged<String> cb) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF12101F),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.4,
        expand: false,
        builder: (_, sc) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 14),
            const Text('Select Language',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                controller: sc,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: kLanguages
                    .map((l) => ListTile(
                          leading: Text(l.flag,
                              style: const TextStyle(fontSize: 26)),
                          title: Text(l.nativeName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          subtitle: Text(l.name,
                              style: TextStyle(
                                  color:
                                      Colors.white.withOpacity(0.45))),
                          trailing: l.code == current
                              ? const Icon(Icons.check_circle,
                                  color: Color(0xFF6C63FF))
                              : null,
                          onTap: () {
                            cb(l.code);
                            Navigator.pop(ctx);
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final from = langByCode(fromCode);
    final to = langByCode(toCode);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(0.07),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          // From
          Expanded(
            child: GestureDetector(
              onTap: () => _pick(context, fromCode, onFromChanged),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FROM',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10,
                          letterSpacing: 1.2)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(from.flag,
                          style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(from.nativeName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                      ),
                      const Icon(Icons.expand_more,
                          color: Colors.white54, size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Swap
          GestureDetector(
            onTap: onSwap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(9),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [Color(0xFF6C63FF), Color(0xFFFF6584)]),
              ),
              child: const Icon(Icons.swap_horiz_rounded,
                  color: Colors.white, size: 20),
            ),
          ),

          // To
          Expanded(
            child: GestureDetector(
              onTap: () => _pick(context, toCode, onToChanged),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('TO',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10,
                          letterSpacing: 1.2)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.expand_more,
                          color: Colors.white54, size: 18),
                      Flexible(
                        child: Text(to.nativeName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15)),
                      ),
                      const SizedBox(width: 6),
                      Text(to.flag,
                          style: const TextStyle(fontSize: 22)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Input Card ────────────────────────────────────────────────────────────────
class _InputCard extends StatelessWidget {
  final TextEditingController controller;
  final bool isListening;
  final VoidCallback onMicTap;

  const _InputCard({
    required this.controller,
    required this.isListening,
    required this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(isListening ? 0.12 : 0.07),
            Colors.white.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: isListening
              ? const Color(0xFF6C63FF)
              : Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: isListening
            ? [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.28),
                  blurRadius: 18,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 5,
            minLines: 4,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, height: 1.55),
            decoration: InputDecoration(
              hintText: 'Enter text to translate…',
              hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.28), fontSize: 15),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Listening indicator
                if (isListening)
                  Row(children: [
                    _PulsingDot(),
                    const SizedBox(width: 8),
                    const Text('Listening…',
                        style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontSize: 13,
                            fontWeight: FontWeight.w600)),
                  ])
                else
                  Text('Tap mic to speak',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.28),
                          fontSize: 12)),

                // Mic button
                GestureDetector(
                  onTap: onMicTap,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 260),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: isListening
                            ? [
                                const Color(0xFFFF6584),
                                const Color(0xFFFF8E53)
                              ]
                            : [
                                const Color(0xFF6C63FF),
                                const Color(0xFF3A3897)
                              ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isListening
                                  ? const Color(0xFFFF6584)
                                  : const Color(0xFF6C63FF))
                              .withOpacity(0.45),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Icon(
                      isListening
                          ? Icons.mic_rounded
                          : Icons.mic_none_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pulsing dot ───────────────────────────────────────────────────────────────
class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;
  late Animation<double> _a;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 640))
      ..repeat(reverse: true);
    _a = Tween<double>(begin: 0.25, end: 1.0).animate(_c);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _a,
        child: Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: Color(0xFF6C63FF)),
        ),
      );
}

// ── Model Download Banner ─────────────────────────────────────────────────────
class _ModelBanner extends StatelessWidget {
  final String msg;
  const _ModelBanner({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF1A1464).withOpacity(0.8),
        border:
            Border.all(color: const Color(0xFF6C63FF).withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
                strokeWidth: 2, color: Color(0xFF6C63FF)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(msg,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

// ── Error Banner ──────────────────────────────────────────────────────────────
class _ErrorBanner extends StatelessWidget {
  final String msg;
  const _ErrorBanner({required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF2D0000).withOpacity(0.8),
        border: Border.all(color: Colors.red.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(msg,
                style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

// ── Result Card ───────────────────────────────────────────────────────────────
class _ResultCard extends StatelessWidget {
  final String result;
  final AppLanguage toLang;

  const _ResultCard({required this.result, required this.toLang});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1464), Color(0xFF2D1B69)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border:
            Border.all(color: const Color(0xFF6C63FF).withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.2),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: Color(0xFF43E97B), size: 16),
              const SizedBox(width: 6),
              Text(
                'Result in ${toLang.flag} ${toLang.nativeName} • ML Kit On-Device',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SelectableText(
            result,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}