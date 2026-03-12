import 'package:flutter/material.dart';
import 'package:sales_erp/society/Commission/multiple_contribution.dart';
import 'package:sales_erp/society/Commission/single_contribution.dart';
import 'package:sales_erp/widgets/status_bar.dart';
import 'package:sales_erp/society/Commission/view_comission_listing.dart';

class OverviewCardPage extends StatelessWidget {
  const OverviewCardPage({
    super.key,
    this.monthlyData = _defaultMonthlyData,
  });

  static const Color _headerColor = Color(0xFF1F6F66);
  static const Color _accentColor = Color(0xFFE1C16E);
  static const Color _pageBg = Color(0xFFF5F5F7);
  static const Color _sectionBg = Color(0xFFE8EEEC);
  static const Color _titleColor = Color(0xFF3E4B4D);
  static const Color _valueColor = Color(0xFF1F6F66);
  static const Color _successColor = Color(0xFF3FAF7F);

  static const List<MonthCommission> _defaultMonthlyData = [
    MonthCommission('OCT', 25000),
    MonthCommission('NOV', 40000),
    MonthCommission('DEC', 35000),
    MonthCommission('JAN', 46200),
    MonthCommission('FEB', 50000),
    MonthCommission('MAR', 47000),
  ];

  final List<MonthCommission> monthlyData;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);

    final double performanceChange = _calculateChange(monthlyData);
    final bool isPositive = performanceChange >= 0;

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
              height: 70 * sh,
              width: double.infinity,
              color: _headerColor,
              padding: EdgeInsets.symmetric(horizontal: 16 * sw),
              child: Row(
                children: [
                  Icon(Icons.chevron_left, color: Colors.white, size: 34 * sf),
                  SizedBox(width: 6 * sw),
                  Expanded(
                    child: Text(
                      'My Commission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.5 * sf,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.white,
                      size: 25 * sf,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        16 * sw,
                        20 * sh,
                        16 * sw,
                        0,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(18 * sf),
                        ),
                        padding: EdgeInsets.fromLTRB(
                          16 * sw,
                          16 * sh,
                          16 * sw,
                          16 * sh,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18 * sf,
                                  backgroundColor: _accentColor,
                                  child: Image.asset(
                                    'assets/commission/graph_arrow.png',
                                    width: 24 * sf,
                                    height: 24 * sf,
                                    color: _headerColor,
                                  ),
                                ),
                                SizedBox(width: 12 * sw),
                                Text(
                                  'Total Commission Earned',
                                  style: TextStyle(
                                    color: _titleColor,
                                    fontSize: 16.5 * sf,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12 * sh),
                            Text(
                              '5000.00',
                              style: TextStyle(
                                color: _valueColor,
                                fontSize: 42.5 * sf,
                                height: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 18 * sh),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'This Month',
                                      style: TextStyle(
                                        color: Color(0xFF7E8886),
                                        fontSize: 16 * sf,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 3 * sh),
                                    Text(
                                      '1500.00',
                                      style: TextStyle(
                                        color: _valueColor,
                                        fontSize: 16.5 * sf,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12 * sw),
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: SizedBox(
                                      width: 220 * sw,
                                      height: 42 * sh,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: _accentColor,
                                          foregroundColor: _titleColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12 * sf,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 14 * sw,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const ViewComissionListingPage(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'View Commission Details',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 14 * sf,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(width: 4 * sw),
                                            Icon(
                                              Icons.arrow_forward,
                                              size: 22 * sf,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 18 * sh),
                    Container(
                      width: double.infinity,
                      color: _sectionBg,
                      padding: EdgeInsets.fromLTRB(
                        16 * sw,
                        18 * sh,
                        16 * sw,
                        18 * sh,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Monthly Commission\nPerformance',
                                  style: TextStyle(
                                    color: _titleColor,
                                    fontSize: 19.5 * sf,
                                    fontWeight: FontWeight.w600,
                                    height: 1.12,
                                  ),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.filter_list_rounded,
                                  size: 24 * sf,
                                  color: _titleColor,
                                ),
                                label: Text(
                                  'Filter',
                                  style: TextStyle(
                                    color: _titleColor,
                                    fontSize: 16.5 * sf,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF9DA6A4),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10 * sf),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14 * sw,
                                    vertical: 11 * sh,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16 * sh),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: _headerColor,
                              borderRadius: BorderRadius.circular(14 * sf),
                            ),
                            padding: EdgeInsets.fromLTRB(
                              14 * sw,
                              14 * sh,
                              14 * sw,
                              12 * sh,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.gps_fixed_rounded,
                                      color: Colors.white,
                                      size: 28 * sf,
                                    ),
                                    SizedBox(width: 10 * sw),
                                    Expanded(
                                      child: Text(
                                        'Achieve your target',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.5 * sf,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12 * sw,
                                        vertical: 6 * sh,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isPositive
                                            ? _successColor
                                            : const Color(0xFFDB695F),
                                        borderRadius: BorderRadius.circular(
                                          20 * sf,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isPositive
                                                ? Icons.trending_up_rounded
                                                : Icons.trending_down_rounded,
                                            color: _accentColor,
                                            size: 20 * sf,
                                          ),
                                          SizedBox(width: 4 * sw),
                                          Text(
                                            '${isPositive ? '+' : ''}${performanceChange.toStringAsFixed(1)}%',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15 * sf,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 14 * sh),
                                _CommissionBarChart(
                                  data: monthlyData,
                                  highlightColor: _accentColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16 * sw, 20 * sh, 16 * sw, 22 * sh),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Commission Structure',
                            style: TextStyle(
                              color: _titleColor,
                              fontSize: 20 * sf,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 14 * sh),
                          _CommissionActionButton(
                            label: 'Multiple Contribution Income Chart',
                            accentColor: _accentColor,
                            textColor: _titleColor,
                            sw: sw,
                            sh: sh,
                            sf: sf,
                            onTap: () { Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const MultipleContributionScreen(),
                                ),
                              );},
                          ),
                          SizedBox(height: 12 * sh),
                          _CommissionActionButton(
                            label: 'Single Contribution Income Chart',
                            accentColor: _accentColor,
                            textColor: _titleColor,
                            sw: sw,
                            sh: sh,
                            sf: sf,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const SingleContributionScreen(),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 22 * sh),
                        ],
                      ),
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

  static double _calculateChange(List<MonthCommission> data) {
    if (data.length < 2 || data[data.length - 2].value == 0) {
      return 0;
    }
    final double current = data.last.value;
    final double previous = data[data.length - 2].value;
    return ((current - previous) / previous) * 100;
  }
}

class _CommissionBarChart extends StatelessWidget {
  const _CommissionBarChart({
    required this.data,
    required this.highlightColor,
  });

  final List<MonthCommission> data;
  final Color highlightColor;

  static const Color _barDefault = Color(0xFFC4C4C4);
  static const Color _axisColor = Color(0xFF9CD7CF);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);

    if (data.isEmpty) {
      return SizedBox(
        height: 120 * sh,
        child: Center(
          child: Text(
            'No commission data',
            style: TextStyle(color: Colors.white70, fontSize: 16 * sf),
          ),
        ),
      );
    }

    final double maxValue = data
        .map((entry) => entry.value)
        .reduce((a, b) => a > b ? a : b);
    final double step = _niceStep(maxValue / 4);
    final List<double> ticks = List<double>.generate(4, (index) {
      return step * (index + 1);
    });
    final double axisMax = ticks.last;
    final int highestIndex = data.indexWhere((item) => item.value == maxValue);

    return SizedBox(
      height: 250 * sh,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 78 * sw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 6 * sh),
                for (final tick in ticks.reversed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Transform.translate(
                        offset: Offset(-3 * sw, 0),
                        child: Text(
                          tick.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16 * sf,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 6 * sw),
                      Container(
                        width: 8 * sw,
                        height: 1.3,
                        color: _axisColor,
                      ),
                    ],
                  ),
                SizedBox(height: 32 * sh),
              ],
            ),
          ),
          SizedBox(width: 8 * sw),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: (data.length * 66 * sw).toDouble(),
                child: Container(
                  height: 212 * sh,
                  padding: EdgeInsets.only(
                    left: 8 * sw,
                    right: 4 * sw,
                    top: 0,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(color: _axisColor, width: 1.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(data.length, (index) {
                      final MonthCommission item = data[index];
                      final bool isHighest = index == highestIndex;
                      final double ratio = axisMax == 0
                          ? 0
                          : (item.value / axisMax).clamp(0.0, 1.0);

                      return SizedBox(
                        width: 54 * sw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (isHighest)
                              Padding(
                                padding: EdgeInsets.only(bottom: 3 * sh),
                                child: Text(
                                  'Highest\nEarnings',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFFE1C16E),
                                    fontSize: 15 * sf,
                                    height: 1.02,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            else
                              const SizedBox.shrink(),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: ratio * (130 * sh),
                                  decoration: BoxDecoration(
                                    color: isHighest
                                        ? highlightColor
                                        : _barDefault,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8 * sf),
                                      topRight: Radius.circular(8 * sf),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1.3,
                              color: _axisColor,
                            ),
                            SizedBox(height: 4 * sh),
                            Container(
                              width: 1.3,
                              height: 6 * sh,
                              color: _axisColor,
                            ),
                            SizedBox(height: 6 * sh),
                            Text(
                              item.month,
                              style: TextStyle(
                                color: isHighest
                                    ? Colors.white
                                    : const Color(0xFF7EA8A1),
                                fontSize: 18 * sf,
                                fontWeight: isHighest
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _niceStep(double raw) {
    const List<double> baseSteps = [5000, 10000, 15000, 20000, 25000];
    for (final base in baseSteps) {
      if (raw <= base) {
        return base;
      }
    }
    final double rounded = (raw / 5000).ceil() * 5000;
    return rounded;
  }
}

class MonthCommission {
  const MonthCommission(this.month, this.value);

  final String month;
  final double value;
}

class _CommissionActionButton extends StatelessWidget {
  const _CommissionActionButton({
    required this.label,
    required this.accentColor,
    required this.textColor,
    required this.sw,
    required this.sh,
    required this.sf,
    required this.onTap,
  });

  final String label;
  final Color accentColor;
  final Color textColor;
  final double sw;
  final double sh;
  final double sf;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54 * sh,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: accentColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12 * sf),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20 * sw),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16 * sf,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, size: 34 * sf),
          ],
        ),
      ),
    );
  }
}
