import 'package:flutter/material.dart';
import 'package:sales_erp/society/Commission/single_field_advisor.dart';
import 'package:sales_erp/widgets/status_bar.dart';

class SingleContributionScreen extends StatelessWidget {
  const SingleContributionScreen({super.key});

  static const _teal = Color(0xFF1F6F66);

  final List<_LevelItem> _levels = const [
    _LevelItem('Field Advisor', unlocked: true),
    _LevelItem('Field Officer', unlocked: true),
    _LevelItem('Senior Field Officer', unlocked: false),
    _LevelItem('Zonal Field Officer', unlocked: false),
    _LevelItem('Manager', unlocked: false),
    _LevelItem('Senior Manager', unlocked: false),
    _LevelItem('General Manager', unlocked: false),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);

    return StatusBarWrapper(
      statusBarColor: _teal,
      iconBrightness: Brightness.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomStatusBar(
              backgroundColor: _teal,
              iconBrightness: Brightness.light,
            ),
            Container(
              height: 64 * sh,
              width: double.infinity,
              color: _teal,
              padding: EdgeInsets.symmetric(horizontal: 8 * sw),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.white, size: 32 * sf),
                    onPressed: () => Navigator.maybePop(context),
                  ),
                  Text(
                    'Single Contribution',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23 * sf,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20 * sw, vertical: 16 * sh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Commission Levels',
                        style: TextStyle(
                          fontSize: 18 * sf,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF424242),
                        ),
                      ),
                      SizedBox(height: 4 * sh),
                      Text(
                        'Your role defines your commission and visibility. Level\nup to unlock higher tiers',
                        style: TextStyle(
                          fontSize: 14 * sf,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 16 * sh),
                      ..._levels.map((item) => _buildLevelTile(context, item, sw, sh, sf)),
                      SizedBox(height: 16 * sh),
                      _buildTipsCard(sw, sh, sf),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelTile(
    BuildContext context,
    _LevelItem item,
    double sw,
    double sh,
    double sf,
  ) {
    return GestureDetector(
      onTap: () {
        if (item.name == 'Field Advisor') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FieldAdvisorScreen2()),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8 * sh),
        decoration: BoxDecoration(
          color: item.unlocked ? const Color(0xFFF4F7F6) : const Color(0xFFF9FAFA),
          borderRadius: BorderRadius.circular(10 * sf),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16 * sw, vertical: 2 * sh),
          leading: item.unlocked
              ? null
              : Icon(
                  Icons.lock_outline,
                  color: const Color(0xFFDFE4E4),
                  size: 20 * sf,
                ),
          title: Text(
            item.name,
            style: TextStyle(
              fontSize: 15 * sf,
              color: item.unlocked ? const Color(0xFF424242) : const Color(0xFFCBD2D2),
              fontWeight: item.unlocked ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
          trailing: item.unlocked
              ? Icon(Icons.chevron_right, color: _teal, size: 28 * sf)
              : null,
        ),
      ),
    );
  }

  Widget _buildTipsCard(double sw, double sh, double sf) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7F6),
        borderRadius: BorderRadius.circular(14 * sf),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14 * sf),
        child: Stack(
          children: [
            Positioned(
              bottom: -24 * sh,
              right: -14 * sw,
              child: Container(
                width: 114 * sw,
                height: 114 * sh,
                decoration: const BoxDecoration(
                  color: Color(0xFFE5B55A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12 * sw, 12 * sh, 14 * sw, 12 * sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/commission/hand_gif.gif',
                        width: 30 * sf,
                        height: 30 * sf,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.lightbulb,
                          color: const Color(0xFFE5B55A),
                          size: 24 * sf,
                        ),
                      ),
                      SizedBox(width: 8 * sw),
                      Expanded(
                        child: Text(
                          'Tips to Increase Your Commission',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16 * sf,
                            color: const Color(0xFF2C3E50),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10 * sh),
                  _buildTipItem('Follow up pending members', sw, sh, sf),
                  _buildTipItem('Focus on high-value plans', sw, sh, sf),
                  _buildTipItem('Complete monthly target early', sw, sh, sf),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String text, double sw, double sh, double sf) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8 * sh),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 2.2 * sw,
            height: 16 * sh,
            decoration: BoxDecoration(
              color: const Color(0xFFE5B55A),
              borderRadius: BorderRadius.circular(1 * sf),
            ),
          ),
          SizedBox(width: 8 * sw),
          Text(
            text,
            style: TextStyle(
              fontSize: 14 * sf,
              color: const Color(0xFF506367),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelItem {
  final String name;
  final bool unlocked;
  const _LevelItem(this.name, {required this.unlocked});
}
