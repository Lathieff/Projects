import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  String _t(BuildContext context, String key) {
    final lang =
        context.watch<LanguageProvider>().locale.languageCode;

    switch (lang) {
      case 'ta':
        return _policyTa[key] ?? _policyEn[key] ?? key;
      case 'hi':
        return _policyHi[key] ?? _policyEn[key] ?? key;
      default:
        return _policyEn[key] ?? key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _t(context, 'privacy_policy'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1DA1F2), Color(0xFF1DB954)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _t(context, 'last_updated'),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _SectionTitle(_t(context, 'sec1_title')),
                    _SectionText(_t(context, 'sec1_text')),

                    const SizedBox(height: 16),
                    _SectionTitle(_t(context, 'sec2_title')),
                    _SectionText(_t(context, 'sec2_text')),

                    const SizedBox(height: 16),
                    _SectionTitle(_t(context, 'sec3_title')),
                    _SectionText(_t(context, 'sec3_text')),

                    const SizedBox(height: 16),
                    _SectionTitle(_t(context, 'sec4_title')),
                    _SectionText(_t(context, 'sec4_text')),

                    const SizedBox(height: 16),
                    _SectionTitle(_t(context, 'sec5_title')),
                    _SectionText(_t(context, 'sec5_text')),

                    const SizedBox(height: 16),
                    _SectionTitle(_t(context, 'sec6_title')),
                    _SectionText(_t(context, 'sec6_text')),
                  ],
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black54),
              ),
              child: Text(
                _t(context, 'footer'),
                style:
                    const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _SectionText extends StatelessWidget {
  final String text;
  const _SectionText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }
}

const Map<String, String> _policyEn = {
  "privacy_policy": "Privacy Policy",
  "last_updated": "Last updated: January 20, 2026",

  "sec1_title": "1. Information We Collect",
  "sec1_text":
      "We collect information you provide directly to us including your name, email address, and any other information you choose to provide when using our services.",

  "sec2_title": "2. How We Use Your Information",
  "sec2_text":
      "We use the information we collect to provide, maintain, and improve our services, to communicate with you, and to protect our users.",

  "sec3_title": "3. Information Sharing",
  "sec3_text":
      "We do not share your personal information with third parties except as described in this privacy policy or with your consent.",

  "sec4_title": "4. Data Security",
  "sec4_text":
      "We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.",

  "sec5_title": "5. Your Rights",
  "sec5_text":
      "You have the right to access, update, or delete your personal information at any time through your account settings or by contacting us.",

  "sec6_title": "6. Contact Us",
  "sec6_text":
      "If you have any questions about this Privacy Policy, please contact us at privacy@example.com",

  "footer":
      "By using our services, you agree to the collection and use of information in accordance with this Privacy Policy.",
};

const Map<String, String> _policyTa = {
  "privacy_policy": "தனியுரிமைக் கொள்கை",
  "last_updated": "கடைசியாக புதுப்பிக்கப்பட்டது: ஜனவரி 20, 2026",

  "sec1_title": "1. நாம் சேகரிக்கும் தகவல்கள்",
  "sec1_text":
      "நீங்கள் எங்கள் சேவைகளை பயன்படுத்தும் போது வழங்கும் பெயர், மின்னஞ்சல் முகவரி மற்றும் பிற தகவல்களை நாம் சேகரிக்கிறோம்.",

  "sec2_title": "2. உங்கள் தகவலை எவ்வாறு பயன்படுத்துகிறோம்",
  "sec2_text":
      "சேவைகளை வழங்க, பராமரிக்க, மேம்படுத்த மற்றும் பயனர்களை பாதுகாக்க உங்கள் தகவலை பயன்படுத்துகிறோம்.",

  "sec3_title": "3. தகவல் பகிர்வு",
  "sec3_text":
      "இந்த தனியுரிமைக் கொள்கையில் குறிப்பிடப்பட்டதைத் தவிர, உங்கள் அனுமதி இல்லாமல் தகவல்களை பகிர மாட்டோம்.",

  "sec4_title": "4. தரவு பாதுகாப்பு",
  "sec4_text":
      "உங்கள் தனிப்பட்ட தகவல்களை பாதுகாக்க நியாயமான பாதுகாப்பு நடவடிக்கைகளை எடுக்கிறோம்.",

  "sec5_title": "5. உங்கள் உரிமைகள்",
  "sec5_text":
      "உங்கள் தகவல்களை அணுக, புதுப்பிக்க அல்லது நீக்க உங்களுக்கு உரிமை உள்ளது.",

  "sec6_title": "6. எங்களை தொடர்புகொள்ள",
  "sec6_text":
      "இந்த தனியுரிமைக் கொள்கை குறித்து கேள்விகள் இருந்தால் privacy@example.com என்ற முகவரியில் தொடர்பு கொள்ளவும்.",

  "footer":
      "எங்கள் சேவைகளை பயன்படுத்துவதன் மூலம் இந்த தனியுரிமைக் கொள்கையை நீங்கள் ஏற்கிறீர்கள்.",
};

const Map<String, String> _policyHi = {
  "privacy_policy": "गोपनीयता नीति",
  "last_updated": "अंतिम अपडेट: 20 जनवरी 2026",

  "sec1_title": "1. हम कौन-सी जानकारी एकत्र करते हैं",
  "sec1_text":
      "हम वह जानकारी एकत्र करते हैं जो आप सीधे हमें प्रदान करते हैं, जैसे नाम, ईमेल पता और अन्य विवरण।",

  "sec2_title": "2. आपकी जानकारी का उपयोग",
  "sec2_text":
      "हम आपकी जानकारी का उपयोग सेवाएँ प्रदान करने, सुधारने और उपयोगकर्ताओं की सुरक्षा के लिए करते हैं।",

  "sec3_title": "3. जानकारी साझा करना",
  "sec3_text":
      "हम आपकी व्यक्तिगत जानकारी आपकी सहमति के बिना साझा नहीं करते।",

  "sec4_title": "4. डेटा सुरक्षा",
  "sec4_text":
      "हम आपकी जानकारी को अनधिकृत पहुँच और दुरुपयोग से बचाने के लिए सुरक्षा उपाय अपनाते हैं।",

  "sec5_title": "5. आपके अधिकार",
  "sec5_text":
      "आपको अपनी व्यक्तिगत जानकारी देखने, अपडेट करने या हटाने का अधिकार है।",

  "sec6_title": "6. संपर्क करें",
  "sec6_text":
      "इस गोपनीयता नीति से संबंधित किसी भी प्रश्न के लिए privacy@example.com पर संपर्क करें।",

  "footer":
      "हमारी सेवाओं का उपयोग करके आप इस गोपनीयता नीति से सहमत होते हैं।",
};
