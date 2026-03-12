import 'package:flutter/material.dart';
import 'package:sales_erp/society/Commission/view_commission/cilent_commission_details.dart';
import 'package:sales_erp/widgets/status_bar.dart';

class ViewComissionListingPage extends StatefulWidget {
  const ViewComissionListingPage({super.key});

  static const Color headerColor = Color(0xFF1F6F66);
  static const Color pageBg = Color(0xFFEFEFEF);
  static const Color cardBg = Color(0xFFE7E7E7);
  static const Color titleColor = Color(0xFF334445);
  static const Color valueColor = Color(0xFF1F6F66);
  static const Color accentColor = Color(0xFFE1C16E);
  static const Color historyCardBg = Color(0xFFF3F4F4);

  static const List<_CommissionHistoryItem> historyItems = [
    _CommissionHistoryItem(
      name: 'Lakshmi Nair',
      role: 'Housewife',
      planMonths: 36,
      schemeType: 'Multiple',
      amount: '4,500',
      summaryTotal: '3200.00',
      summaryMetricValue: '4',
      monthlyContribution: '10,000',
      startDate: '19 - 12 -2026',
      status: 'Pending',
      contributionText: 'Contribution: February 2026',
      contributionBreakdown: [
        ContributionBreakdownItem(
          monthLabel: 'February 2026',
          amount: '10,000',
          commissionEarned: '800',
          isPending: true,
        ),
        ContributionBreakdownItem(
          monthLabel: 'January 2026',
          amount: '10,000',
          commissionEarned: '800',
        ),
        ContributionBreakdownItem(
          monthLabel: 'December 2025',
          amount: '10,000',
          commissionEarned: '800',
        ),
        ContributionBreakdownItem(
          monthLabel: 'November 2025',
          amount: '10,000',
          commissionEarned: '800',
        ),
      ],
      phoneNumber: '9876543210',
      address: '123 MG Road, Mumbai,\nMaharashtra',
      isPending: true,
    ),
    _CommissionHistoryItem(
      name: 'Jaden smith',
      role: 'Business Owner',
      planMonths: 72,
      schemeType: 'Single',
      amount: '1,500',
      summaryTotal: '2800.00',
      summaryMetricValue: '3',
      monthlyContribution: '15,000',
      startDate: '05 - 01 -2026',
      status: 'Credited',
      contributionText: 'Contribution: January 2026',
      contributionBreakdown: [
        ContributionBreakdownItem(
          monthLabel: 'January 2026',
          amount: '15,000',
          commissionEarned: '900',
        ),
        ContributionBreakdownItem(
          monthLabel: 'December 2025',
          amount: '15,000',
          commissionEarned: '900',
        ),
      ],
      phoneNumber: '9876501234',
      address: '45 Church Street, Bengaluru,\nKarnataka',
      isPending: false,
    ),
    _CommissionHistoryItem(
      name: 'Priya Sharma',
      role: 'Teacher',
      planMonths: 24,
      schemeType: 'Multiple',
      amount: '1,500',
      summaryTotal: '1500.00',
      summaryMetricValue: '2',
      monthlyContribution: '8,000',
      startDate: '11 - 02 -2026',
      status: 'Credited',
      contributionText: 'Contribution: January 2026',
      contributionBreakdown: [
        ContributionBreakdownItem(
          monthLabel: 'January 2026',
          amount: '8,000',
          commissionEarned: '500',
        ),
        ContributionBreakdownItem(
          monthLabel: 'December 2025',
          amount: '8,000',
          commissionEarned: '500',
        ),
      ],
      phoneNumber: '9988776655',
      address: '12 Anna Salai, Chennai,\nTamil Nadu',
      isPending: false,
    ),
    _CommissionHistoryItem(
      name: 'Anjali Mehta',
      role: 'Freelancer',
      planMonths: 36,
      schemeType: 'Single',
      amount: '1,500',
      summaryTotal: '2200.00',
      summaryMetricValue: '5',
      monthlyContribution: '12,000',
      startDate: '27 - 01 -2026',
      status: 'Credited',
      contributionText: 'Contribution: January 2026',
      contributionBreakdown: [
        ContributionBreakdownItem(
          monthLabel: 'January 2026',
          amount: '12,000',
          commissionEarned: '700',
        ),
        ContributionBreakdownItem(
          monthLabel: 'December 2025',
          amount: '12,000',
          commissionEarned: '700',
        ),
      ],
      phoneNumber: '9911223344',
      address: '88 C Scheme, Jaipur,\nRajasthan',
      isPending: false,
    ),
  ];

  @override
  State<ViewComissionListingPage> createState() => _ViewComissionListingPageState();
}

class _ViewComissionListingPageState extends State<ViewComissionListingPage> {
  static const List<int> _durationOptions = [12, 24, 36, 48, 72];
  static const List<String> _typeOptions = ['Multiple', 'Single'];

  final TextEditingController _searchController = TextEditingController();
  bool _showFilters = false;
  int? _selectedDuration;
  String? _selectedType;
  int? _appliedDuration;
  String? _appliedType;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_CommissionHistoryItem> get _filteredItems {
    return ViewComissionListingPage.historyItems.where((item) {
      final bool matchesDuration =
          _appliedDuration == null || item.planMonths == _appliedDuration;
      final bool matchesType = _appliedType == null || item.schemeType == _appliedType;
      final String q = _searchQuery.trim().toLowerCase();
      final bool matchesSearch = q.isEmpty ||
          item.name.toLowerCase().contains(q) ||
          item.phoneNumber.toLowerCase().contains(q) ||
          item.contributionText.toLowerCase().contains(q) ||
          item.amount.toLowerCase().contains(q);
      return matchesDuration && matchesType && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double sw = (size.width / 430).clamp(0.82, 1.25);
    final double sh = (size.height / 932).clamp(0.8, 1.2);
    final double sf = (sw < sh ? sw : sh).clamp(0.85, 1.2);

    return StatusBarWrapper(
      statusBarColor: ViewComissionListingPage.headerColor,
      iconBrightness: Brightness.light,
      child: Scaffold(
        backgroundColor: ViewComissionListingPage.pageBg,
        body: Column(
          children: [
            const CustomStatusBar(
              backgroundColor: ViewComissionListingPage.headerColor,
              iconBrightness: Brightness.light,
            ),
            Container(
              height: 76 * sh,
              width: double.infinity,
              color: ViewComissionListingPage.headerColor,
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
                  padding: EdgeInsets.fromLTRB(16 * sw, 20 * sh, 16 * sw, 20 * sh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60 * sh,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F1F1),
                          borderRadius: BorderRadius.circular(13 * sf),
                          border: Border.all(color: const Color(0xFFB9BEBD)),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8 * sw),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF334445),
                                fontSize: 15 * sf,
                                fontWeight: FontWeight.w400,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                hintText: 'Search by name , mobile , Id',
                                hintStyle: TextStyle(
                                  color: const Color(0xFF7B8D8C),
                                  fontSize: 18 * sf,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8 * sw),
                              child: Icon(
                                Icons.search,
                                color: ViewComissionListingPage.valueColor,
                                size: 26 * sf,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 22 * sh),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                        child: Container(
                          height: 45 * sh,
                          width: 115 * sw,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(7 * sf),
                            border: Border.all(color: const Color(0xFF9EA7A6)),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 14 * sw),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_list_rounded,
                                color: ViewComissionListingPage.titleColor,
                                size: 33 * sf,
                              ),
                              SizedBox(width: 10 * sw),
                              Text(
                                'Filter',
                                style: TextStyle(
                                  color: ViewComissionListingPage.titleColor,
                                  fontSize: 15 * sf,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_showFilters) ...[
                        SizedBox(height: 10 * sh),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ViewComissionListingPage.cardBg,
                            borderRadius: BorderRadius.circular(12 * sf),
                          ),
                          padding: EdgeInsets.fromLTRB(14 * sw, 14 * sh, 14 * sw, 14 * sh),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Scheme Duration',
                                style: TextStyle(
                                  color: ViewComissionListingPage.valueColor,
                                  fontSize: 18 * sf,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12 * sh),
                              Wrap(
                                spacing: 10 * sw,
                                runSpacing: 10 * sh,
                                children: _durationOptions.map((months) {
                                  final bool selected = _selectedDuration == months;
                                  return _FilterChipBox(
                                    label: '$months months',
                                    selected: selected,
                                    sw: sw,
                                    sh: sh,
                                    sf: sf,
                                    onTap: () {
                                      setState(() {
                                        _selectedDuration = selected ? null : months;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20 * sh),
                              Text(
                                'Scheme Duration',
                                style: TextStyle(
                                  color: ViewComissionListingPage.valueColor,
                                  fontSize: 18 * sf,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 12 * sh),
                              Wrap(
                                spacing: 10 * sw,
                                runSpacing: 10 * sh,
                                children: _typeOptions.map((type) {
                                  final bool selected = _selectedType == type;
                                  return _FilterChipBox(
                                    label: type,
                                    selected: selected,
                                    sw: sw,
                                    sh: sh,
                                    sf: sf,
                                    onTap: () {
                                      setState(() {
                                        _selectedType = selected ? null : type;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 22 * sh),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedDuration = null;
                                        _selectedType = null;
                                        _appliedDuration = null;
                                        _appliedType = null;
                                      });
                                    },
                                    child: Text(
                                      'Clear all filters',
                                      style: TextStyle(
                                        color: const Color(0xFF7E9593),
                                        fontSize: 14 * sf,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16 * sw),
                                  Expanded(
                                    child: SizedBox(
                                      height: 50 * sh,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _appliedDuration = _selectedDuration;
                                            _appliedType = _selectedType;
                                            _showFilters = false;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              ViewComissionListingPage.valueColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14 * sf),
                                          ),
                                        ),
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17 * sf,
                                            fontWeight: FontWeight.w600,
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
                      ],
                      SizedBox(height: 26 * sh),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ViewComissionListingPage.cardBg,
                          borderRadius: BorderRadius.circular(22 * sf),
                        ),
                        padding: EdgeInsets.fromLTRB(18 * sw, 18 * sh, 18 * sw, 18 * sh),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 18 * sf,
                                  backgroundColor: ViewComissionListingPage.accentColor,
                                  child: Image.asset(
                                    'assets/commission/graph_arrow.png',
                                    width: 24 * sf,
                                    height: 24 * sf,
                                    color: ViewComissionListingPage.headerColor,
                                  ),
                                ),
                                SizedBox(width: 12 * sw),
                                Text(
                                  'Total Commission Earned',
                                  style: TextStyle(
                                    color: ViewComissionListingPage.titleColor,
                                    fontSize: 20 * sf,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16 * sh),
                            Text(
                              '5000.00',
                              style: TextStyle(
                                color: ViewComissionListingPage.valueColor,
                                fontSize: 41 * sf,
                                height: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 10 * sh),
                            Text(
                              'From 6 commissions',
                              style: TextStyle(
                                color: const Color(0xFF586564),
                                fontSize: 13 * sf,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14 * sh),
                      Text(
                        'Commissions History',
                        style: TextStyle(
                          color: ViewComissionListingPage.titleColor,
                          fontSize: 17 * sf,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 10 * sh),
                      ...(_filteredItems.isEmpty
                          ? [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(
                                  top: 8 * sh,
                                  bottom: 20 * sh,
                                ),
                                child: Column(
                                  children: [
                                    const Divider(
                                      color: Color(0xFFD8DDDC),
                                      thickness: 1,
                                    ),
                                    SizedBox(height: 18 * sh),
                                    Text(
                                      'No history available',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF5A6766),
                                        fontSize: 18 * sf,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]
                          : _filteredItems
                              .map(
                                (item) => Padding(
                                  padding: EdgeInsets.only(bottom: 14 * sh),
                                  child: _HistoryCard(
                                    item: item,
                                    sw: sw,
                                    sh: sh,
                                    sf: sf,
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ClientCommissionDetailsPage(
                                            name: item.name,
                                            role: item.role,
                                            status: item.status,
                                            phoneNumber: item.phoneNumber,
                                            address: item.address,
                                            planDurationMonths: item.planMonths,
                                            monthlyContribution:
                                                item.monthlyContribution,
                                            startDate: item.startDate,
                                            summaryTotal: item.summaryTotal,
                                            summaryMetricValue:
                                                item.summaryMetricValue,
                                            summaryType: item.schemeType,
                                            contributionBreakdown:
                                                item.contributionBreakdown,
                                            isPending: item.isPending,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                              .toList()),
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
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.item,
    required this.sw,
    required this.sh,
    required this.sf,
    required this.onTap,
  });

  final _CommissionHistoryItem item;
  final double sw;
  final double sh;
  final double sf;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ViewComissionListingPage.historyCardBg,
          borderRadius: BorderRadius.circular(18 * sf),
        ),
        padding: EdgeInsets.fromLTRB(16 * sw, 14 * sh, 16 * sw, 12 * sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18 * sf,
                  backgroundColor: const Color(0xFF2F9A8F),
                  child: Text(
                    _initials(item.name),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14 * sf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 12 * sw),
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: const Color(0xFF2D3B3C),
                      fontSize: 18 * sf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: const Color(0xFF1F6F66),
                  size: 30 * sf,
                ),
              ],
            ),
            SizedBox(height: 4 * sh),
            Padding(
              padding: EdgeInsets.only(left: 34 * sw),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 14 * sf,
                    color: const Color(0xFF6E7B79),
                  ),
                  SizedBox(width: 5 * sw),
                  Text(
                    '${item.planMonths} Months Plan',
                    style: TextStyle(
                      color: const Color(0xFF6E7B79),
                      fontSize: 13 * sf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6 * sh),
            Padding(
              padding: EdgeInsets.only(left: 34 * sw),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 13 * sf,
                    backgroundColor: const Color(0xFFE1C16E),
                    child: Icon(
                      Icons.currency_rupee_rounded,
                      color: Colors.white,
                      size: 16 * sf,
                    ),
                  ),
                  SizedBox(width: 6 * sw),
                  Text(
                    item.amount,
                    style: TextStyle(
                      color: const Color(0xFF1F6F66),
                      fontSize: 30 * sf,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 8 * sw),
                  Text(
                    'Total commission',
                    style: TextStyle(
                      color: const Color(0xFF95A09E),
                      fontSize: 13 * sf,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8 * sh),
            Padding(
              padding: EdgeInsets.only(left: 34 * sw),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 13 * sw, vertical: 5 * sh),
                decoration: BoxDecoration(
                  color: item.isPending
                      ? const Color(0xFF7A8E8B)
                      : const Color(0xFF3FAF7F),
                  borderRadius: BorderRadius.circular(20 * sf),
                ),
                child: Text(
                  item.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12 * sf,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12 * sh),
            Divider(color: const Color(0xFFD8DDDC), thickness: 1, height: 1 * sh),
            SizedBox(height: 12 * sh),
            Text(
              item.contributionText,
              style: TextStyle(
                color: const Color(0xFF5A6766),
                fontSize: 13 * sf,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String fullName) {
    final parts = fullName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

class _FilterChipBox extends StatelessWidget {
  const _FilterChipBox({
    required this.label,
    required this.selected,
    required this.sw,
    required this.sh,
    required this.sf,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final double sw;
  final double sh;
  final double sf;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15 * sw, vertical: 9 * sh),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE1C16E) : const Color(0xFFF1F4F3),
          borderRadius: BorderRadius.circular(8 * sf),
          border: Border.all(
            color: selected ? const Color(0xFFE1C16E) : const Color(0xFF8AA2A0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFF2E3D3E),
            fontSize: 16 * sf,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _CommissionHistoryItem {
  const _CommissionHistoryItem({
    required this.name,
    required this.role,
    required this.planMonths,
    required this.schemeType,
    required this.amount,
    required this.summaryTotal,
    required this.summaryMetricValue,
    required this.monthlyContribution,
    required this.startDate,
    required this.status,
    required this.contributionText,
    required this.contributionBreakdown,
    required this.phoneNumber,
    required this.address,
    required this.isPending,
  });

  final String name;
  final String role;
  final int planMonths;
  final String schemeType;
  final String amount;
  final String summaryTotal;
  final String summaryMetricValue;
  final String monthlyContribution;
  final String startDate;
  final String status;
  final String contributionText;
  final List<ContributionBreakdownItem> contributionBreakdown;
  final String phoneNumber;
  final String address;
  final bool isPending;
}
