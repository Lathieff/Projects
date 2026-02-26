import 'package:flutter/material.dart';
import 'package:smart_score/menubar/app_lock.dart';
import 'privacy_policy_screen.dart';
import 'two_factor_auth_screen.dart';
import 'active_devices_screen.dart';
import 'permission_screen.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

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
        centerTitle: false,
        title: Text(
          'Privacy & Security',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0 * scale),
        child: Column(
          children: [
            _buildOptionCard(
              assetPath: 'assets/icon/permission.png',
              title: 'Permissions',
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PermissionScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16 * scale),
            _buildOptionCard(
              assetPath: 'assets/icon/twofac.png',
              title: 'Two Factor Authentications',
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TwoFactorAuthScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16 * scale),
            _buildOptionCard(
              assetPath: 'assets/icon/applock.png',
              title: 'App Lock',
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AppLock()),
                );
              },
            ),
            SizedBox(height: 16 * scale),
            _buildOptionCard(
              assetPath: 'assets/icon/active_device.png',
              title: 'Active Devices',
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActiveDevicesScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 16 * scale),
            _buildOptionCard(
              assetPath: 'assets/icon/privacy_polices.png',
              title: "Privacy Policy's",
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    IconData? iconData,
    String? assetPath,
    required String title,
    required double scale,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 4 * scale,
        ),
        leading: Container(
          padding: EdgeInsets.all(8 * scale),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(10 * scale),
          ),
          child: assetPath != null
              ? Image.asset(
                  assetPath,
                  width: 24 * scale,
                  height: 24 * scale,
                  color: const Color(0xFF2196F3),
                )
              : Icon(
                  iconData,
                  color: const Color(0xFF2196F3),
                  size: 24 * scale,
                ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'Nunito',
          ),
        ),
        trailing: Icon(
          Icons.play_arrow,
          color: const Color(0xFF2196F3),
          size: 16 * scale,
        ),
        onTap: onTap,
      ),
    );
  }
}
