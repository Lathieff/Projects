import 'package:flutter/material.dart';
import 'faq_screen.dart';
import 'about_app_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
          'Help & support',
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
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
            _buildOptionCard(
              iconData: Icons.quiz_outlined,
              title: 'FAQs',
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FaqScreen()),
                );
              },
            ),
            SizedBox(height: 16 * scale),
            _buildOptionCard(
              iconData: Icons.info_outline,
              title: 'About App',
              scale: scale,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutAppScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 30 * scale),
            Text(
              'Call Us Directly',
              style: TextStyle(
                fontSize: 18 * scale,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 12 * scale),
            _buildBulletPoint(
              'Speak with our customer care team for urgent help.',
              scale,
            ),
            SizedBox(height: 8 * scale),
            _buildBulletPoint(
              'Customer Support: +91-90873-90873',
              scale,
              leadingIcon: Icon(
                Icons.phone,
                color: Colors.black,
                size: 20 * scale,
              ),
            ),
            SizedBox(height: 8 * scale),
            _buildBulletPoint('Available 9 AM – 9 PM IST', scale),
            SizedBox(height: 18 * scale),
            Text(
              'Email Support',
              style: TextStyle(
                fontSize: 16 * scale,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: 'Nunito',
              ),
            ),
            SizedBox(height: 12 * scale),
            _buildBulletPoint(
              'For detailed queries or document submissions.',
              scale,
            ),
            SizedBox(height: 8 * scale),
            _buildBulletPoint(
              'support@smartscore.com',
              scale,
              leadingIcon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF5395FD),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData iconData,
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
          child: Icon(
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

  Widget _buildBulletPoint(String text, double scale, {Widget? leadingIcon}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 4),
          Text(
            '• ',
            style: TextStyle(fontSize: 14 * scale, color: Colors.black),
          ),
          if (leadingIcon != null) ...[leadingIcon, SizedBox(width: 8 * scale)],
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15 * scale,
                color: Colors.black,
                fontFamily: 'Nunito',
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
