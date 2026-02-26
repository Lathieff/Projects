import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';
import '../HomeScreen/twofactor_screen.dart';
import '../HomeScreen/activedevice_screen.dart';
import '../HomeScreen/policy_screen.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final lang = context.watch<LanguageProvider>().locale.languageCode;

    // Responsive helpers
    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    // 🔹 Language text resolver (NO app_strings.dart)
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
          icon: Icon(Icons.arrow_back, size: sp(0.060), color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t("privacy_security"),
          style: TextStyle(
            fontSize: sp(0.065),
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E6FF2), Color(0xFF2BB673)],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: EdgeInsets.all(w(0.05)),
        child: Column(
          children: [
            _optionTile(
              icon: Icons.check_circle_outline,
              title: t("permissions"),
              sp: sp,
              w: w,
              h: h,
              onTap: () {},
            ),

            _optionTile(
              icon: Icons.key,
              title: t("two_factor"),
              sp: sp,
              w: w,
              h: h,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TwoFactorAuthScreen(),
                  ),
                );
              },
            ),

            _optionTile(
              icon: Icons.devices,
              title: t("active_devices"),
              sp: sp,
              w: w,
              h: h,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ActiveDevicesScreen(),
                  ),
                );
              },
            ),

            _optionTile(
              icon: Icons.privacy_tip_outlined,
              title: t("privacy_policy"),
              sp: sp,
              w: w,
              h: h,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ================= OPTION TILE =================
  Widget _optionTile({
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
        margin: EdgeInsets.only(bottom: h(0.02)),
        padding: EdgeInsets.symmetric(horizontal: w(0.04), vertical: h(0.02)),
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
              child: Icon(icon, size: sp(0.045), color: Colors.blue),
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

            Icon(Icons.chevron_right, size: sp(0.05), color: Colors.blue),
          ],
        ),
      ),
    );
  }
}

/* ================= LANGUAGE MAPS ================= */

// English
const Map<String, String> _en = {
  "privacy_security": "Privacy & Security",
  "permissions": "Permissions",
  "two_factor": "Two Factor Authentication",
  "app_lock": "App Lock",
  "active_devices": "Active Devices",
  "privacy_policy": "Privacy Policy’s",
};

// Tamil
const Map<String, String> _ta = {
  "privacy_security": "தனியுரிமை & பாதுகாப்பு",
  "permissions": "அனுமதிகள்",
  "two_factor": "இரு நிலை அங்கீகாரம்",
  "app_lock": "ஆப் பூட்டு",
  "active_devices": "செயலில் உள்ள சாதனங்கள்",
  "privacy_policy": "தனியுரிமைக் கொள்கை",
};

// Hindi
const Map<String, String> _hi = {
  "privacy_security": "गोपनीयता और सुरक्षा",
  "permissions": "अनुमतियाँ",
  "two_factor": "दो-स्तरीय प्रमाणीकरण",
  "app_lock": "ऐप लॉक",
  "active_devices": "सक्रिय डिवाइस",
  "privacy_policy": "गोपनीयता नीति",
};
