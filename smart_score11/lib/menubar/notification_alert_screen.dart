import 'package:flutter/material.dart';

class NotificationAlertScreen extends StatefulWidget {
  const NotificationAlertScreen({super.key});

  @override
  State<NotificationAlertScreen> createState() =>
      _NotificationAlertScreenState();
}

class _NotificationAlertScreenState extends State<NotificationAlertScreen> {
  bool creditCheckAlerts = true;
  bool paymentRechargeAlerts = true;
  bool lowBalanceAlerts = true;
  bool systemUpdates = true;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        toolbarHeight: 70 * scale,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification & Alert',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20 * scale,
            fontFamily: 'Nunito',
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notification & Alerts',
              style: TextStyle(
                fontSize: 20 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 25 * scale),
            _buildSettingCard(
              'Credit Check Alerts',
              creditCheckAlerts,
              (val) => setState(() => creditCheckAlerts = val),
              scale,
              hasCheck: true,
            ),
            SizedBox(height: 16 * scale),
            _buildSettingCard(
              'Payment & Recharge Alerts',
              paymentRechargeAlerts,
              (val) => setState(() => paymentRechargeAlerts = val),
              scale,
              hasCheck: true,
            ),
            SizedBox(height: 16 * scale),
            _buildSettingCard(
              'Low Balance Alerts',
              lowBalanceAlerts,
              (val) => setState(() => lowBalanceAlerts = val),
              scale,
              hasCheck: false,
            ),
            SizedBox(height: 16 * scale),
            _buildSettingCard(
              'System Updates',
              systemUpdates,
              (val) => setState(() => systemUpdates = val),
              scale,
              hasCheck: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    String title,
    bool value,
    Function(bool) onChanged,
    double scale, {
    required bool hasCheck,
  }) {
    return Container(
      height: 60 * scale,
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10 * scale,
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
              fontSize: 16 * scale,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF333333),
              fontFamily: 'Nunito',
            ),
          ),
          Transform.scale(
            scale: scale,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: const Color(0xFF4285F4),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected) && hasCheck) {
                  return const Color(
                    0xFFCEDCFE,
                  ); // Light blue thumb for first two
                }
                return Colors.white;
              }),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              thumbIcon: hasCheck && value
                  ? WidgetStateProperty.all(
                      const Icon(
                        Icons.check,
                        color: Color(0xFF4285F4),
                        size: 20,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
