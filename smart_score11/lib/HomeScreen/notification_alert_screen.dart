import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';

class NotificationAlertScreen extends StatefulWidget {
  const NotificationAlertScreen({super.key});

  @override
  State<NotificationAlertScreen> createState() =>
      _NotificationAlertScreenState();
}

class _NotificationAlertScreenState extends State<NotificationAlertScreen> {
  bool creditCheck = true;
  bool paymentAlert = true;
  bool lowBalance = false;
  bool systemUpdate = false;

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
          icon: Icon(Icons.arrow_back, size: sp(0.065),
          color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t("Notification & Alert"),
          style: TextStyle(
            fontSize: sp(0.060),
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
            Text(
              t("Notification & Alert"),
              style: TextStyle(
                fontSize: sp(0.06),
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: h(0.02)),

            _alertTile(
              title: t("Credit Check Alerts"),
              value: creditCheck,
              onChanged: (v) => setState(() => creditCheck = v),
              sp: sp,
              w: w,
              h: h,
            ),

            _alertTile(
              title: t("Payment & Recharge Alerts"),
              value: paymentAlert,
              onChanged: (v) => setState(() => paymentAlert = v),
              sp: sp,
              w: w,
              h: h,
            ),

            _alertTile(
              title: t("Low Balance Alerts"),
              value: lowBalance,
              onChanged: (v) => setState(() => lowBalance = v),
              sp: sp,
              w: w,
              h: h,
            ),

            _alertTile(
              title: t("System Updates"),
              value: systemUpdate,
              onChanged: (v) => setState(() => systemUpdate = v),
              sp: sp,
              w: w,
              h: h,
            ),
          ],
        ),
      ),
    );
  }

  // ================= ALERT TILE =================
  Widget _alertTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required double Function(double) sp,
    required double Function(double) w,
    required double Function(double) h,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: h(0.018)),
      padding: EdgeInsets.symmetric(
        horizontal: w(0.04),
        vertical: h(0.018),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: sp(0.035),
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF2E6FF2),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}

const Map<String, String> _en = {
    'Notification & Alert': 'Notification & Alert',
    'Credit Check Alerts': 'Credit Check Alerts',
    'Payment & Recharge Alerts': 'Payment & Recharge Alerts',
    'Low Balance Alerts': 'Low Balance Alerts',
    'System Updates': 'System Updates',
};

const Map<String, String> _ta = {
  'Notification & Alert': 'அறிவிப்பு & எச்சரிக்கை',
  'Credit Check Alerts': 'கடன் சரிபார்ப்பு அறிவிப்புகள்',
  'Payment & Recharge Alerts': 'கட்டணம் & ரீசார்ஜ் அறிவிப்புகள்',
  'Low Balance Alerts': 'குறைந்த இருப்பு அறிவிப்புகள்',
  'System Updates': 'கணினி மேம்பாடுகள்',
};

const Map<String, String> _hi = {
  'Notification & Alert': 'सूचना और अलर्ट',
  'Credit Check Alerts': 'क्रेडिट चेक अलर्ट',
  'Payment & Recharge Alerts': 'भुगतान और रिचार्ज अलर्ट',
  'Low Balance Alerts': 'कम बैलेंस अलर्ट',
  'System Updates': 'सिस्टम अपडेट',
};
