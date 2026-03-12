import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  NotificationsScreen
// ─────────────────────────────────────────────
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Toggle states
  bool _bookingUpdates       = true;
  bool _sellerAlerts         = true;
  bool _offersPromotions     = true;
  bool _accountSecurityAlerts = true;

  static const _green  = Color(0xFF2E7D52);
  static const _purple = Color(0xFF6B4EAE);

  @override
  Widget build(BuildContext context) {
    final mq       = MediaQuery.of(context);
    final double w = mq.size.width;
    final double h = mq.size.height;

    // Responsive scale helpers
    final double wp = w / 390;
    final double hp = h / 844;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications & Alerts'),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── AppBar ─────────────────────────────────────
            Container(
              width: w,
              height: 56 * hp,
              color: const Color(0xFFFBF8F8),
              padding: EdgeInsets.symmetric(horizontal: 16 * wp),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(Icons.arrow_back, color: _green, size: 24 * wp),
                  ),
                  SizedBox(width: 12 * wp),
                  Text(
                    'Notifications & Alerts',
                    style: TextStyle(
                      color: _green,
                      fontSize: 20 * wp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ── Body ───────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * wp,
                  vertical: 20 * hp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Heading
                    Text(
                      'Notification & Alerts',
                      style: TextStyle(
                        fontSize: 22 * wp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 10 * hp),

                    // Sub-description
                    Text(
                      'Stay updated, stay informed.\nGet important updates about your bookings, listings, offers, and account activity — all in one place.',
                      style: TextStyle(
                        fontSize: 14 * wp,
                        color: const Color(0xFF3D3D3D),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24 * hp),

                    // ── Toggle Cards ──────────────────────────
                    _ToggleCard(
                      label: 'Booking Updates',
                      value: _bookingUpdates,
                      showCheck: _bookingUpdates,
                      activeColor: _purple,
                      wp: wp,
                      hp: hp,
                      onChanged: (v) => setState(() => _bookingUpdates = v),
                    ),
                    SizedBox(height: 14 * hp),

                    _ToggleCard(
                      label: 'Seller Alerts',
                      value: _sellerAlerts,
                      showCheck: _sellerAlerts,
                      activeColor: _purple,
                      wp: wp,
                      hp: hp,
                      onChanged: (v) => setState(() => _sellerAlerts = v),
                    ),
                    SizedBox(height: 14 * hp),

                    _ToggleCard(
                      label: 'Offers & Promotions',
                      value: _offersPromotions,
                      showCheck: false,
                      activeColor: _purple,
                      wp: wp,
                      hp: hp,
                      onChanged: (v) => setState(() => _offersPromotions = v),
                    ),
                    SizedBox(height: 14 * hp),

                    _ToggleCard(
                      label: 'Account & Security Alerts',
                      value: _accountSecurityAlerts,
                      showCheck: false,
                      activeColor: _purple,
                      wp: wp,
                      hp: hp,
                      onChanged: (v) => setState(() => _accountSecurityAlerts = v),
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
//  _ToggleCard
// ─────────────────────────────────────────────
class _ToggleCard extends StatelessWidget {
  final String   label;
  final bool     value;
  final bool     showCheck;   // shows checkmark inside thumb when true
  final Color    activeColor;
  final double   wp;
  final double   hp;
  final ValueChanged<bool> onChanged;

  const _ToggleCard({
    required this.label,
    required this.value,
    required this.showCheck,
    required this.activeColor,
    required this.wp,
    required this.hp,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 18 * wp,
        vertical: 20 * hp,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * wp),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 15 * wp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1A1A1A),
            ),
          ),

          // Custom Toggle
          GestureDetector(
            onTap: () => onChanged(!value),
            child: _CustomToggle(
              value: value,
              showCheck: showCheck,
              activeColor: activeColor,
              wp: wp,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  _CustomToggle  – purple toggle with optional
//  checkmark thumb (as in the design)
// ─────────────────────────────────────────────
class _CustomToggle extends StatelessWidget {
  final bool  value;
  final bool  showCheck;
  final Color activeColor;
  final double wp;

  const _CustomToggle({
    required this.value,
    required this.showCheck,
    required this.activeColor,
    required this.wp,
  });

  @override
  Widget build(BuildContext context) {
    final double trackW  = 58 * wp;
    final double trackH  = 32 * wp;
    final double thumbSz = 26 * wp;
    final double padding = 3  * wp;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width:  trackW,
      height: trackH,
      decoration: BoxDecoration(
        color:        value ? activeColor : const Color(0xFFCCCCCC),
        borderRadius: BorderRadius.circular(trackH / 2),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            top:  padding,
            left: value ? trackW - thumbSz - padding : padding,
            child: Container(
              width:  thumbSz,
              height: thumbSz,
              decoration: BoxDecoration(
                color: showCheck
                    ? const Color(0xFFE8E0F8)   // light lavender for check thumb
                    : Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: showCheck
                  ? Icon(Icons.check, color: activeColor, size: 16 * wp)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}



