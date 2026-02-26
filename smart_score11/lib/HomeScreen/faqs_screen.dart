import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<bool> _expanded = List.generate(7, (_) => false);

  String get lang => context.watch<LanguageProvider>().locale.languageCode;

  // 🔹 Local translator (uses your maps)
  String t(String key) {
    switch (lang) {
      case 'ta':
        return _ta[key] ?? _en[key] ?? key;
      case 'hi':
        return _hi[key] ?? _en[key] ?? key;
      default:
        return _en[key] ?? key;
    }
  }

  final List<String> _faqKeys = [
    'faq_q1',
    'faq_q2',
    'faq_q3',
    'faq_q4',
    'faq_q5',
    'faq_q6',
    'faq_q7',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t('faq_title'),
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
              colors: [
                Color(0xFF1DA1F2),
                Color(0xFF1DB954),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _faqKeys.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ExpansionTile(
                tilePadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                title: Text(
                  t(_faqKeys[index]),
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(
                  _expanded[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF2563EB),
                ),
                onExpansionChanged: (value) {
                  setState(() => _expanded[index] = value);
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Text(
                      t('faq_a${index + 1}'),
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

const Map<String, String> _en = {
  "faq_title": "FAQs",

  "faq_q1": "How do I reset my password?",
  "faq_a1":
      "You can reset your password from the login screen by selecting 'Forgot Password' and following the instructions.",

  "faq_q2": "How do I enable two-factor authentication?",
  "faq_a2":
      "Go to Settings > Security and enable two-factor authentication for added account protection.",

  "faq_q3": "How can I manage app permissions?",
  "faq_a3":
      "You can manage app permissions from your device settings at any time.",

  "faq_q4": "How do I set up app lock?",
  "faq_a4":
      "App lock can be enabled from the Security section using a PIN, pattern, or biometric authentication.",

  "faq_q5": "How can I contact customer support?",
  "faq_a5":
      "You can contact customer support through the Help & Support section in the app.",

  "faq_q6": "Is my data secure?",
  "faq_a6":
      "Yes, your data is protected using industry-standard security measures.",

  "faq_q7": "How do I delete my account?",
  "faq_a7":
      "You can delete your account from Settings > Account > Delete Account. This action is permanent.",
};

const Map<String, String> _ta = {
  "faq_title": "அடிக்கடி கேட்கப்படும் கேள்விகள்",

  "faq_q1": "என் கடவுச்சொல்லை எப்படி மீட்டமைப்பது?",
  "faq_a1":
      "உள்நுழைவு திரையில் 'கடவுச்சொல் மறந்துவிட்டீர்களா?' என்பதைத் தேர்ந்தெடுத்து வழிமுறைகளைப் பின்பற்றவும்.",

  "faq_q2": "இரு நிலை அங்கீகாரத்தை எப்படி செயல்படுத்துவது?",
  "faq_a2":
      "அமைப்புகள் > பாதுகாப்பு பகுதியில் சென்று இரு நிலை அங்கீகாரத்தை செயல்படுத்தலாம்.",

  "faq_q3": "ஆப் அனுமதிகளை எப்படி நிர்வகிப்பது?",
  "faq_a3":
      "உங்கள் சாதனத்தின் அமைப்புகளில் இருந்து ஆப் அனுமதிகளை எப்போது வேண்டுமானாலும் மாற்றலாம்.",

  "faq_q4": "ஆப் பூட்டை எப்படி அமைப்பது?",
  "faq_a4":
      "பாதுகாப்பு பகுதியில் PIN, பேட்டர்ன் அல்லது பயோமெட்ரிக் மூலம் ஆப் பூட்டை செயல்படுத்தலாம்.",

  "faq_q5": "வாடிக்கையாளர் ஆதரவை எப்படி தொடர்புகொள்வது?",
  "faq_a5":
      "ஆப்பில் உள்ள உதவி & ஆதரவு பகுதியில் இருந்து வாடிக்கையாளர் ஆதரவை தொடர்புகொள்ளலாம்.",

  "faq_q6": "என் தரவு பாதுகாப்பாக உள்ளதா?",
  "faq_a6":
      "ஆம், உங்கள் தரவு தொழில்துறை தரமான பாதுகாப்பு முறைகளால் பாதுகாக்கப்படுகிறது.",

  "faq_q7": "என் கணக்கை எப்படி நீக்குவது?",
  "faq_a7":
      "அமைப்புகள் > கணக்கு > கணக்கை நீக்கு மூலம் உங்கள் கணக்கை நிரந்தரமாக நீக்கலாம்.",
};

const Map<String, String> _hi = {
  "faq_title": "अक्सर पूछे जाने वाले प्रश्न",

  "faq_q1": "मैं अपना पासवर्ड कैसे रीसेट कर सकता हूँ?",
  "faq_a1":
      "लॉगिन स्क्रीन पर 'पासवर्ड भूल गए?' विकल्प चुनें और निर्देशों का पालन करें।",

  "faq_q2": "दो-स्तरीय प्रमाणीकरण कैसे सक्षम करें?",
  "faq_a2":
      "सेटिंग्स > सुरक्षा में जाकर दो-स्तरीय प्रमाणीकरण को सक्रिय करें।",

  "faq_q3": "ऐप अनुमतियाँ कैसे प्रबंधित करें?",
  "faq_a3":
      "आप अपने डिवाइस की सेटिंग्स से ऐप अनुमतियों को कभी भी बदल सकते हैं।",

  "faq_q4": "ऐप लॉक कैसे सेट करें?",
  "faq_a4":
      "सुरक्षा अनुभाग से PIN, पैटर्न या बायोमेट्रिक द्वारा ऐप लॉक सक्षम करें।",

  "faq_q5": "मैं ग्राहक सहायता से कैसे संपर्क कर सकता हूँ?",
  "faq_a5":
      "ऐप के सहायता और समर्थन अनुभाग से ग्राहक सहायता से संपर्क करें।",

  "faq_q6": "क्या मेरा डेटा सुरक्षित है?",
  "faq_a6":
      "हाँ, आपका डेटा उद्योग-मानक सुरक्षा उपायों द्वारा सुरक्षित है।",

  "faq_q7": "मैं अपना खाता कैसे हटाऊँ?",
  "faq_a7":
      "सेटिंग्स > खाता > खाता हटाएँ से आप अपना खाता स्थायी रूप से हटा सकते हैं।",
};
