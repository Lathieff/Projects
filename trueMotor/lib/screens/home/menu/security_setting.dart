import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  SecuritySettingScreen
// ─────────────────────────────────────────────
class SecuritySettingScreen extends StatelessWidget {
  const SecuritySettingScreen({super.key});

  static const _green = Color(0xFF2E7D52);

  // Menu items: (label, assetPath)
  static const _menuItems = [
    ('Change Mobile Number',      'assets/change_mob.png'),
    ('Two Factor Authentication', 'assets/two_factor.png'),
    ('Privacy Setting',           'assets/privacy_setting.png'),
    ('Delete Account',            'assets/delete_account.png'),
  ];

  @override
  Widget build(BuildContext context) {
    final mq       = MediaQuery.of(context);
    final double w = mq.size.width;
    final double h = mq.size.height;

    final double wp = w / 390;
    final double hp = h / 844;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Security & Setting'),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── AppBar ──────────────────────────────────────
            Container(
              width:  w,
              height: 56 * hp,
              color:  const Color(0xFFFBF8F8),
              padding: EdgeInsets.symmetric(horizontal: 16 * wp),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(Icons.arrow_back, color: _green, size: 24 * wp),
                  ),
                  SizedBox(width: 12 * wp),
                  Text(
                    'Security & Setting',
                    style: TextStyle(
                      color:      _green,
                      fontSize:   20 * wp,
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
                  vertical:   20 * hp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Heading
                    Text(
                      'Security & Settings – TrueMotors',
                      style: TextStyle(
                        fontSize:   17 * wp,
                        fontWeight: FontWeight.w800,
                        color:      const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 8 * hp),

                    // Description
                    Text(
                      'Your privacy and security come first.\nManage your account security, privacy settings, and personal preferences — all in one place.',
                      style: TextStyle(
                        fontSize: 14 * wp,
                        color:    const Color(0xFF3D3D3D),
                        height:   1.55,
                      ),
                    ),
                    SizedBox(height: 28 * hp),

                    // ── Menu List ──────────────────────────────
                    Container(
                      decoration: BoxDecoration(
                        color:        Colors.white,
                        borderRadius: BorderRadius.circular(12 * wp),
                      ),
                      child: Column(
                        children: List.generate(_menuItems.length, (i) {
                          final (label, asset) = _menuItems[i];
                          final bool isLast    = i == _menuItems.length - 1;

                          return _MenuItem(
                            label:     label,
                            assetPath: asset,
                            isLast:    isLast,
                            wp:        wp,
                            hp:        hp,
                            onTap:     () {/* navigate */},
                          );
                        }),
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
//  _MenuItem
// ─────────────────────────────────────────────
class _MenuItem extends StatelessWidget {
  final String   label;
  final String   assetPath;
  final bool     isLast;
  final double   wp;
  final double   hp;
  final VoidCallback onTap;

  const _MenuItem({
    required this.label,
    required this.assetPath,
    required this.isLast,
    required this.wp,
    required this.hp,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12 * wp),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16 * wp,
              vertical:   18 * hp,
            ),
            child: Row(
              children: [

                // ── Asset Image Box ────────────────────────
                Container(
                  width:  40 * wp,
                  height: 40 * wp,
                  decoration: BoxDecoration(
                    color:        const Color(0xFFEEF4FF),
                    borderRadius: BorderRadius.circular(10 * wp),
                  ),
                  padding: EdgeInsets.all(8 * wp),
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.image_not_supported_outlined,
                      size:  20 * wp,
                      color: const Color(0xFF4A6FA5),
                    ),
                  ),
                ),
                SizedBox(width: 14 * wp),

                // Label
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize:   15 * wp,
                      fontWeight: FontWeight.w400,
                      color:      const Color(0xFF1A1A1A),
                    ),
                  ),
                ),

                // Chevron
                Icon(
                  Icons.chevron_right,
                  size:  22 * wp,
                  color: const Color(0xFF888888),
                ),
              ],
            ),
          ),
        ),

        // Divider (skip after last item)
        if (!isLast)
          Divider(
            height:    1,
            thickness: 1,
            indent:    16 * wp,
            endIndent: 16 * wp,
            color:     const Color(0xFFE8E8E8),
          ),
      ],
    );
  }
}

