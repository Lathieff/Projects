import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/HomeScreen/help_screen.dart';
import '/HomeScreen/language_screen.dart';
import '/HomeScreen/notification_alert_screen.dart';
import '/HomeScreen/privacy_screen.dart';
import '/HomeScreen/profile_basic_details_screen.dart';
import '/HomeScreen/transaction_screen.dart';
import '/OnboardingScreen/mobile_login_screen.dart';
import '../../../controllers/language_provider.dart';
import '/app_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = context.watch<LanguageProvider>().locale.languageCode;

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
        backgroundColor: const Color(0xFF2E6FF2),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: sp(0.055), color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER CURVE =================
            Container(
              height: h(0.12),
              decoration: const BoxDecoration(
                color: Color(0xFF2E6FF2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            // ================= PROFILE IMAGE =================
            Transform.translate(
              offset: Offset(0, -h(0.06)),
              child: Column(
                children: [
                  Container(
                    height: h(0.14),
                    width: h(0.14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 0.1),
                      image: const DecorationImage(
                        image: AssetImage(AppImage.profile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.015)),

                  // ================= NAME + KYC =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Akhil",
                        style: TextStyle(
                          fontSize: sp(0.045),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: w(0.02)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w(0.025),
                          vertical: h(0.005),
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 8, 141, 37),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              t("kyc_verified"),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.008)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        t("location"),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.03)),

                  // ================= MENU CARD =================
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: w(0.05)),
                    padding: EdgeInsets.symmetric(vertical: h(0.015)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _menuItem(
                          context,
                          Icons.person,
                          t("personal_info"),
                          const ProfileBasicDetailsScreen(),
                        ),
                        _menuItem(
                          context,
                          Icons.receipt_long,
                          t("transaction"),
                          const TransactionScreen(),
                        ),
                        _menuItem(
                          context,
                          Icons.notifications,
                          t("notification"),
                          const NotificationAlertScreen(),
                        ),
                        _menuItem(
                          context,
                          Icons.help_outline,
                          t("help_support"),
                          const HelpSupportScreen(),
                        ),
                        _menuItem(
                          context,
                          Icons.language,
                          t("language"),
                          const LanguageScreen(),
                        ),
                        _menuItem(
                          context,
                          Icons.security,
                          t("privacy_security"),
                          const PrivacySecurityScreen(),
                        ),
                        _logoutItem(context, t),
                      ],
                    ),
                  ),

                  SizedBox(height: h(0.05)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= MENU ITEM =================
  Widget _menuItem(
    BuildContext context,
    IconData icon,
    String title,
    Widget screen,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF2E6FF2),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_circle_right_outlined,
        color: Colors.blueAccent,
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      },
    );
  }

  // ================= LOGOUT ITEM =================
  Widget _logoutItem(
      BuildContext context, String Function(String) t) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFF2E6FF2),
        child: Icon(Icons.logout, color: Colors.white, size: 20),
      ),
      title: Text(
        t("logout"),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_circle_right_outlined,
        color: Colors.blueAccent,
      ),
      onTap: () {
        _showLogoutDialog(context, t);
      },
    );
  }

  // ================= LOGOUT POPUP =================
  void _showLogoutDialog(
      BuildContext context, String Function(String) t) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(t("logout")),
          content: Text(t("logout_confirm")),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(t("cancel")),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Text(t("logout")),
            ),
          ],
        );
      },
    );
  }
}

/* ================= LANGUAGE MAPS ================= */

// English
const Map<String, String> _en = {
  "kyc_verified": "KYC Verified",
  "location": "Chennai, Tamilnadu.",
  "personal_info": "Personal Information",
  "transaction": "Transaction",
  "notification": "Notification Setting",
  "help_support": "Help & Support",
  "language": "Language",
  "privacy_security": "Privacy & Security",
  "logout": "Logout",
  "logout_confirm": "Are you sure you want to logout?",
  "cancel": "Cancel",
};

// Tamil
const Map<String, String> _ta = {
  "kyc_verified": "KYC சரிபார்க்கப்பட்டது",
  "location": "சென்னை, தமிழ்நாடு.",
  "personal_info": "தனிப்பட்ட தகவல்",
  "transaction": "பரிவர்த்தனை",
  "notification": "அறிவிப்பு அமைப்பு",
  "help_support": "உதவி & ஆதரவு",
  "language": "மொழி",
  "privacy_security": "தனியுரிமை & பாதுகாப்பு",
  "logout": "வெளியேறு",
  "logout_confirm": "நீங்கள் வெளியேற விரும்புகிறீர்களா?",
  "cancel": "ரத்து",
};

// Hindi
const Map<String, String> _hi = {
  "kyc_verified": "केवाईसी सत्यापित",
  "location": "चेन्नई, तमिलनाडु",
  "personal_info": "व्यक्तिगत जानकारी",
  "transaction": "लेन-देन",
  "notification": "सूचना सेटिंग",
  "help_support": "सहायता और समर्थन",
  "language": "भाषा",
  "privacy_security": "गोपनीयता और सुरक्षा",
  "logout": "लॉगआउट",
  "logout_confirm": "क्या आप लॉगआउट करना चाहते हैं?",
  "cancel": "रद्द करें",
};
