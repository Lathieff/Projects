import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';

class ActiveDevicesScreen extends StatelessWidget {
  const ActiveDevicesScreen({super.key});

  String _t(BuildContext context, String key) {
    final lang =
        context.watch<LanguageProvider>().locale.languageCode;

    switch (lang) {
      case 'ta':
        return _activeTa[key] ?? _activeEn[key] ?? key;
      case 'hi':
        return _activeHi[key] ?? _activeEn[key] ?? key;
      default:
        return _activeEn[key] ?? key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _t(context, 'active_devices'),
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
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF5395FD),
                Color(0xFF00AA5B),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// Subtitle
            Text(
              _t(context, 'active_subtitle'),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            _deviceCard(
              context,
              icon: Icons.phone_iphone,
              deviceName: 'iPhone 13 Pro',
              location: 'New York, USA',
              lastActive: '2 minutes ago',
              isCurrent: true,
            ),

            const SizedBox(height: 16),

            _deviceCard(
              context,
              icon: Icons.laptop_mac,
              deviceName: 'MacBook Pro',
              location: 'New York, USA',
              lastActive: '1 hour ago',
              isCurrent: false,
            ),

            const SizedBox(height: 30),

            /// Logout Button
            Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(
                child: Text(
                  _t(context, 'logout_all'),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  /// Device Card
  Widget _deviceCard(
    BuildContext context, {
    required IconData icon,
    required String deviceName,
    required String location,
    required String lastActive,
    required bool isCurrent,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF2979FF)),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      deviceName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _t(context, 'current'),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_t(context, 'last_active')} $lastActive',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          if (!isCurrent)
            Text(
              _t(context, 'remove'),
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

const Map<String, String> _activeEn = {
  "active_devices": "Active Devices",
  "active_subtitle": "Manage devices that have access to your account",
  "current": "Current",
  "remove": "Remove",
  "logout_all": "Log Out All Other Devices",
  "last_active": "Last active:",
};

const Map<String, String> _activeTa = {
  "active_devices": "செயலில் உள்ள சாதனங்கள்",
  "active_subtitle":
      "உங்கள் கணக்கிற்கு அணுகல் உள்ள சாதனங்களை நிர்வகிக்கவும்",
  "current": "தற்போது",
  "remove": "அகற்று",
  "logout_all": "மற்ற அனைத்து சாதனங்களிலிருந்தும் வெளியேறு",
  "last_active": "கடைசியாக செயல்பட்டது:",
};

const Map<String, String> _activeHi = {
  "active_devices": "सक्रिय डिवाइस",
  "active_subtitle":
      "उन डिवाइसों को प्रबंधित करें जिन्हें आपके खाते की पहुँच है",
  "current": "वर्तमान",
  "remove": "हटाएँ",
  "logout_all": "अन्य सभी डिवाइस से लॉग आउट करें",
  "last_active": "अंतिम सक्रिय:",
};
