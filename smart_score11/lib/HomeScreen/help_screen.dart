import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';
import '../HomeScreen/faqs_screen.dart';
import '../HomeScreen/about_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = context.watch<LanguageProvider>().locale.languageCode;

    // Responsive helpers
    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

        // 🔹 Local language resolver (NO app_strings.dart)
    String t(String key) {
      switch (lang) {
        case 'ta':
          return _ta[key] ?? key;
        case 'hi':
          return _hi[key] ?? key;
        default:
          return _en[key] ?? key;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: sp(0.060),
          color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t("Help & Support"),
          style: TextStyle(
            fontSize: sp(0.060),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w(0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= FAQ CARD =================
            _menuCard(
              context,
              icon: Icons.help_center,
              title: t("FAQs"),
              sp: sp,
              w: w,
              h: h,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FaqScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: h(0.02)),

            // ================= ABOUT APP CARD =================
            _menuCard(
              context,
              icon: Icons.info_outline,
              title: t("About App"),
              sp: sp,
              w: w,
              h: h,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutAppScreen(),
                  ),
                );
              },
            ),

            SizedBox(height: h(0.04)),

            // ================= CALL US =================
            Text(
              t("Call Us Directly"),
              style: TextStyle(
                fontSize: sp(0.04),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h(0.01)),
            Text(
              t("Call Description"),
              style: TextStyle(
                fontSize: sp(0.032),
                color: Colors.black87,
                height: 1.5,
              ),
            ),

            SizedBox(height: h(0.035)),

            // ================= EMAIL SUPPORT =================
            Text(
              t("Email Support"),
              style: TextStyle(
                fontSize: sp(0.04),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: h(0.01)),
            Text(
              t("Email Description"),
              style: TextStyle(
                fontSize: sp(0.032),
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= MENU CARD =================
  Widget _menuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required double Function(double) sp,
    required double Function(double) w,
    required double Function(double) h,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: w(0.04),
          vertical: h(0.02),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(w(0.025)),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.blue,
                size: sp(0.045),
              ),
            ),
            SizedBox(width: w(0.04)),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: sp(0.035),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: sp(0.05),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= HELP & SUPPORT ================= */

const Map<String, String> _en = {
  'Help & Support': 'Help & Support',
  'FAQs': 'FAQs',
  'About App': 'About App',
  'Call Us Directly': 'Call Us Directly',
  'Call Description':
      '• Speak with our customer care team for urgent help.\n'
      '• Customer Support : +91-90873-90873\n'
      '• Available 9 AM – 9 PM IST',
  'Email Support': 'Email Support',
  'Email Description':
      '• For detailed queries or document submissions.\n'
      '• support@smartscore.com',
};

const Map<String, String> _ta = {
  'Help & Support': 'உதவி & ஆதரவு',
  'FAQs': 'அடிக்கடி கேட்கப்படும் கேள்விகள்',
  'About App': 'ஆப் பற்றி',
  'Call Us Directly': 'நேரடியாக அழைக்கவும்',
  'Call Description':
      '• அவசர உதவிக்காக எங்கள் வாடிக்கையாளர் சேவையை தொடர்பு கொள்ளவும்.\n'
      '• வாடிக்கையாளர் ஆதரவு : +91-90873-90873\n'
      '• காலை 9 முதல் இரவு 9 வரை',
  'Email Support': 'மின்னஞ்சல் ஆதரவு',
  'Email Description':
      '• விரிவான கேள்விகள் அல்லது ஆவணங்களை அனுப்ப.\n'
      '• support@smartscore.com',
};

const Map<String, String> _hi = {
  'Help & Support': 'सहायता और समर्थन',
  'FAQs': 'अक्सर पूछे जाने वाले प्रश्न',
  'About App': 'ऐप के बारे में',
  'Call Us Directly': 'सीधे कॉल करें',
  'Call Description':
      '• त्वरित सहायता के लिए हमारी ग्राहक सेवा टीम से बात करें।\n'
      '• ग्राहक सहायता : +91-90873-90873\n'
      '• सुबह 9 बजे से रात 9 बजे तक',
  'Email Support': 'ईमेल सहायता',
  'Email Description':
      '• विस्तृत प्रश्नों या दस्तावेज़ भेजने के लिए।\n'
      '• support@smartscore.com',
};

