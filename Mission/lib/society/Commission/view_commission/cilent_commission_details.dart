import 'package:flutter/material.dart';
import 'package:sales_erp/widgets/status_bar.dart';

class ClientCommissionDetailsPage extends StatelessWidget {
  const ClientCommissionDetailsPage({
    super.key,
    required this.name,
    required this.role,
    required this.status,
    required this.phoneNumber,
    required this.address,
    required this.planDurationMonths,
    required this.monthlyContribution,
    required this.startDate,
    required this.summaryTotal,
    required this.summaryMetricValue,
    required this.summaryType,
    required this.contributionBreakdown,
    required this.isPending,
  });

  final String name;
  final String role;
  final String status;
  final String phoneNumber;
  final String address;
  final int planDurationMonths;
  final String monthlyContribution;
  final String startDate;
  final String summaryTotal;
  final String summaryMetricValue;
  final String summaryType;
  final List<ContributionBreakdownItem> contributionBreakdown;
  final bool isPending;

  static const Color _headerColor = Color(0xFF1F6F66);
  static const Color _pageBg = Color(0xFFEFEFF1);
  static const Color _cardBg = Color(0xFFF0F1F2);
  static const Color _titleColor = Color(0xFF2F3E3F);
  static const Color _tealText = Color(0xFF2A8A84);
  static const Color _iconGold = Color(0xFFD7B152);
  static const Color _summaryBg = Color(0xFF2F9A8F);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);
    final List<ContributionBreakdownItem> dynamicBreakdown =
        _buildDynamicBreakdown();

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
              height: 76 * sh,
              width: double.infinity,
              color: _headerColor,
              padding: EdgeInsets.symmetric(horizontal: 14 * sw),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 38 * sf,
                    ),
                  ),
                  SizedBox(width: 10 * sw),
                  Text(
                    'Commission Details',
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
                  padding: EdgeInsets.fromLTRB(16 * sw, 16 * sh, 16 * sw, 16 * sh),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _cardBg,
                          borderRadius: BorderRadius.circular(22 * sf),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(18 * sw, 18 * sh, 18 * sw, 18 * sh),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 39 * sf,
                                  backgroundColor: const Color(0xFF2F9A8F),
                                  child: Text(
                                    _initials(name),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22 * sf,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14 * sw),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: TextStyle(
                                          color: _titleColor,
                                          fontSize: 22 * sf,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 2 * sh),
                                      Text(
                                        role,
                                        style: TextStyle(
                                          color: _tealText,
                                          fontSize: 17 * sf,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16 * sw,
                                    vertical: 9 * sh,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isPending
                                        ? const Color(0xFF829896)
                                        : const Color(0xFF3FAF7F),
                                    borderRadius: BorderRadius.circular(22 * sf),
                                  ),
                                  child: Text(
                                    status,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17 * sf,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 18 * sh),
                            Divider(color: const Color(0xFFC8CDCC), thickness: 1, height: 1),
                            SizedBox(height: 22 * sh),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone_iphone_rounded,
                                  color: _iconGold,
                                  size: 40 / 1.2 * sf,
                                ),
                                SizedBox(width: 12 * sw),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number',
                                        style: TextStyle(
                                          color: const Color(0xFF7A8C8A),
                                          fontSize: 17 * sf,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 2 * sh),
                                      Text(
                                        phoneNumber,
                                        style: TextStyle(
                                          color: _tealText,
                                          fontSize: 20 * sf,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 22 * sh),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: _iconGold,
                                  size: 40 / 1.2 * sf,
                                ),
                                SizedBox(width: 12 * sw),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Address',
                                        style: TextStyle(
                                          color: const Color(0xFF7A8C8A),
                                          fontSize: 17 * sf,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 2 * sh),
                                      Text(
                                        address,
                                        style: TextStyle(
                                          color: _tealText,
                                          fontSize: 20 * sf,
                                          height: 1.2,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14 * sh),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _cardBg,
                          borderRadius: BorderRadius.circular(18 * sf),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(14 * sw, 14 * sh, 14 * sw, 10 * sh),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: _tealText,
                                  size: 19 * sf,
                                ),
                                SizedBox(width: 8 * sw),
                                Text(
                                  'Scheme Details',
                                  style: TextStyle(
                                    color: _titleColor,
                                    fontSize: 18 * sf,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10 * sh),
                            _schemeRow(
                              'Plan Duration',
                              '$planDurationMonths Months',
                              sw,
                              sh,
                              sf,
                            ),
                            _schemeRow(
                              'Monthly Contribution',
                              monthlyContribution,
                              sw,
                              sh,
                              sf,
                            ),
                            _schemeRow('Start Date', startDate, sw, sh, sf),
                          ],
                        ),
                      ),
                      SizedBox(height: 14 * sh),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _summaryBg,
                          borderRadius: BorderRadius.circular(18 * sf),
                        ),
                        padding: EdgeInsets.fromLTRB(16 * sw, 16 * sh, 16 * sw, 16 * sh),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18 * sf,
                                  backgroundColor: _iconGold,
                                  child: Image.asset(
                                    'assets/commission/graph_arrow.png',
                                    width: 24 * sf,
                                    height: 24 * sf,
                                    color: _tealText,
                                  ),
                                ),
                                SizedBox(width: 10 * sw),
                                Text(
                                  'Commission Summary',
                                  style: TextStyle(
                                    color: const Color(0xFFF2F6F5),
                                    fontSize: 17 * sf,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14 * sh),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _cardBg,
                                borderRadius: BorderRadius.circular(18 * sf),
                              ),
                              padding: EdgeInsets.fromLTRB(
                                16 * sw,
                                12 * sh,
                                16 * sw,
                                12 * sh,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total Commission Earned',
                                    style: TextStyle(
                                      color: const Color(0xFF7A8C8A),
                                      fontSize: 13 * sf,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8 * sh),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 17 * sf,
                                        backgroundColor: _iconGold,
                                        child: Icon(
                                          Icons.currency_rupee_rounded,
                                          color: Colors.white,
                                          size: 22 * sf,
                                        ),
                                      ),
                                      SizedBox(width: 10 * sw),
                                      Text(
                                        summaryTotal,
                                        style: TextStyle(
                                          color: _titleColor,
                                          fontSize: 48 / 1.2 * sf,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10 * sh),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _cardBg,
                                      borderRadius: BorderRadius.circular(18 * sf),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                      14 * sw,
                                      12 * sh,
                                      14 * sw,
                                      10 * sh,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Commission %',
                                          style: TextStyle(
                                            color: const Color(0xFF6D8080),
                                            fontSize: 13 * sf,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '$planDurationMonths months',
                                          style: TextStyle(
                                            color: const Color(0xFF6D8080),
                                            fontSize: 12 * sf,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 6 * sh),
                                        Text(
                                          summaryMetricValue,
                                          style: TextStyle(
                                            color: _titleColor,
                                            fontSize: 20 * sf,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10 * sw),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _cardBg,
                                      borderRadius: BorderRadius.circular(18 * sf),
                                    ),
                                    padding: EdgeInsets.fromLTRB(
                                      14 * sw,
                                      12 * sh,
                                      14 * sw,
                                      10 * sh,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Commission Type',
                                          style: TextStyle(
                                            color: const Color(0xFF6D8080),
                                            fontSize: 13 * sf,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 6 * sh),
                                        Text(
                                          '$summaryType\nContribution',
                                          style: TextStyle(
                                            color: _titleColor,
                                            fontSize: 18 * sf,
                                            height: 1.08,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14 * sh),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Contribution Breakdown',
                          style: TextStyle(
                            color: _titleColor,
                            fontSize: 18 * sf,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 10 * sh),
                      ...dynamicBreakdown.map(
                        (item) => Padding(
                          padding: EdgeInsets.only(bottom: 10 * sh),
                          child: _BreakdownTile(item: item, sw: sw, sh: sh, sf: sf),
                        ),
                      ),
                      SizedBox(height: 8 * sh),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E5EC),
                          borderRadius: BorderRadius.circular(16 * sf),
                        ),
                        padding: EdgeInsets.fromLTRB(14 * sw, 12 * sh, 14 * sw, 14 * sh),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: _iconGold,
                              size: 24 * sf,
                            ),
                            SizedBox(height: 10 * sh),
                            Text(
                              'Warning: Commission values are indicative and may change '
                              'after final monthly verification.',
                              style: TextStyle(
                                color: const Color(0xFF5E676A),
                                fontSize: 13 * sf,
                                height: 1.35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
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

  Widget _schemeRow(
    String label,
    String value,
    double sw,
    double sh,
    double sf,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF4F5B5A),
                  fontSize: 15 * sf,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: _titleColor,
                fontSize: 16 * sf,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8 * sh),
        const Divider(color: Color(0xFFC8CDCC), thickness: 1, height: 1),
        SizedBox(height: 8 * sh),
      ],
    );
  }

  String _initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  List<ContributionBreakdownItem> _buildDynamicBreakdown() {
    final DateTime start = _parseStartDate(startDate) ?? DateTime.now();
    final int countFromPercent = int.tryParse(summaryMetricValue) ?? 0;
    final int totalRows = countFromPercent > 0
        ? countFromPercent
        : (contributionBreakdown.isNotEmpty ? contributionBreakdown.length : 1);
    final List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final String defaultEarned = contributionBreakdown.isNotEmpty
        ? contributionBreakdown.first.commissionEarned
        : '800';

    return List<ContributionBreakdownItem>.generate(totalRows, (index) {
      final DateTime d = DateTime(start.year, start.month - index, 1);
      final String label = '${monthNames[d.month - 1]} ${d.year}';

      String earned = defaultEarned;
      for (final item in contributionBreakdown) {
        if (item.monthLabel == label) {
          earned = item.commissionEarned;
          break;
        }
      }

      return ContributionBreakdownItem(
        monthLabel: label,
        amount: monthlyContribution,
        commissionEarned: earned,
        isPending: isPending && index == 0,
      );
    });
  }

  DateTime? _parseStartDate(String input) {
    final parts = input.split(RegExp(r'[^0-9]+')).where((e) => e.isNotEmpty).toList();
    if (parts.length < 3) return null;
    final int? dd = int.tryParse(parts[0]);
    final int? mm = int.tryParse(parts[1]);
    final int? yyyy = int.tryParse(parts[2]);
    if (dd == null || mm == null || yyyy == null) return null;
    return DateTime(yyyy, mm, dd);
  }
}

class ContributionBreakdownItem {
  const ContributionBreakdownItem({
    required this.monthLabel,
    required this.amount,
    required this.commissionEarned,
    this.isPending = false,
  });

  final String monthLabel;
  final String amount;
  final String commissionEarned;
  final bool isPending;
}

class _BreakdownTile extends StatelessWidget {
  const _BreakdownTile({
    required this.item,
    required this.sw,
    required this.sh,
    required this.sf,
  });

  final ContributionBreakdownItem item;
  final double sw;
  final double sh;
  final double sf;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F4),
        borderRadius: BorderRadius.circular(18 * sf),
      ),
      padding: EdgeInsets.fromLTRB(14 * sw, 12 * sh, 14 * sw, 12 * sh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.monthLabel,
                  style: TextStyle(
                    color: const Color(0xFF1F6F66),
                    fontSize: 17 * sf,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (item.isPending)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14 * sw, vertical: 5 * sh),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F9592),
                    borderRadius: BorderRadius.circular(20 * sf),
                  ),
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12 * sf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(width: 8 * sw),
              Text(
                item.amount,
                style: TextStyle(
                  color: const Color(0xFF2F3E3F),
                  fontSize: 17 * sf,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6 * sh),
          Text(
            'Contribution Amount',
            style: TextStyle(
              color: const Color(0xFF5A6766),
              fontSize: 12 * sf,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8 * sh),
          const Divider(color: Color(0xFFC8CDCC), thickness: 1, height: 1),
          SizedBox(height: 8 * sh),
          Row(
            children: [
              Text(
                'Commision Earned',
                style: TextStyle(
                  color: const Color(0xFF5A6766),
                  fontSize: 12 * sf,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              CircleAvatar(
                radius: 10 * sf,
                backgroundColor: const Color(0xFFD7B152),
                child: Icon(
                  Icons.currency_rupee_rounded,
                  size: 12 * sf,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 3 * sw),
              Text(
                item.commissionEarned,
                style: TextStyle(
                  color: const Color(0xFF2A8A84),
                  fontSize: 35 / 2 * sf,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
