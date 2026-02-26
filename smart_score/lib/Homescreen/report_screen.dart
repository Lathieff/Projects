import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';
import 'package:smart_score/widgets/custom_bottom_nav.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final int _currentIndex = 2; // Report tab index
  bool _isDropdownExpanded = false;
  String _selectedReportType = '';
  bool _showResults = false;
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2672F5),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2672F5),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // Transparent to show gradient
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
        title: const Text(
          'Report',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sort By Button (Top)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: _buildSortButton(screenWidth),
            ),

            // Select Report Box (Full Width)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isDropdownExpanded = !_isDropdownExpanded;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedReportType.isEmpty
                            ? 'Select Report'
                            : _selectedReportType,
                        style: TextStyle(
                          color: _selectedReportType.isEmpty
                              ? Colors.grey
                              : Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF1E2B58), // Purple arrow
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dropdown Options (Positioned between Report and Date boxes)
            if (_isDropdownExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  margin: const EdgeInsets.only(top: 4, bottom: 4),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E2B58),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildDropdownItem('Credit score Report', () {
                        setState(() {
                          _selectedReportType = 'Credit score Report';
                          _isDropdownExpanded = false;
                          _showResults = false;
                        });
                      }),
                      const Divider(color: Colors.white24, height: 1),
                      _buildDropdownItem('Transaction Report', () {
                        setState(() {
                          _selectedReportType = 'Transaction Report';
                          _isDropdownExpanded = false;
                          _showResults = false;
                        });
                      }),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // Select Date Box (Full Width)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF1B2C61)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "October", // As per image placeholder or logic
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFF1B2C61),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Search Button (Rectangular with custom color #1B2C61)
            Center(
              child: SizedBox(
                width: screenWidth * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showResults = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B2C61),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Content Area (Hidden until Search clicked)
            if (_showResults) ...[
              const Divider(color: Colors.grey, thickness: 0.5),
              if (_selectedReportType == 'Credit score Report')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    'October month Credit Score Report',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              const SizedBox(height: 12),

              _selectedReportType == 'Credit score Report'
                  ? CreditScoreView()
                  : TransactionView(),
            ],

            const SizedBox(height: 80), // Bottom padding
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: _currentIndex),
    );
  }

  Widget _buildSortButton(double screenWidth) {
    return Material(
      color: const Color(0xFb4B98ED), // Color Updated
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {
          // Placeholder for sort functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sort functionality not implemented yet'),
            ),
          );
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: screenWidth * 0.25, // Responsive width
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.sort, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'sort by',
                style: TextStyle(color: Colors.white, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Credit Score View
// -----------------------------------------------------------------------------

class CreditScoreView extends StatelessWidget {
  CreditScoreView({super.key});

  final List<Map<String, String>> reportData = [
    {
      'name': 'Harish',
      'email': 'harish123@gmail.com',
      'phone': '9876543210',
      'type': 'Individual',
      'score': '700',
      'change': '-1',
      'address': 'Coimbatore',
    },
    {
      'name': 'Rahul',
      'email': 'rahul.s@gmail.com',
      'phone': '9123456780',
      'type': 'Business',
      'score': '750',
      'change': '+5',
      'address': 'Chennai',
    },
    {
      'name': 'Anish',
      'email': 'anish88@gmail.com',
      'phone': '9988776655',
      'type': 'Individual',
      'score': '680',
      'change': '-3',
      'address': 'Bangalore',
    },
    {
      'name': 'Priya',
      'email': 'priya.k@gmail.com',
      'phone': '9445566778',
      'type': 'Individual',
      'score': '720',
      'change': '+2',
      'address': 'Hyderabad',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reportData.length,
      itemBuilder: (context, index) {
        final data = reportData[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListItem(Icons.person_outline, data['name']!),
              _buildListItem(Icons.email_outlined, data['email']!),
              _buildListItem(Icons.phone_android, data['phone']!),
              _buildListItem(
                Icons.chat_bubble_outline,
                'Type : ${data['type']}',
              ),
              _buildListItem(
                Icons.credit_card,
                'Credit Score : ${data['score']}',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    _showDetailsDialog(context, data);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Full Detail ',
                        style: TextStyle(
                          color: Color(0xFF1B2C61),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(
                        Icons.double_arrow,
                        size: 10,
                        color: Color(0xFF1B2C61),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDetailsDialog(BuildContext context, Map<String, String> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Individual Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Complete information for selected individual',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Score Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0056D2), // Dark Blue
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Current Credit Score',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['score']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  int.parse(data['score']!) >= 700
                                      ? 'Good'
                                      : 'Fair',
                                  style: const TextStyle(
                                    color: Color(0xFF2672F5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    data['change']!.startsWith('-')
                                        ? Icons.south_east
                                        : Icons.north_east,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  Text(
                                    '${data['change']} points',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Details List
                _buildPopupDetail('Name', data['name']!),
                _buildPopupDetail('Email', data['email']!),
                _buildPopupDetail('Mobile No', data['phone']!),
                _buildPopupDetail('Address', data['address']!),
                _buildPopupDetail('User Type', data['type']!),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF1B2C61)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Transaction View
// -----------------------------------------------------------------------------

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  // Dynamic Data
  final double totalCredits = 1000;
  final double usedCredits = 200;
  final double remainingCredits = 800;

  final List<Map<String, String>> reportData = [
    {
      'name': 'Harish',
      'email': 'harish123@gmail.com',
      'phone': '9876543210',
      'type': 'Individual',
      'score': '720',
      'change': '+2',
      'address': 'Coimbatore',
    },
    {
      'name': 'Suresh',
      'email': 'suresh.kumar@gmail.com',
      'phone': '9845671234',
      'type': 'Individual',
      'score': '650',
      'change': '-5',
      'address': 'Salem',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Card Row
          _buildStatsRow(),
          const SizedBox(height: 24),

          // Chart Section
          _buildChartSection(screenWidth),
          const SizedBox(height: 24),
          // List Section (Matches Screenshot)
          const Text(
            'Recently Checked CIBIL Score',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          _buildCibilList(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard('Total credits', '${totalCredits.toInt()}'),
        ),
        const SizedBox(width: 12),
        Expanded(child: _buildStatCard('Used', '${usedCredits.toInt()}')),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard('Remaining', '${remainingCredits.toInt()}'),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEEE),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection(double screenWidth) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFFFAFA), Color(0xFFFFF4F4)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Credits Remaining',
            style: TextStyle(
              color: Color(0xFF2672F5),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: CustomPaint(
              painter: DonutChartPainter(
                total: totalCredits,
                used: usedCredits,
                remaining: remainingCredits,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(
                const Color(0xFF1AB306),
                'Remaining - ${remainingCredits.toInt()}',
              ),
              const SizedBox(width: 24),
              _buildLegendItem(
                const Color(0xFFD92929),
                'Used - ${usedCredits.toInt()}',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCibilList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reportData.length,
      itemBuilder: (context, index) {
        final data = reportData[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListItem(Icons.person_outline, data['name']!),
              _buildListItem(Icons.email_outlined, data['email']!),
              _buildListItem(Icons.phone_android, data['phone']!),
              _buildListItem(Icons.credit_card, 'Type : ${data['type']}'),
              _buildListItem(Icons.speed, 'Credit Score : ${data['score']}'),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    _showDetailsDialog(context, data);
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Full Detail ',
                        style: TextStyle(
                          color: Color(0xFF1B2C61),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Icon(
                        Icons.double_arrow,
                        size: 10,
                        color: Color(0xFF1B2C61),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF1B2C61)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Map<String, String> data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Individual Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Complete information for selected individual',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Score Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0056D2), // Dark Blue
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Current Credit Score',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['score']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  int.parse(data['score']!) >= 700
                                      ? 'Good'
                                      : 'Fair',
                                  style: const TextStyle(
                                    color: Color(0xFF2672F5),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    data['change']!.startsWith('-')
                                        ? Icons.south_east
                                        : Icons.north_east,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  Text(
                                    '${data['change']} points',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Details List
                _buildPopupDetail('Name', data['name']!),
                _buildPopupDetail('Email', data['email']!),
                _buildPopupDetail('Mobile No', data['phone']!),
                _buildPopupDetail('Address', data['address']!),
                _buildPopupDetail('User Type', data['type']!),

                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopupDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Donut Chart Painter
// -----------------------------------------------------------------------------

class DonutChartPainter extends CustomPainter {
  final double total;
  final double used;
  final double remaining;

  DonutChartPainter({
    required this.total,
    required this.used,
    required this.remaining,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) * 0.35;
    final strokeWidth = 50.0;

    final rect = Rect.fromCircle(center: center, radius: radius);

    final paintGreen = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = const Color(0xFF1AB306);

    final paintRed = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = const Color(0xFFD92929);

    // Calculate angles
    final totalAngle = 2 * pi;
    final usedAngle = (used / total) * totalAngle;
    final remainingAngle = (remaining / total) * totalAngle;

    // Rotation logic:
    // We want the Red (Used) segment to be centered at the bottom right (pi/4).
    final redStartAngle = (pi / 4) - (usedAngle / 2);

    // The Green (Remaining) segment should fill the rest.
    final greenStartAngle = redStartAngle + usedAngle;

    // Draw Green (Remaining)
    canvas.drawArc(rect, greenStartAngle, remainingAngle, false, paintGreen);

    // Draw Red (Used)
    canvas.drawArc(rect, redStartAngle, usedAngle, false, paintRed);

    // Draw Arrows and Labels
    // Green Label
    final greenMidAngle = greenStartAngle + (remainingAngle / 2);
    _drawLabelWithArrow(
      canvas,
      center,
      radius,
      strokeWidth,
      greenMidAngle,
      const Color(0xFF1AB306),
      'Remaining-${remaining.toInt()}',
      isGreen: true,
    );

    // Red Label
    final redMidAngle = redStartAngle + (usedAngle / 2);
    _drawLabelWithArrow(
      canvas,
      center,
      radius,
      strokeWidth,
      redMidAngle,
      const Color(0xFFD92929),
      'Used-${used.toInt()}',
      isGreen: false,
    );
  }

  void _drawLabelWithArrow(
    Canvas canvas,
    Offset center,
    double radius,
    double strokeWidth,
    double angle,
    Color color,
    String text, {
    required bool isGreen,
  }) {
    final outerRadius = radius + strokeWidth / 2;

    final arrowStart = Offset(
      center.dx + outerRadius * cos(angle),
      center.dy + outerRadius * sin(angle),
    );

    // Reduced line length to keep text inside
    final lineLength = 15.0;

    final endPoint = Offset(
      center.dx + (outerRadius + lineLength) * cos(angle),
      center.dy + (outerRadius + lineLength) * sin(angle),
    );

    final paintArrow = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(arrowStart, endPoint, paintArrow);

    // Draw Arrow Head
    final arrowHeadSize = 6.0;
    final arrowAngle = atan2(
      endPoint.dy - arrowStart.dy,
      endPoint.dx - arrowStart.dx,
    );

    final path = Path();
    path.moveTo(endPoint.dx, endPoint.dy);
    path.lineTo(
      endPoint.dx - arrowHeadSize * cos(arrowAngle - pi / 6),
      endPoint.dy - arrowHeadSize * sin(arrowAngle - pi / 6),
    );
    path.moveTo(endPoint.dx, endPoint.dy);
    path.lineTo(
      endPoint.dx - arrowHeadSize * cos(arrowAngle + pi / 6),
      endPoint.dy - arrowHeadSize * sin(arrowAngle + pi / 6),
    );

    canvas.drawPath(path, paintArrow);

    // Draw Text
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    // Calculate hyphen position for alignment
    final hyphenIndex = text.indexOf('-');
    double hyphenCenter = textPainter.width / 2;
    if (hyphenIndex != -1) {
      final prefixPainter = TextPainter(
        text: TextSpan(
          text: text.substring(0, hyphenIndex),
          style: textSpan.style,
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      final hyphenPartPainter = TextPainter(
        text: TextSpan(text: '-', style: textSpan.style),
        textDirection: TextDirection.ltr,
      )..layout();

      hyphenCenter = prefixPainter.width + (hyphenPartPainter.width / 2);
    }

    // Determine radial offset to keep text away from arrow tip
    const double radialGap = 15.0;
    final double labelCenterX = endPoint.dx + radialGap * cos(angle);
    final double labelCenterY = endPoint.dy + radialGap * sin(angle);

    // Paint text anchored at the hyphen's center
    textPainter.paint(
      canvas,
      Offset(
        labelCenterX - hyphenCenter,
        labelCenterY - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
