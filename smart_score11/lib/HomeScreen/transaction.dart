import 'package:flutter/material.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';
import '../widgets/custom_bottom_nav.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int _currentIndex = 3;
  String _selectedFilter = 'All';
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
              primary: Color(0xFF00AA5B),
              onPrimary: Colors.white,
              onSurface: Colors.black,
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

  void _showAddCreditsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Additional Credits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose a credit package to add to your\nsubscription',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                // Credit Package Tiles
                _buildCreditPackageTile('100 Credits', '₹10,000'),
                const SizedBox(height: 12),
                _buildCreditPackageTile('500 Credits', '₹50,000'),
                const SizedBox(height: 32),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8B0B0),
                        foregroundColor: Colors.black,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        'Purchase credits',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreditPackageTile(String title, String price) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Nunito',
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        toolbarHeight: 70 * scale,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          },
        ),
        title: Text(
          'Transaction',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20 * scale,
            fontFamily: 'Nunito',
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0 * scale),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom Balance Card
                  _buildBalanceCard(scale),
                  SizedBox(height: 12 * scale),

                  // Filters
                  _buildFilters(scale),
                  SizedBox(height: 24 * scale),

                  // Credit Checks Header
                  _buildCreditChecksHeader(scale),
                  SizedBox(height: 16 * scale),

                  // Summary Cards
                  _buildSummarySection(scale),
                  SizedBox(height: 24 * scale),

                  // Recent Transactions Header
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),

            // Recent Transactions List
            _buildRecentTransactionsList(scale),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(currentIndex: _currentIndex),
    );
  }

  Widget _buildBalanceCard(double scale) {
    return Container(
      width: 800 * scale,
      height: 160 * scale,
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16 * scale),
            child: Image.asset(
              'assets/icon/balance-bg.png',
              width: double.infinity,
              height: 180 * scale,
              fit: BoxFit.fill,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(20.0 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8 * scale),
                        Text(
                          'My Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14 * scale,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                    // Smart Score Logo Pill
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10 * scale,
                        vertical: 4 * scale,
                      ),
                      // decoration: BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.circular(20 * scale),
                      // ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/smartscore_logo.png',
                            // height: 35,
                            width: 80 * scale,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10 * scale),
                Text(
                  '₹ 2000.00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28 * scale,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: 8 * scale),
                Text(
                  'Used Credit - 1234',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  'Available Credit - 423',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14 * scale,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
          // Add Money Button
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                _showAddCreditsDialog();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12 * scale, right: 8 * scale),
                padding: EdgeInsets.symmetric(
                  horizontal: 18 * scale,
                  vertical: 8 * scale,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(8 * scale),
                ),
                child: Text(
                  'Add Money',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16 * scale,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(double scale) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterButton('All', scale, isFirst: true),
          SizedBox(width: 12 * scale),
          _buildFilterButton('Today', scale),
          SizedBox(width: 12 * scale),
          _buildFilterButton('This Week', scale),
          SizedBox(width: 12 * scale),
          _buildFilterButton('This Month', scale),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, double scale, {bool isFirst = false}) {
    bool isSelected = _selectedFilter == text;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = text),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24 * scale,
          vertical: 10 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00312F) : Colors.white,
          borderRadius: BorderRadius.circular(8 * scale),
          border: isSelected
              ? null
              : Border.all(color: const Color(0xFF00312F), width: 1.2),
        ),
        child: Row(
          children: [
            if (isFirst) ...[
              Icon(
                Icons.sort,
                color: isSelected ? Colors.white : const Color(0xFF00312F),
                size: 18 * scale,
              ),
              SizedBox(width: 8 * scale),
            ],
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14 * scale,
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditChecksHeader(double scale) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Credit Checks Transactions',
          style: TextStyle(
            fontSize: 16 * scale,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Nunito',
          ),
        ),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: EdgeInsets.all(8 * scale),
            decoration: const BoxDecoration(
              color: Color(0xFFE3F2FD),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              color: const Color(0xFF2196F3),
              size: 20 * scale,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(double scale) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard('16', 'Today', const [
                Color(0xFFE3F2FD),
                Color(0xFFD1C4E9),
              ], scale),
            ),
            SizedBox(width: 16 * scale),
            Expanded(
              child: _buildSummaryCard('122', 'This Week', const [
                Color(0xFFE0F7FA),
                Color(0xFFB2EBF2),
              ], scale),
            ),
          ],
        ),
        SizedBox(height: 16 * scale),
        _buildSummaryCard(
          '253',
          'This Month',
          const [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
          scale,
          isFullWidth: true,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String count,
    String label,
    List<Color> colors,
    double scale, {
    bool isFullWidth = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20 * scale),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(16 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              fontSize: 32 * scale,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B2C61),
              fontFamily: 'Nunito',
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14 * scale,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsList(double scale) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16 * scale),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16 * scale),
          padding: EdgeInsets.all(16 * scale),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12 * scale),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Credit Score Token',
                    style: TextStyle(
                      color: const Color(0xFF2979FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 16 * scale,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12 * scale,
                      vertical: 4 * scale,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA5F3D7),
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: Text(
                      'Completed',
                      style: TextStyle(
                        color: const Color(0xFF00AA5B),
                        fontSize: 12 * scale,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12 * scale),
              _buildTransactionRow('Date', '11/21/2025', scale),
              _buildTransactionRow(
                'Transactions ID',
                'PAY_20251208_001',
                scale,
              ),
              _buildTransactionRow('Amount', '2500', scale),
              SizedBox(height: 8 * scale),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTransactionRow('Payment Mode', 'UPI', scale),
                  Text(
                    'Credit Hit - 25',
                    style: TextStyle(
                      color: const Color(0xFF2979FF),
                      fontSize: 13 * scale,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionRow(String label, String value, double scale) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6 * scale),
      child: Text(
        '$label - $value',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14 * scale,
          fontWeight: FontWeight.w400,
          fontFamily: 'Nunito',
        ),
      ),
    );
  }
}
