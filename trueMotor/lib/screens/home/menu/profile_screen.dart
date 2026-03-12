import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



// ─────────────────────────────────────────────
//  ProfileScreen
// ─────────────────────────────────────────────
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _green = Color(0xFF2E7D52);

  @override
  Widget build(BuildContext context) {
    final mq          = MediaQuery.of(context);
    final double w    = mq.size.width;
    final double h    = mq.size.height;

    // Responsive spacing helpers
    final double hp   = h / 844;   // scale relative to ~standard height
    final double wp   = w / 390;   // scale relative to ~standard width

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── AppBar ──────────────────────────────────────
            Container(
              width: w,
              height: 56 * hp,
              color: const Color(0xFFFBF8F8),
              padding: EdgeInsets.symmetric(horizontal: 16 * wp),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: _green,
                      size: 24 * wp,
                    ),
                  ),
                  SizedBox(width: 12 * wp),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: _green,
                      fontSize: 20 * wp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * wp,
                  vertical: 20 * hp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Profile Information',
                      style: TextStyle(
                        fontSize: 20 * wp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 20 * hp),

                    // ── Card ──────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20 * wp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12 * wp),
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card header row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Basic Details',
                                style: TextStyle(
                                  fontSize: 15 * wp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A1A),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {/* edit action */},
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      color: _green,
                                      size: 18 * wp,
                                    ),
                                    SizedBox(width: 4 * wp),
                                    Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: _green,
                                        fontSize: 14 * wp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20 * hp),
                          _InfoRow(label: 'Name',          value: 'Harish',                  wp: wp, hp: hp),
                          _InfoRow(label: 'Mail Id',       value: 'hariharansgs@app.in',     wp: wp, hp: hp),
                          _InfoRow(label: 'Mobile Number', value: '+91 98765 43210',          wp: wp, hp: hp),
                          _InfoRow(label: 'Address',       value: 'Coimbatore', isLast: true, wp: wp, hp: hp),
                        ],
                      ),
                    ),
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
//  _InfoRow  – label + value row inside card
// ─────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool   isLast;
  final double wp;
  final double hp;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.wp,
    required this.hp,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label – fixed width for alignment
            SizedBox(
              width: 140 * wp,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14 * wp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF5C5C5C),
                ),
              ),
            ),
            // Value
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14 * wp,
                  color: const Color(0xFF3D3D3D),
                ),
              ),
            ),
          ],
        ),
        if (!isLast) SizedBox(height: 18 * hp),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Entry point (for standalone testing)
// ─────────────────────────────────────────────
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    ),
  );
}

