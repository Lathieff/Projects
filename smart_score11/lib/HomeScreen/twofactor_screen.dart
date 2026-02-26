import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/app_image.dart';
import '../../../controllers/language_provider.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({Key? key}) : super(key: key);

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool is2FAEnabled = false;

  String _t(BuildContext context, String key) {
    final lang =
        context.watch<LanguageProvider>().locale.languageCode;

    switch (lang) {
      case 'ta':
        return _twoFaTa[key] ?? _twoFaEn[key] ?? key;
      case 'hi':
        return _twoFaHi[key] ?? _twoFaEn[key] ?? key;
      default:
        return _twoFaEn[key] ?? key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = screenWidth * 0.05;
    final iconSize = screenWidth * 0.15;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: Text(
          _t(context, 'two_fa_title'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF5395FD),
                Color(0xFF00AA5B),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          height: screenHeight - AppBar().preferredSize.height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: screenHeight * 0.04,
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Icon
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Image.asset(
                      AppIcons.two_factor,
                      height: iconSize * 0.6,
                      width: iconSize * 0.6,
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                // Heading
                Text(
                  _t(context, 'secure_account'),
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F1F1F),
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),

                // Subtitle
                Text(
                  _t(context, 'secure_subtitle'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: const Color(0xFF757575),
                  ),
                ),

                SizedBox(height: screenHeight * 0.08),

                // Toggle Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.022,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _t(context, 'enable_2fa'),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F1F1F),
                        ),
                      ),
                      Transform.scale(
                        scale: screenWidth * 0.0025,
                        child: Switch(
                          value: is2FAEnabled,
                          onChanged: (value) {
                            setState(() {
                              is2FAEnabled = value;
                            });
                          },
                          activeColor: const Color(0xFF00A86B),
                          inactiveThumbColor: Colors.grey[400],
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const Map<String, String> _twoFaEn = {
  "two_fa_title": "Two Factor Authentication",
  "secure_account": "Secure Your Account",
  "secure_subtitle": "Add an extra layer of security to your account",
  "enable_2fa": "Enable 2FA",
};

const Map<String, String> _twoFaTa = {
  "two_fa_title": "இரு நிலை அங்கீகாரம்",
  "secure_account": "உங்கள் கணக்கை பாதுகாக்கவும்",
  "secure_subtitle":
      "உங்கள் கணக்கிற்கு கூடுதல் பாதுகாப்பு அடுக்கைச் சேர்க்கவும்",
  "enable_2fa": "2FA ஐ செயல்படுத்தவும்",
};

const Map<String, String> _twoFaHi = {
  "two_fa_title": "दो-स्तरीय प्रमाणीकरण",
  "secure_account": "अपने खाते को सुरक्षित करें",
  "secure_subtitle":
      "अपने खाते में अतिरिक्त सुरक्षा स्तर जोड़ें",
  "enable_2fa": "2FA सक्षम करें",
};
