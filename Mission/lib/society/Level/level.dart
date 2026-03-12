import 'package:flutter/material.dart';
import 'package:sales_erp/society/Commission/overview_card.dart';
import 'package:sales_erp/widgets/status_bar.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({super.key});

  static const Color _headerColor = Color(0xFF1F6F66);
  static const Color _secondaryTeal = Color(0xFF2F8F84);
  static const Color _pageBg = Colors.white;
  static const Color _titleDark = Color(0xFF2E3D3E);
  static const Color _muted = Color(0xFF8D9A99);
  static const Color _accent = Color(0xFFE1C16E);
  static const double _currentScore = 500000;
  static const double _targetScore = 600000;

  static const List<String> _levelRoles = [
    'Field Advisor',
    'Field Officer',
    'Senior Field Officer',
    'Zonal Field Officer',
    'Manager',
    'Senior Manager',
    'General Manager',
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);
    final double progress = (_currentScore / _targetScore).clamp(0.0, 1.0);
    final int activeLevelCount = _activeLevelCount(_currentScore, _targetScore);
    final int remainingToTarget =
        (_targetScore - _currentScore).clamp(0.0, _targetScore).round();

    return StatusBarWrapper(
      statusBarColor: _headerColor,
      iconBrightness: Brightness.light,
      child: Scaffold(
        backgroundColor: _pageBg,
        body: Column(
          children: [
            const CustomStatusBar(
              backgroundColor: _headerColor,
              iconBrightness: Brightness.light,
            ),
            Container(
              height: 62 * sh,
              width: double.infinity,
              color: _headerColor,
              padding: EdgeInsets.symmetric(horizontal: 12 * sw),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).maybePop(),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 34 * sf,
                    ),
                  ),
                  SizedBox(width: 8 * sw),
                  Expanded(
                    child: Text(
                      'Levels',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23*sf,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.notifications_none_outlined,
                    color: Colors.white,
                    size: 24 * sf,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(18 * sw, 20 * sh, 18 * sw, 20 * sh),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Field Advisor',
                                style: TextStyle(
                                  color: _headerColor,
                                  fontSize: 33 / 1.5 * sf,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2 * sh),
                              Text(
                                'Achievement Level 1',
                                style: TextStyle(
                                  color: _muted,
                                  fontSize: 20 / 1.5 * sf,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 11 * sh),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 23 / 1.5 * sf,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '${_formatScore(_currentScore)}/',
                                      style: const TextStyle(
                                        color: Color(0xFF4A5655),
                                      ),
                                    ),
                                    TextSpan(
                                      text: _formatScore(_targetScore),
                                      style: const TextStyle(color: _accent),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 7 * sh),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30 * sf),
                                child: Container(
                                  width: 252 * sw,
                                  height: 7 * sh,
                                  color: const Color(0xFFD9DDDC),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      width: (252 * sw) * progress,
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [ Color(0xFFE1C16E),_headerColor,],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 11 * sh),
                              Text(
                                'Complete your targets to reach the\nnext level.',
                                style: TextStyle(
                                  color: _titleDark,
                                  fontSize: 21 / 1.5 * sf,
                                  height: 1.28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8 * sw),
                        Image.asset(
                          'assets/gif/level_badge.gif',
                          width: 106 * sw,
                          height: 106 * sh,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(height: 16 * sh),
                    SizedBox(height: 14 * sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _topTab('Journey', true, sw, sh, sf),
                        _topTab('Time', false, sw, sh, sf),
                        _topTab('Journey', false, sw, sh, sf),
                      ],
                    ),
                    SizedBox(height: 6 * sh),
                    Container(height: 1, color: const Color(0xFFD8DCDC)),
                    SizedBox(height: 14 * sh),
                    Text(
                      'Your Achievement Journey',
                      style: TextStyle(
                        color: const Color(0xFF2F3E3E),
                        fontSize: 25 / 1.5 * sf,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3 * sh),
                    Text(
                      'Complete milestones to unlock exclusive benefits',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF7C8A89),
                        fontSize: 17 / 1.5 * sf,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 12 * sh),
                    ...List.generate(
                      _levelRoles.length,
                      (index) => _journeyItem(
                        level: index + 1,
                        role: _levelRoles[index],
                        alignLeft: index.isEven,
                        active: index < activeLevelCount,
                        sw: sw,
                        sh: sh,
                        sf: sf,
                      ),
                    ),
                    SizedBox(height: 10 * sh),
                    _nextLevelBenefitsCard(
                      context,
                      sw,
                      sh,
                      sf,
                      remainingToTarget,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topTab(
    String label,
    bool selected,
    double sw,
    double sh,
    double sf,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: selected ? _accent : const Color(0xFF3F4A49),
            fontSize: 15 / 1 * sf,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4 * sh),
        Container(
          width: 50 * sw,
          height: 4 * sh,
          decoration: BoxDecoration(
            color: selected ? _accent : Colors.transparent,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ],
    );
  }

  static int _activeLevelCount(double score, double maxScore) {
    const int totalLevels = 7;
    if (score <= 0) {
      return 1;
    }
    final double clampedScore = score.clamp(0.0, maxScore);
    final double eachStep = maxScore / (totalLevels - 1);
    final int achieved = (clampedScore / eachStep).floor() + 1;
    return achieved.clamp(1, totalLevels);
  }

  static String _formatScore(num value) {
    return value.toStringAsFixed(0);
  }

  Widget _journeyItem({
    required int level,
    required String role,
    required bool alignLeft,
    required bool active,
    required double sw,
    required double sh,
    required double sf,
  }) {
    final Color outerColor = active ? _secondaryTeal.withOpacity(0.28) : const Color(0xFFD9E7E5);
    final Color innerColor = active ? _headerColor : const Color(0xFF90B9B5);
    final Color textColor = active ? Colors.white : const Color(0xFFF4FBFA);
    final Color roleColor = const Color(0xFF6C7676);

    return Column(
      children: [
        Row(
          mainAxisAlignment:
              alignLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 138 * sw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 110 * sw,
                    height: 110 * sw,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: outerColor,
                      border: Border.all(color: _secondaryTeal, width: 1.6 * sf),
                      boxShadow: [
                        BoxShadow(
                          color: _secondaryTeal.withOpacity(0.52),
                          blurRadius: 18 * sf,
                          spreadRadius: 2.0 * sf,
                          offset: Offset(0, 2 * sh),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      width: 95 * sw,
                      height: 95 * sw,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: innerColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$level',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 42 / 1.5 * sf,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4 * sh),
                  Text(
                    'Level',
                    style: TextStyle(
                      color: const Color(0xFFA0A9A8),
                      fontSize: 17 / 1.5 * sf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1 * sh),
                  Text(
                    role,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: roleColor,
                      fontSize: 20 / 1.5 * sf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10 * sh),
      ],
    );
  }

  Widget _nextLevelBenefitsCard(
    BuildContext context,
    double sw,
    double sh,
    double sf,
    int remainingToTarget,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12 * sw, 12 * sh, 12 * sw, 14 * sh),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F7),
        borderRadius: BorderRadius.circular(8 * sf),
        border: Border.all(color: const Color(0xFF8FB6B2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Next Level Benefits',
                  style: TextStyle(
                    color: _headerColor,
                    fontSize: 20 / 1.5 * sf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8 * sw,
                  vertical: 4 * sh,
                ),
                decoration: BoxDecoration(
                  color: _headerColor,
                  borderRadius: BorderRadius.circular(100 * sf),
                ),
                child: Text(
                  '${_formatScore(remainingToTarget)} to go',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 / 1 * sf,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 3 * sh),
          Text(
            'Level 1',
            style: TextStyle(
              color: const Color(0xFF7B8887),
              fontSize: 14 / 1.2 * sf,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8 * sh),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10 * sw, vertical: 8 * sh),
            decoration: BoxDecoration(
              color: const Color(0xFFEAC66E),
              borderRadius: BorderRadius.circular(8 * sf),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/gif/profit.gif',
                  width: 18 * sf,
                  height: 18 * sf,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8 * sw),
                Expanded(
                  child: Text(
                    "You're closer! Keep pushing forward .",
                    style: TextStyle(
                      color: const Color(0xFF56625F),
                      fontSize: 15 / 1.5 * sf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10 * sh),
          _benefitTile(sw, sh, sf),
          SizedBox(height: 8 * sh),
          _benefitTile(sw, sh, sf),
          SizedBox(height: 8 * sh),
          _benefitTile(sw, sh, sf),
          SizedBox(height: 14 * sh),
          SizedBox(
            width: double.infinity,
            height: 40 * sh,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OverviewCardPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: _headerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7 * sf),
                ),
              ),
              child: Text(
                'Continue Journey',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16 / 1 * sf,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitTile(double sw, double sh, double sf) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10 * sw, vertical: 8 * sh),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8 * sf),
        border: Border.all(color: const Color(0xFFE1E5E4), width: 1),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/gif/profit.gif',
            width: 21 * sf,
            height: 21 * sf,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 8 * sw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Higher Commission',
                  style: TextStyle(
                    color: const Color(0xFF344645),
                    fontSize: 16 / 1 * sf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 1 * sh),
                Text(
                  '+ 5% on all sales',
                  style: TextStyle(
                    color: const Color(0xFF5D6F6E),
                    fontSize: 13 / 1 * sf,
                    fontWeight: FontWeight.w500,
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
