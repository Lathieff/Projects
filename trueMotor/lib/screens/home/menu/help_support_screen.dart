import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  HelpSupportScreen
// ─────────────────────────────────────────────
class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  static const _green  = Color(0xFF2E7D52);
  static const _purple = Color(0xFF7B3FA0);

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq       = MediaQuery.of(context);
    final double w = mq.size.width;
    final double h = mq.size.height;

    final double wp = w / 390;
    final double hp = h / 844;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
        // ── resizeToAvoidBottomInset false → keyboard push avoid ──
        resizeToAvoidBottomInset: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── AppBar ──────────────────────────────────────
            Container(
              width:   w,
              height:  56 * hp,
              color:   const Color(0xFFF5F5F5),
              padding: EdgeInsets.symmetric(horizontal: 16 * wp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: _green,
                      size:  24 * wp,
                    ),
                  ),
                  SizedBox(width: 12 * wp),
                  Text(
                    'Help & Support',
                    style: TextStyle(
                      color:      _green,
                      fontSize:   20 * wp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ── Divider below AppBar ────────────────────────
            const Divider(
              height:    1,
              thickness: 1,
              color:     Color(0xFFDDDDDD),
            ),

            // ── Body (NO scroll) ────────────────────────────
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * wp,
                  vertical:   20 * hp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Heading ──────────────────────────────
                    Text(
                      'Help & Support – True Motors',
                      style: TextStyle(
                        fontSize:   15 * wp,
                        fontWeight: FontWeight.w800,
                        color:      const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 6 * hp),

                    // ── Intro text ───────────────────────────
                    Text(
                      "We're here to help you every step of the way. Got questions, issues, or feedback?\nFind answers quickly or connect with our support team for personalized assistance.",
                      style: TextStyle(
                        fontSize: 14 * wp,
                        color:    const Color(0xFF1A1A1A),
                        height:   1.55,
                      ),
                    ),
                    SizedBox(height: 14 * hp),

                    // ── Call Us Directly ─────────────────────
                    Text(
                      'Call Us Directly',
                      style: TextStyle(
                        fontSize:   14 * wp,
                        fontWeight: FontWeight.w700,
                        color:      const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 6 * hp),

                    _BulletItem(
                      text: 'Speak with our customer care team for urgent help.',
                      wp:   wp,
                      hp:   hp,
                    ),
                    _BulletItem(
                      text:     'Customer Support: +91-90873-90873',
                      wp:       wp,
                      hp:       hp,
                      leadIcon: Icons.phone,
                    ),
                    _BulletItem(
                      text: 'Available 9 AM – 9 PM IST',
                      wp:   wp,
                      hp:   hp,
                    ),

                    SizedBox(height: 14 * hp),

                    // ── Email Support ────────────────────────
                    Text(
                      'Email Support',
                      style: TextStyle(
                        fontSize:   14 * wp,
                        fontWeight: FontWeight.w500,
                        color:      const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 6 * hp),

                    _BulletItem(
                      text: 'For detailed queries or document submissions.',
                      wp:   wp,
                      hp:   hp,
                    ),
                    _BulletItem(
                      text:           'support@truemotors.com',
                      wp:             wp,
                      hp:             hp,
                      leadEmojiAsset: '📧',
                    ),

                    SizedBox(height: 14 * hp),

                    // ── Feedback & Suggestions ───────────────
                    Text(
                      'Feedback & Suggestions',
                      style: TextStyle(
                        fontSize:   14 * wp,
                        fontWeight: FontWeight.w500,
                        color:      const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 4 * hp),
                    Text(
                      'Share your feedback to help us improve your TrueMotors experience.',
                      style: TextStyle(
                        fontSize: 14 * wp,
                        color:    const Color(0xFF1A1A1A),
                        height:   1.5,
                      ),
                    ),
                    SizedBox(height: 12 * hp),

                    // ── Feedback TextArea ────────────────────
                    Expanded(
                      child: Container(
                        width:  w - 40 * wp,
                        decoration: BoxDecoration(
                          color:        Colors.white,
                          borderRadius: BorderRadius.circular(10 * wp),
                          border: Border.all(
                            color: const Color(0xFF1A1A1A),
                            width: 1.2,
                          ),
                        ),
                        child: TextField(
                          controller:        _feedbackController,
                          maxLines:          null,
                          expands:           true,
                          textAlignVertical: TextAlignVertical.top,
                          style: TextStyle(
                            fontSize: 14 * wp,
                            color:    const Color(0xFF1A1A1A),
                          ),
                          decoration: InputDecoration(
                            border:         InputBorder.none,
                            contentPadding: EdgeInsets.all(12 * wp),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16 * hp),

                    // ── Submit Button ─────────────────────────
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // submit feedback
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _purple,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24 * wp,
                            vertical:   14 * hp,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8 * wp),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Submit a Feedback',
                          style: TextStyle(
                            fontSize:   14 * wp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20 * hp),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}

// ─────────────────────────────────────────────
//  _BulletItem
// ─────────────────────────────────────────────
class _BulletItem extends StatelessWidget {
  final String    text;
  final double    wp;
  final double    hp;
  final IconData? leadIcon;
  final String?   leadEmojiAsset;

  const _BulletItem({
    required this.text,
    required this.wp,
    required this.hp,
    this.leadIcon,
    this.leadEmojiAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * hp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Bullet dot ──────────────────────────────────
          Padding(
            padding: EdgeInsets.only(top: 5 * hp, right: 8 * wp),
            child: Container(
              width:  5 * wp,
              height: 5 * wp,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),

          // ── Optional lead icon ───────────────────────────
          if (leadIcon != null) ...[
            Icon(leadIcon, size: 16 * wp, color: const Color(0xFF1A1A1A)),
            SizedBox(width: 4 * wp),
          ],

          // ── Optional emoji ───────────────────────────────
          if (leadEmojiAsset != null) ...[
            Text(leadEmojiAsset!, style: TextStyle(fontSize: 14 * wp)),
            SizedBox(width: 4 * wp),
          ],

          // ── Text ─────────────────────────────────────────
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14 * wp,
                color:    const Color(0xFF1A1A1A),
                height:   1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

