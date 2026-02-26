import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool cameraEnabled = true;
  bool microphoneEnabled = true;
  bool locationEnabled = true;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Permissions",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF1DB954), Color(0xFF2672F5)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Manage app permissions for enhanced privacy and security.",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 24),
            _buildPermissionTile(
              "Camera",
              "assets/icon/permission/camera_logo.png",
              cameraEnabled,
              (val) => setState(() => cameraEnabled = val),
            ),
            _buildPermissionTile(
              "Microphone",
              "assets/icon/permission/micro_logo.png",
              microphoneEnabled,
              (val) => setState(() => microphoneEnabled = val),
            ),
            _buildPermissionTile(
              "Location",
              "assets/icon/permission/location_logo.png",
              locationEnabled,
              (val) => setState(() => locationEnabled = val),
            ),
            _buildPermissionTile(
              "Notifications",
              "assets/icon/permission/notification_logo.png",
              notificationsEnabled,
              (val) => setState(() => notificationsEnabled = val),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionTile(
    String title,
    String iconPath,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2672F5).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(iconPath, color: const Color(0xFF2672F5)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            CupertinoSwitch(
              value: value,
              activeColor: const Color(0xFF2672F5),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
