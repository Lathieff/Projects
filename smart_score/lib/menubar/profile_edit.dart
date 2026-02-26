import 'package:flutter/material.dart';

// ── COLORS ──────────────────────────────────────────────
const Color kPrimaryBlue = Color(0xFF3D7BF4);
const Color kBgGrey = Color(0xFFF5F5F5);
const Color kCardWhite = Colors.white;
const Color kTextDark = Color(0xFF1A1A1A);
const Color kTextGrey = Color(0xFF888888);
const Color kKycGreen = Color(0xFF34C759);
const Color kEditBlue = Color(0xFF3D7BF4);
const Color kLocationRed = Color(0xFFE53935);

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final sw = mq.size.width;
    final sh = mq.size.height;
    final scale = sw / 375;
    final topHeight = sh * 0.22;
    final avatarR = sw * 0.14;

    return Scaffold(
      backgroundColor: kBgGrey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── BLUE TOP SECTION ───────────────────────
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Blue rounded-bottom rectangle
                Container(
                  height: topHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kPrimaryBlue,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(50),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 5,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 28,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── AVATAR overlaps blue bg ────────────
                Positioned(
                  bottom: -(avatarR * 0.9),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: avatarR,
                      backgroundImage: const AssetImage(
                        'assets/images/profile.png',
                      ),
                      backgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 65),
            // SizedBox(height: avatarR * 0.8),

            // ── NAME + FIX 3: KYC VERIFIED BADGE ──────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Akhil',
                  style: TextStyle(
                    fontSize: 20 * scale,
                    fontWeight: FontWeight.w700,
                    color: kTextDark,
                  ),
                ),
                SizedBox(width: 8 * scale),

                // Green KYC Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8 * scale,
                    vertical: 3 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: kKycGreen,
                    borderRadius: BorderRadius.circular(20 * scale),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 14 * scale,
                      ),
                      SizedBox(width: 3 * scale),
                      Text(
                        'KYC Verified',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10 * scale,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 6 * scale),

            // ── LOCATION ──────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on, color: kLocationRed, size: 15 * scale),
                SizedBox(width: 3 * scale),
                Text(
                  'Chennai, Tamilnadu.',
                  style: TextStyle(fontSize: 13 * scale, color: kTextGrey),
                ),
              ],
            ),

            SizedBox(height: 20 * scale),

            // ── BASIC DETAILS CARD ────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 * scale),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16 * scale),
                  // ── FIX 4: EXACT BOX SHADOW ──────────
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * scale,
                  vertical: 14 * scale,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Basic Details',
                          style: TextStyle(
                            fontSize: 15 * scale,
                            fontWeight: FontWeight.w700,
                            color: kTextDark,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit_note_sharp,
                              color: kKycGreen,
                              size: 22 * scale,
                            ),
                            SizedBox(width: 3 * scale),
                            Text(
                              'Edit',
                              style: TextStyle(
                                color: kKycGreen,
                                fontSize: 15 * scale,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 8 * scale),

                    // ── FIX 5: NO DIVIDERS — PLAIN ROWS ──
                    _DetailRow(label: 'Name', value: 'Harish', scale: scale),
                    _DetailRow(
                      label: 'Mail Id',
                      value: 'hariharansgs@app.in',
                      scale: scale,
                    ),
                    _DetailRow(
                      label: 'Mobile Number',
                      value: '+91 98765 43210',
                      scale: scale,
                    ),
                    _DetailRow(
                      label: 'Address',
                      value: 'Coimbatore',
                      scale: scale,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30 * scale),
          ],
        ),
      ),
    );
  }
}

// ── REUSABLE DETAIL ROW — NO DIVIDER ─────────────────────
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final double scale;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9 * scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120 * scale,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13 * scale,
                fontWeight: FontWeight.w500,
                color: kTextDark,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13 * scale, color: kTextGrey),
            ),
          ),
        ],
      ),
    );
  }
}
