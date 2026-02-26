import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last updated: January 20, 2026',
              style: TextStyle(
                fontSize: 14 * scale,
                color: Colors.grey[600],
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20 * scale),
            _buildSection(
              '1. Information We Collect',
              'We collect information you provide directly to us including your name, email address, and any other information you choose to provide when using our services.',
              scale,
            ),
            _buildSection(
              '2. How We Use Your Information',
              'We use the information we collect to provide, maintain, and improve our services, to communicate with you, and to protect our users.',
              scale,
            ),
            _buildSection(
              '3. Information Sharing',
              'We do not share your personal information with third parties except as described in this privacy policy or with your consent.',
              scale,
            ),
            _buildSection(
              '4. Data Security',
              'We take reasonable measures to help protect your personal information from loss, theft, misuse, unauthorized access, disclosure, alteration, and destruction.',
              scale,
            ),
            _buildSection(
              '5. Your Rights',
              'You have the right to access, update, or delete your personal information at any time. You can do this through your account settings or by contacting us directly.',
              scale,
            ),
            _buildSection(
              '6. Contact Us',
              'If you have any questions about this Privacy Policy, please contact us at privacy@example.com',
              scale,
            ),
            SizedBox(height: 20 * scale),
            Container(
              padding: EdgeInsets.all(16.0 * scale),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD).withOpacity(0.5),
                borderRadius: BorderRadius.circular(12 * scale),
                border: Border.all(color: Colors.blue.withOpacity(0.1)),
              ),
              child: Text(
                'By using our services, you agree to the collection and use of information in accordance with this Privacy Policy.',
                style: TextStyle(
                  fontSize: 13 * scale,
                  color: const Color(0xFF1E2E5D),
                  fontFamily: 'Nunito',
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 30 * scale),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0 * scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 8 * scale),
          Text(
            content,
            style: TextStyle(
              fontSize: 14 * scale,
              color: Colors.grey[700],
              fontFamily: 'Nunito',
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
