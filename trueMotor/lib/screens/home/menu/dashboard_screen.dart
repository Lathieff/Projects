import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemotor/screens/login/login_screen.dart';
import 'profile_screen.dart';
import 'notifi_alerts_screen.dart';
import 'security_setting.dart';
import 'language_screen.dart';
import 'help_support_screen.dart';
import 'saved_vechicles_screen.dart';
import 'my_listing.dart';
import 'my_booking_rental.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  static const Color tealColor = Color(0xFF2A7C76);

  static TextStyle poppins({
    double     fontSize = 14,
    FontWeight weight   = FontWeight.w400,
    Color      color    = Colors.black87,
  }) {
    return GoogleFonts.poppins(
      fontSize:      fontSize,
      fontWeight:    weight,
      color:         color,
      letterSpacing: 0,
      height:        1.0,
    );
  }

  // ── Menu items: label + asset image path ──────────────────────────
  static const List<Map<String, String>> _menuItems = [
    {'label': 'Profile Information',   'icon': 'assets/icons/profile_info.png'},
    {'label': 'My Booking',            'icon': 'assets/icons/my_booking.png'},
    {'label': 'My Listing',            'icon': 'assets/icons/my_listing.png'},
    {'label': 'Saved Vehicles',        'icon': 'assets/icons/saved_vechiles.png'},
    {'label': 'Notification & Alerts', 'icon': 'assets/icons/notification_logo.png'},
    {'label': 'Help & Support',        'icon': 'assets/icons/help.png'},
    {'label': 'Security & Settings',   'icon': 'assets/icons/settings.png'},
    {'label': 'Language',              'icon': 'assets/icons/language.png'},
    {'label': 'Logout',                'icon': 'assets/icons/logout.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [

          // ── Header ─────────────────────────────────────────────
          Container(
            width:  double.infinity,
            color:  tealColor,
            padding: EdgeInsets.only(
              top:    sh * 0.055,
              left:   sw * 0.05,
              right:  sw * 0.05,
              bottom: sh * 0.028,
            ),
            child: Stack(
              children: [

                // ── Profile Row ──────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    // Avatar
                    CircleAvatar(
                      radius: sw * 0.09,
                      backgroundImage:
                      const AssetImage('assets/dash_profile_pic.png'),
                      backgroundColor: Colors.white24,
                    ),

                    SizedBox(width: sw * 0.04),

                    // Name / Phone / Profile link
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Name + Edit
                          Row(
                            children: [
                              Text(
                                'Harish ',
                                style: poppins(
                                  fontSize: sw * 0.052,
                                  weight:   FontWeight.w700,
                                  color:    Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit',
                                      style: poppins(
                                        fontSize: sw * 0.030,
                                        weight:   FontWeight.w500,
                                        color:    Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: sw * 0.01),
                                    Icon(
                                      Icons.edit,
                                      size:  sw * 0.038,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: sh * 0.005),

                          // Phone
                          Text(
                            '1122333444',
                            style: poppins(
                              fontSize: sw * 0.030,
                              color:    Colors.white,
                            ),
                          ),

                          SizedBox(height: sh * 0.001),

                          // View Full Profile + Active badge
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Text(
                                  'View Full Profile',
                                  style: poppins(
                                    fontSize: sw * 0.030,
                                    weight:   FontWeight.w500,
                                    color:    Colors.white,
                                  ).copyWith(
                                    decoration:      TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: sw * 0.04),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: sw * 0.045,
                                  vertical:   sw * 0.018,
                                ),
                                decoration: BoxDecoration(
                                  color:   Colors.green,
                                  borderRadius: BorderRadius.circular(sw * 0.06),
                                ),
                                child: Text(
                                  'Active',
                                  style: poppins(
                                    fontSize: sw * 0.036,
                                    weight:   FontWeight.w600,
                                    color:    Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // ── Close X button (top right) ───────────────
                Positioned(
                  top:   0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size:  sw * 0.065,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Menu List ───────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: sw * 0.04,
                vertical:   sh * 0.01,
              ),
              itemCount: _menuItems.length,
              separatorBuilder: (_, _) => Divider(
                color:     const Color(0xFFB0BEC5),
                thickness: 0.8,
                height:    0,
              ),
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                final bool isLogout = item['label'] == 'Logout';

                return GestureDetector(
                  onTap: () {
                    // TODO: navigate based on index
                    _onMenuTap(context, index);
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      vertical: sh * 0.022,
                    ),
                    child: Row(
                      children: [

                        // Asset icon image
                        Image.asset(
                          item['icon']!,
                          width:  sw * 0.09,
                          height: sw * 0.09,
                          fit:    BoxFit.contain,
                          errorBuilder: (_, _, _) => Icon(
                            Icons.circle_outlined,
                            size:  sw * 0.09,
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(width: sw * 0.05),

                        // Label
                        Expanded(
                          child: Text(
                            item['label']!,
                            style: poppins(
                              fontSize: sw * 0.043,
                              weight:   FontWeight.w500,
                              color:    isLogout
                                  ? Colors.black87
                                  : Colors.black87,
                            ),
                          ),
                        ),

                        // Chevron
                        Icon(
                          Icons.chevron_right,
                          size:  sw * 0.06,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Menu tap handler ─────────────────────────────────────────────
  void _onMenuTap(BuildContext context, int index) {
    switch (index) {
      case 0: // Profile Information
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
        break;
      case 1: // My Booking
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyBookingScreen()));
        break;
      case 2: // My Listing
      Navigator.push(context, MaterialPageRoute(builder: (_) => const MyListingScreen()));
        break;
      case 3: // Saved Vehicles
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedVehiclesScreen()));
        break;
      case 4: // Notification & Alerts
      Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
        break;
      case 5: // Help & Support
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()));
        break;
      case 6: // Security & Settings
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SecuritySettingScreen()));
        break;
      case 7: // Language
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SelectLanguageScreen()));
        break;
      case 8: // Logout
        _showLogoutDialog(context);
        break;
    }
  }

  // ── Logout confirmation dialog ────────────────────────────────────
  void _showLogoutDialog(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sw * 0.03),
        ),
        title: Text(
          'Logout',
          style: poppins(
            fontSize: sw * 0.045,
            weight:   FontWeight.w600,
            color:    Colors.black87,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: poppins(fontSize: sw * 0.038),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: poppins(
                fontSize: sw * 0.038,
                color:    Colors.grey,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: clear session → navigate to LoginScreen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false, // stack முழுவதும் clear — back button-ல் திரும்ப வர முடியாது
              );

            },
            child: Text(
              'Logout',
              style: poppins(
                fontSize: sw * 0.038,
                weight:   FontWeight.w600,
                color:    tealColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

