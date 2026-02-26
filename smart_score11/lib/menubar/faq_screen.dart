import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'How do I reset my password ?',
      answer:
          'To reset your password, go to the login screen, tap on "Forgot Password", and follow the instructions sent to your registered email or mobile number.',
    ),
    FAQItem(
      question: 'How do I enable two factor authentication?',
      answer:
          'You can enable two-factor authentication in the Privacy & Security settings by tapping on "Two Factor Authentications" and following the setup process.',
    ),
    FAQItem(
      question: 'How can I manage app permission ?',
      answer:
          'App permissions can be managed from the Privacy & Security screen under the "Permissions" section or directly from your device system settings.',
    ),
    FAQItem(
      question: 'How do I set up App lock ?',
      answer:
          'Go to Privacy & Security settings, select "App Lock", and choose your preferred locking method (PIN, Pattern, or Biometric).',
    ),
    FAQItem(
      question: 'How can I contact customer support ?',
      answer:
          'You can contact customer support directly from the Help & Support screen via the provided phone number or email address.',
    ),
    FAQItem(
      question: 'Is my data secure ?',
      answer:
          'Yes, we take reasonable measures to protect your personal information from unauthorized access, as detailed in our Privacy Policy.',
    ),
    FAQItem(
      question: 'How do I delete my account ?',
      answer:
          'To delete your account, please contact our support team at support@smartscore.com with your request.',
    ),
  ];

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
          'FAQs',
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
      body: ListView.builder(
        padding: EdgeInsets.all(20.0 * scale),
        itemCount: _faqItems.length,
        itemBuilder: (context, index) {
          return _buildFAQCard(_faqItems[index], scale);
        },
      ),
    );
  }

  Widget _buildFAQCard(FAQItem item, double scale) {
    return Container(
      margin: EdgeInsets.only(bottom: 12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            item.question,
            style: TextStyle(
              fontSize: 15 * scale,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Nunito',
            ),
          ),
          trailing: Icon(
            Icons.arrow_drop_down,
            color: const Color(0xFF2196F3),
            size: 24 * scale,
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 16 * scale,
                right: 16 * scale,
                bottom: 16 * scale,
              ),
              child: Text(
                item.answer,
                style: TextStyle(
                  fontSize: 14 * scale,
                  color: Colors.grey[700],
                  fontFamily: 'Nunito',
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
