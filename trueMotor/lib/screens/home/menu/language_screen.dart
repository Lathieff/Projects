import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  SelectLanguageScreen
// ─────────────────────────────────────────────
class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String _selectedLanguage = 'English';

  // (label, nativeLabel, symbol)
  static const _languages = [
    ('English', 'English', 'A'),
    ('தமிழ்',   'Tamil',   'த'),
    ('हिंदी',    'Hindi',   'आ'),
  ];

  @override
  Widget build(BuildContext context) {
    final mq       = MediaQuery.of(context);
    final double w = mq.size.width;
    final double h = mq.size.height;

    final double wp = w / 390;
    final double hp = h / 844;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
        body: Container(
          width:  w,
          height: h,
          // ── Background: white → teal ──────────────────
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin:  Alignment.topCenter,
              end:    Alignment.bottomCenter,
              stops:  [0.4598, 1.0],
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFF3AB0B7),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── AppBar ──────────────────────────────────
              Container(
                width:   w,
                height:  56 * hp,
                color:   const Color(0xFFFBF8F8),
                padding: EdgeInsets.symmetric(horizontal: 16 * wp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: const Color(0xFF2E7D52),
                        size:  24 * wp,
                      ),
                    ),
                    SizedBox(width: 12 * wp),
                    Text(
                      'Select Language',
                      style: TextStyle(
                        color:      const Color(0xFF2E7D52),
                        fontSize:   20 * wp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Body ────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20 * wp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(height: 36 * hp),

                      // ── Top Image ────────────────────────
                      Center(
                        child: Image.asset(
                          'assets/language.png',
                          width:  130 * wp,
                          height: 130 * wp,
                          fit:    BoxFit.contain,
                          errorBuilder: (_, _, _) => Container(
                            width:  130 * wp,
                            height: 130 * wp,
                            decoration: BoxDecoration(
                              color:        const Color(0xFFDFF2F3),
                              shape:        BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.translate,
                              size:  64 * wp,
                              color: const Color(0xFF3AB0B7),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 22 * hp),

                      // ── Title ────────────────────────────
                      Text(
                        'Select Language',
                        style: TextStyle(
                          fontSize:   20 * wp,
                          fontWeight: FontWeight.w800,
                          color:      const Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: 10 * hp),

                      // ── Description ──────────────────────
                      Text(
                        'True Guide supports multiple languages to enhance your experience. Please select your preferred language to continue.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14 * wp,
                          color:    const Color(0xFF3D3D3D),
                          height:   1.6,
                        ),
                      ),
                      SizedBox(height: 24 * hp),

                      // ── Language Items ───────────────────
                      Column(
                        children: List.generate(_languages.length, (i) {
                          final (label, native, symbol) = _languages[i];
                          final bool isLast   = i == _languages.length - 1;
                          final bool selected = _selectedLanguage == label;

                          return _LanguageItem(
                            label:    label,
                            native:   native,
                            symbol:   symbol,
                            selected: selected,
                            isLast:   isLast,
                            wp:       wp,
                            hp:       hp,
                            onTap: () =>
                                setState(() => _selectedLanguage = label),
                          );
                        }),
                      ),

                      SizedBox(height: 40 * hp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

// ─────────────────────────────────────────────
//  _LanguageItem
// ─────────────────────────────────────────────
class _LanguageItem extends StatelessWidget {
  final String   label;
  final String   native;
  final String   symbol;
  final bool     selected;
  final bool     isLast;
  final double   wp;
  final double   hp;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.label,
    required this.native,
    required this.symbol,
    required this.selected,
    required this.isLast,
    required this.wp,
    required this.hp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            // selected row → light teal bg (matches screenshot)
            color: selected
                ? const Color(0xFFDFF2F3)
                : Colors.transparent,
            padding: EdgeInsets.symmetric(
              horizontal: 4 * wp,
              vertical:   16 * hp,
            ),
            child: Row(
              children: [

                // ── Symbol Circle ──────────────────────────
                Container(
                  width:  52 * wp,
                  height: 52 * wp,
                  decoration: BoxDecoration(
                    color:  const Color(0xFFE8E8F0),
                    shape:  BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    symbol,
                    style: TextStyle(
                      fontSize:   22 * wp,
                      fontWeight: FontWeight.w700,
                      color:      const Color(0xFF333355),
                    ),
                  ),
                ),
                SizedBox(width: 16 * wp),

                // ── Labels ────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontSize:   16 * wp,
                          fontWeight: FontWeight.w700,
                          color:      const Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: 2 * hp),
                      Text(
                        native,
                        style: TextStyle(
                          fontSize: 13 * wp,
                          color:    const Color(0xFF888888),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Radio ─────────────────────────────────
                Container(
                  width:  24 * wp,
                  height: 24 * wp,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF1565C0)
                          : const Color(0xFFAAAAAA),
                      width: 2,
                    ),
                    color: selected
                        ? const Color(0xFF1565C0)
                        : Colors.transparent,
                  ),
                  child: selected
                      ? Center(
                    child: Container(
                      width:  10 * wp,
                      height: 10 * wp,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),

        // ── Divider ───────────────────────────────────
        if (!isLast)
          Divider(
            height:    2,
            thickness: 2,
            color:     const Color(0xFFDDDDDD),
          ),
      ],
    );
  }
}

