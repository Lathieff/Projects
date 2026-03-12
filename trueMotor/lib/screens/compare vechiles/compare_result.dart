import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/widgets/bottom_navigation.dart';

class CompareResultPage extends StatefulWidget {
  final Map<String, dynamic> car1;
  final Map<String, dynamic> car2;

  const CompareResultPage({super.key, required this.car1, required this.car2});

  @override
  State<CompareResultPage> createState() => _CompareResultPageState();
}

class _CompareResultPageState extends State<CompareResultPage> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = [
    'Basic Information',
    'Engine & Transmission',
    'Fuel & Performance',
  ];

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Reverted to white background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF005F65)),
          onPressed: _goToHome,
        ),
        title: const Text(
          'Compare Vehicle',
          style: TextStyle(
            color: Color(0xFF005F65),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF005F65)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Comparison Images with Split Background
            _buildTopImages(w),

            // Car Names Row
            _buildCarNamesRow(w),

            // Info Tabs with Gradient Background
            _buildInfoTabs(w),

            // Spec Table based on selected tab
            _buildSpecSection(w),

            // Ad Banner
            _buildAdBanner(w),

            // Expandable Sections (Always show, but categories react to tabs)
            _buildExpandableSpecs(w),

            // Latest News & Updates
            _buildLatestNewsSection(w),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildTopImages(double w) {
    return SizedBox(
      height: 180,
      width: w,
      child: Row(
        children: [
          // Left Side - Red
          Expanded(
            child: Container(
              color: const Color(0xFFE56B6B),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/swift.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Side - Dark Grey
          Expanded(
            child: Container(
              color: const Color(0xFF4A4A4A),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/curvv.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Positioned(
                    top: 15,
                    right: 15,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 28,
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

  Widget _buildCarNamesRow(double w) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Maruti Suzuki Baleno',
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            'TATA Curvv',
            style: TextStyle(
              fontSize: w * 0.04,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTabs(double w) {
    return Container(
      height: 55,
      width: w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFF9DB), Color(0xFFFFECB3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(
                        bottom: BorderSide(color: Color(0xFF7E3080), width: 3),
                      )
                    : null,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                _tabs[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? Colors.black : Colors.black87,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTableContent(Map<String, List<String>> specs) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
      ),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300, width: 0.5),
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.5),
        },
        children: specs.entries.map((entry) {
          return TableRow(
            children: [
              _buildTableCell(entry.key, isTitle: true),
              _buildTableCell(entry.value[0]),
              _buildTableCell(entry.value[1]),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSpecSection(double w) {
    // Determine which data to show based on selected tab
    Map<String, List<String>> specs;
    if (_selectedTabIndex == 1) {
      specs = {
        'Engine Type': ['Z12E', '1.2 Revotron'],
        'Displacement (cc)': ['1197', '1199'],
        'No of Cylinders': ['3', '3'],
        'Transmission Type': ['Manual', 'Manual'],
      };
    } else if (_selectedTabIndex == 2) {
      specs = {
        'Fuel Type': ['Petrol', 'Petrol'],
        'Mileage (kmpl)': ['24.8', '20.9'],
        'Fuel Tank Capacity': ['37', '37'],
        'Emission Norm': ['BS VI 2.0', 'BS VI 2.0'],
      };
    } else {
      specs = {
        'Price': ['₹ 9.2 Lakh', '₹ 10.2 Lakh'],
        'Seating': ['5', '5'],
        'Mileage': ['20.1', '18.1'],
        'Engine': ['2393cc', '1987cc'],
        'Fuel': ['Petrol', 'Petrol'],
        'Transmission': ['Manual', 'Automatic'],
      };
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: _buildTableContent(specs),
    );
  }

  Widget _buildTableCell(String text, {bool isTitle = false}) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: isTitle
              ? Colors.black
              : const Color(0xFF0033A0), // Dark Blue for values
          fontWeight: isTitle ? FontWeight.w500 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildAdBanner(double w) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: w,
      child: Image.asset('assets/compare_banner.png', fit: BoxFit.cover),
    );
  }

  Widget _buildExpandableSpecs(double w) {
    final List<String> categories = [
      'Engine & Transmission',
      'Fuel & Performance',
      'Safety & Security',
      'Interior',
      'Exterior',
    ];

    return Column(
      children: categories.map((cat) {
        final bool isSyncCategory =
            cat == 'Engine & Transmission' || cat == 'Fuel & Performance';
        final int targetTabIndex = cat == 'Engine & Transmission' ? 1 : 2;
        final bool isExpanded =
            (_selectedTabIndex == 1 && cat == 'Engine & Transmission') ||
            (_selectedTabIndex == 2 && cat == 'Fuel & Performance');

        // Logic for which table to show inside
        Map<String, List<String>>? specs;
        if (cat == 'Engine & Transmission') {
          specs = {
            'Engine Type': ['Z12E', '1.2 Revotron'],
            'Displacement (cc)': ['1197', '1199'],
            'No of Cylinders': ['3', '3'],
            'Transmission Type': ['Manual', 'Manual'],
          };
        } else if (cat == 'Fuel & Performance') {
          specs = {
            'Fuel Type': ['Petrol', 'Petrol'],
            'Mileage (kmpl)': ['24.8', '20.9'],
            'Fuel Tank Capacity': ['37', '37'],
            'Emission Norm': ['BS VI 2.0', 'BS VI 2.0'],
          };
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
          ),
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              key:
                  UniqueKey(), // Forces rebuild to reflect external state changes (tabs)
              initiallyExpanded: isExpanded,
              onExpansionChanged: (val) {
                if (val && isSyncCategory) {
                  setState(() => _selectedTabIndex = targetTabIndex);
                }
              },
              title: Text(
                cat,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              trailing: Icon(
                isExpanded ? Icons.remove : Icons.add,
                color: Colors.black54,
                size: 20,
              ),
              childrenPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              children: [
                if (specs != null)
                  _buildTableContent(specs)
                else
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Detailed specifications...',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLatestNewsSection(double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Latest News & Updates',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              _buildNewsCard(
                'The Maruti Suzuki e VITARA is equipped with an armada of safety features.',
                'vitara.png',
              ),
              _buildNewsCard(
                'The Maruti Suzuki Jimny is equipped with an armada of safety features.',
                'jimmy.png',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewsCard(String description, String image) {
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/$image',
              height: 90,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          const Text(
            'Learn More.......',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF7E3080),
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}
