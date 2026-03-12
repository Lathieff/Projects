import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const Color tealColor   = Color(0xFF2A7C76);
  static const Color appBarColor = Color(0xFFFBF8F8);

  // ── Poppins base style ───────────────────────────────────────────
  // font-size: 14px | weight: 400 | line-height: 100% | letter-spacing: 0%
  static TextStyle poppins({
    double fontSize  = 14,
    FontWeight weight = FontWeight.w400,
    Color color      = Colors.black87,
    double height    = 1.0,   // line-height: 100%
  }) {
    return GoogleFonts.poppins(
      fontSize:      fontSize,
      fontWeight:    weight,
      color:         color,
      height:        height,
      letterSpacing: 0,       // letter-spacing: 0%
    );
  }

  // ── Filter tabs ──────────────────────────────────────────────────
  final List<String> _tabs = ['All', 'Buy Vehicle', 'Sell Vehicle', 'Rental'];
  int _selectedTab = 0;

  // ── Notification data ────────────────────────────────────────────
  final List<_NotifItem> _buyNotifs = const [
    _NotifItem(
      tag:      'New Vehicle Alert',
      tagColor: Color(0xFFE53935),
      message:  'Hyundai Creta 2023 Diesel just listed near you.',
      time:     '30 mins ago',
    ),
    _NotifItem(
      tag:      'Booking Update',
      tagColor: Color(0xFFE53935),
      message:  'Your test drive for Tata Nexon is confirmed on Aug 3, 10 AM.',
      time:     'Yesterday',
    ),
  ];

  final List<_NotifItem> _sellNotifs = const [
    _NotifItem(
      tag:      'Enquiry Received',
      tagColor: Color(0xFF2A7C76),
      message:  'You have 3 new enquiries for your posted vehicle – Honda City 2018.',
      time:     '2 hours ago',
    ),
    _NotifItem(
      tag:      'Booking Update',
      tagColor: Color(0xFF2A7C76),
      message:  'Your Maruti Baleno listing expires in 2 days. Renew to stay visible.',
      time:     'Today',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── App Bar ──────────────────────────────────────
              Container(
                color: appBarColor,
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.06,
                  vertical:   sw * 0.06,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: tealColor,
                        size: sw * 0.06,
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Text(
                      'Notification',
                      style: poppins(
                        fontSize:  sw * 0.055,
                        weight:    FontWeight.w500,
                        color:     tealColor,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Filter Tab Bar ───────────────────────────────
              SizedBox(height: sh * 0.02),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                child: Row(
                  children: List.generate(_tabs.length, (i) {
                    final bool isSelected = _selectedTab == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedTab = i),
                      child: Container(
                        margin: EdgeInsets.only(right: sw * 0.03),
                        padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.040,
                          vertical:   sw * 0.020,
                        ),
                        decoration: BoxDecoration(
                          color:        isSelected ? tealColor : Colors.white,
                          borderRadius: BorderRadius.circular(sw * 0.02),
                          border:       Border.all(color: tealColor, width: 1.2),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (i == 0) ...[
                              Icon(
                                Icons.filter_list,
                                size:  sw * 0.045,
                                color: isSelected ? Colors.white : tealColor,
                              ),
                              SizedBox(width: sw * 0.015),
                            ],
                            Text(
                              _tabs[i],
                              style: poppins(
                                fontSize: sw * 0.038,
                                weight:   FontWeight.w600,
                                color:    isSelected ? Colors.white : tealColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      );
                  }),
                ),
              ),

              SizedBox(height: sh * 0.02),

              // ── Notification List ────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Subtitle — Poppins 14 / 400
                      Text(
                        'Stay updated with the latest alerts and updates.',
                        style: poppins(
                          fontSize: 12,
                          color:    Colors.black87,
                        ),
                      ),

                      SizedBox(height: sh * 0.02),

                      // ── Buy Vehicle ────────────────────────
                      _buildSectionTitle('Buy Vehicle'),
                      SizedBox(height: sh * 0.01),
                      ..._buyNotifs.map((n) => _buildNotifCard(n, sw, sh)),

                      SizedBox(height: sh * 0.01),
                      Divider(color: Colors.grey.shade300, thickness: 1),
                      SizedBox(height: sh * 0.01),

                      // ── Sell Vehicle ───────────────────────
                      _buildSectionTitle('Sell Vehicle'),
                      SizedBox(height: sh * 0.01),
                      ..._sellNotifs.map((n) => _buildNotifCard(n, sw, sh)),

                      SizedBox(height: sh * 0.03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  // ── Section Title — Poppins 14 / 600 ────────────────────────────
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: poppins(
        fontSize: 14,
        weight:   FontWeight.w600,
        color:    Colors.black87,
      ),
    );
  }

  // ── Notification Card ────────────────────────────────────────────
  Widget _buildNotifCard(_NotifItem item, double sw, double sh) {
    return Container(
      margin: EdgeInsets.only(bottom: sh * 0.015),
      decoration: BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(sw * 0.025),
        border:       Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Tag badge ──────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: sw * 0.035,
              vertical:   sw * 0.015,
            ),
            decoration: BoxDecoration(
              color:        item.tagColor,
              borderRadius: BorderRadius.only(
                topLeft:     Radius.circular(sw * 0.025),
                bottomRight: Radius.circular(sw * 0.025),
              ),
            ),
            child: Text(
              item.tag,
              style: poppins(
                fontSize: 12,                  // tag slightly smaller
                weight:   FontWeight.w600,
                color:    Colors.white,
              ),
            ),
          ),

          // ── Message + Time ─────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              sw * 0.04, sw * 0.025, sw * 0.04, sw * 0.03,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.message,
                  textAlign: TextAlign.justify,
                  style: poppins(
                    fontSize: 13,              // font-size: 14px
                    color:    Colors.black87,
                    height:   1.0,            // readable line-height for cards
                  ),
                ),
                SizedBox(height: sw * 0.010),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    item.time,
                    style: poppins(
                      fontSize: 12,
                      color:    Colors.grey.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Data Model ────────────────────────────────────────────────────────────────
class _NotifItem {
  final String tag;
  final Color  tagColor;
  final String message;
  final String time;

  const _NotifItem({
    required this.tag,
    required this.tagColor,
    required this.message,
    required this.time,
  });
}

