import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';
import '../HomeScreen/policy_screen.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  String _t(BuildContext context, String key) {
    final lang =
        context.watch<LanguageProvider>().locale.languageCode;

    switch (lang) {
      case 'ta':
        return _aboutTa[key] ?? _aboutEn[key] ?? key;
      case 'hi':
        return _aboutHi[key] ?? _aboutEn[key] ?? key;
      default:
        return _aboutEn[key] ?? key;
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
          _t(context, 'about_app'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 84),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      _t(context, 'app_name'),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _t(context, 'version'),
                      style:
                          const TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              Text(
                _t(context, 'about'),
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                _t(context, 'about_desc'),
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 22),

              Text(
                _t(context, 'mission'),
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                _t(context, 'mission_desc'),
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),

              const SizedBox(height: 36),

              Text(
                _t(context, 'legal'),
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              _LegalLink(
                title: _t(context, 'privacy_policy'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              _LegalLink(title: _t(context, 'terms'), onTap: () {}),
              const SizedBox(height: 10),
              _LegalLink(title: _t(context, 'licenses'), onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegalLink extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _LegalLink({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF2563EB),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

const Map<String, String> _aboutEn = {
  "about_app": "About App",
  "about": "About",
  "mission": "Mission",
  "legal": "Legal",
  "privacy_policy": "Privacy Policy",
  "terms": "Terms of Service",
  "licenses": "Licenses",
  "app_name": "SmartScore",
  "version": "Version 2.4.1",
  "about_desc":
      "SmartScore is your comprehensive privacy and security management application. We help you take control of your digital security with features like two-factor authentication, device management, app lock, and detailed permission controls.",
  "mission_desc":
      "Our mission is to empower users with easy-to-use security tools that protect their privacy without compromising usability.",
};

const Map<String, String> _aboutTa = {
  "about_app": "ஆப்பைப் பற்றி",
  "about": "பற்றி",
  "mission": "பணி",
  "legal": "சட்டபூர்வம்",
  "privacy_policy": "தனியுரிமைக் கொள்கை",
  "terms": "சேவை விதிமுறைகள்",
  "licenses": "உரிமங்கள்",
  "app_name": "SmartScore",
  "version": "பதிப்பு 2.4.1",
  "about_desc":
      "SmartScore என்பது உங்கள் தனியுரிமை மற்றும் பாதுகாப்பை நிர்வகிக்கும் முழுமையான பயன்பாடாகும். இரு நிலை அங்கீகாரம், சாதன மேலாண்மை, ஆப் பூட்டு மற்றும் அனுமதி கட்டுப்பாடுகள் போன்ற அம்சங்களை வழங்குகிறது.",
  "mission_desc":
      "பயன்பாட்டின் எளிமையை பாதிக்காமல், பயனர்களின் தனியுரிமையை பாதுகாக்க எளிய பாதுகாப்பு கருவிகளை வழங்குவதே எங்கள் பணி.",
};

const Map<String, String> _aboutHi = {
  "about_app": "ऐप के बारे में",
  "about": "परिचय",
  "mission": "मिशन",
  "legal": "कानूनी",
  "privacy_policy": "गोपनीयता नीति",
  "terms": "सेवा की शर्तें",
  "licenses": "लाइसेंस",
  "app_name": "SmartScore",
  "version": "संस्करण 2.4.1",
  "about_desc":
      "SmartScore एक व्यापक गोपनीयता और सुरक्षा प्रबंधन ऐप है। यह दो-स्तरीय प्रमाणीकरण, डिवाइस प्रबंधन, ऐप लॉक और अनुमति नियंत्रण जैसी सुविधाएँ प्रदान करता है।",
  "mission_desc":
      "हमारा मिशन उपयोग में सरल सुरक्षा टूल्स के माध्यम से उपयोगकर्ताओं की गोपनीयता की रक्षा करना है।",
};
