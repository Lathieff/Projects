import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70 * scale,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: Text(
          'About App',
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
        padding: EdgeInsets.symmetric(
          horizontal: 24.0 * scale,
          vertical: 40 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo Container
            Center(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24 * scale,
                      vertical: 12 * scale,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF0EA9E2),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset(
                      'assets/images/smart_score.png',
                      width: 150 * scale,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 16 * scale),
                  Text(
                    'Version 2.4.1',
                    style: TextStyle(
                      fontSize: 14 * scale,
                      color: Colors.grey[600],
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32 * scale),

            // About Section
            Text(
              'About',
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 12 * scale),
            Text(
              'SmartScore is your comprehensive privacy and security management application. We help you take control of your digital security with features like two-factor authentication, device management, app lock, and detailed permission controls.',
              style: TextStyle(
                fontSize: 14 * scale,
                color: Colors.grey[700],
                fontFamily: 'Nunito',
                height: 1.5,
              ),
            ),
            SizedBox(height: 24 * scale),

            // Mission Section
            Text(
              'Mission',
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 12 * scale),
            Text(
              'Our mission is to empower users with easy-to-use security tools that protect their privacy without compromising usability.',
              style: TextStyle(
                fontSize: 14 * scale,
                color: Colors.grey[700],
                fontFamily: 'Nunito',
                height: 1.5,
              ),
            ),
            SizedBox(height: 48 * scale),

            // Legal Section
            Text(
              'Legal',
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 16 * scale),
            _buildLegalLink('Privacy Policy', scale, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicyScreen(),
                ),
              );
            }),
            _buildLegalLink('Terms of Service', scale, () {}),
            _buildLegalLink('Licenses', scale, () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalLink(String text, double scale, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0 * scale),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15 * scale,
            color: const Color(0xFF2979FF),
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
