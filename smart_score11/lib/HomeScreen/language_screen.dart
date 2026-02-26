import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String selectedLanguage = "English";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Sync selected language from provider
    final locale =
        context.watch<LanguageProvider>().locale.languageCode;

    if (locale == 'ta') {
      selectedLanguage = "Tamil";
    } else if (locale == 'hi') {
      selectedLanguage = "Hindi";
    } else {
      selectedLanguage = "English";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = context.watch<LanguageProvider>();

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: sp(0.060),
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          lang.t('language'), // ✅ FIXED KEY
          style: TextStyle(
            fontSize: sp(0.065),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2E6FF2),
                Color(0xFF2BB673),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFE3F2FD),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: h(0.04)),

            // ================= ICON STACK =================
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: h(0.11),
                  width: h(0.11),
                  decoration: const BoxDecoration(
                    color: Color(0xFFDFF3FF),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  left: h(0.015),
                  child: _iconBox("A", const Color(0xFF1ECAD3), sp),
                ),
                Positioned(
                  right: h(0.015),
                  bottom: h(0.01),
                  child: _iconBox("அ", const Color(0xFFFF7043), sp),
                ),
              ],
            ),

            SizedBox(height: h(0.025)),

            // ================= TITLE =================
            Text(
              lang.t('select_language'), // ✅ FIXED
              style: TextStyle(
                fontSize: sp(0.045),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: h(0.015)),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: w(0.08)),
              child: Text(
                lang.t('description'), // ✅ FIXED
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: sp(0.032),
                  color: Colors.black,
                  height: 1.4,
                ),
              ),
            ),

            SizedBox(height: h(0.04)),

            // ================= LANGUAGE LIST =================
            _languageRow("A", lang.t('english'), "English", "en"),
            _languageRow("த", lang.t('tamil'), "Tamil", "ta"),
            _languageRow("आ", lang.t('hindi'), "Hindi", "hi"),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  // ================= LANGUAGE ROW =================
  Widget _languageRow(
    String symbol,
    String title,
    String value,
    String languageCode,
  ) {
    final bool isSelected = selectedLanguage == value;

    return GestureDetector(
      onTap: () => _changeLanguage(value, languageCode),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE3F2FD) : Colors.transparent,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  isSelected ? Colors.blue : Colors.grey.shade200,
              child: Text(
                symbol,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: selectedLanguage,
              onChanged: (_) => _changeLanguage(value, languageCode),
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // ================= CHANGE LANGUAGE =================
  void _changeLanguage(String value, String code) {
    setState(() => selectedLanguage = value);
    context.read<LanguageProvider>().changeLanguage(code);
  }

  // ================= ICON BOX =================
  Widget _iconBox(String text, Color color, double Function(double) sp) {
    return Container(
      height: sp(0.12),
      width: sp(0.12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: sp(0.06),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
