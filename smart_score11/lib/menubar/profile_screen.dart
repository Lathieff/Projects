import 'package:flutter/material.dart';
import 'package:smart_score/OnboardingScreen/username_login.dart';
import 'package:smart_score/menubar/help_support_screen.dart';
import 'package:smart_score/menubar/language_screen.dart';
import 'package:smart_score/menubar/notification_alert_screen.dart';
import 'package:smart_score/menubar/privacy_security_screen.dart';
import 'package:smart_score/menubar/profile_edit.dart';
import 'package:smart_score/menubar/user_mangement.dart';
import 'package:smart_score/transaction/transaction_screen.dart';
import 'package:smart_score/OnboardingScreen/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Local color definitions as requested
  static const Color primaryBlue = Color(0xFF2672F5);
  static const Color kycGreen = Color(0xFF4CAF50);
  static const Color textDark = Color(0xFF1E2E5D);
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
            // SizedBox(height: avatarR * 8),

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

            SizedBox(height: 0.08 * scale),

            const SizedBox(height: 30),
            // Profile Options Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Column(
                    children: [
                      _buildProfileItem(
                        context,
                        'Personal Information',
                        'assets/person.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInformationScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'User Management',
                        'assets/images/person.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserManagementScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'Transaction',
                        'assets/images/transaction.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'Notification Setting',
                        'assets/images/notiy.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationAlertScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'Help & Support',
                        'assets/images/help.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpSupportScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'Language',
                        'assets/images/language.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectLanguageScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'Privacy & Security',
                        'assets/images/privacy.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PrivacySecurityScreen(),
                            ),
                          );
                        },
                      ),
                      _buildDivider(),
                      _buildProfileItem(
                        context,
                        'Logout',
                        'assets/images/logout.png',
                        () => _showLogoutDialog(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure want to Logout?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black, width: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'NO',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserNameLoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: const Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    String title,
    String iconPath,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap, // Full blink (ripple) on tap as requested
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: primaryBlue,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, color: Colors.white),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
              // Arrow section
              const Icon(Icons.arrow_forward_ios, color: primaryBlue, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: Colors.grey.shade100,
      indent: 74,
    );
  }
}

class ProfileHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);

    // Deeper and more centered curve matching the official UI
    var controlPoint = Offset(size.width / 2, size.height + 40);
    var endPoint = Offset(size.width, size.height - 100);

    path.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
