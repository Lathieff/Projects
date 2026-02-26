import 'package:flutter/material.dart';
import 'select_brand.dart';
import 'package:truemotor/compare%20vechiles/compare_result.dart';
import 'dart:math';

const Color kPrimary = Color(0xFF005F65);
const Color kPurple = Color(0xFF7E3080);

// ─────────────────────────────────────────────────────────────
// Placeholder pages for + button navigation
// ─────────────────────────────────────────────────────────────
class SelectCarPage extends StatelessWidget {
  final String title;
  const SelectCarPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        title: Text(title, style: TextStyle(fontSize: w * 0.045)),
      ),
      body: Center(
        child: Text(
          'Select $title Page',
          style: TextStyle(fontSize: w * 0.05, color: kPrimary),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Main Compare Vehicle Screen
// ─────────────────────────────────────────────────────────────
class CompareVehicleScreen extends StatefulWidget {
  const CompareVehicleScreen({super.key});

  @override
  State<CompareVehicleScreen> createState() => _CompareVehicleScreenState();
}

class _CompareVehicleScreenState extends State<CompareVehicleScreen> {
  int _currentBottomIndex = 3; // Compare is at index 3 in screenshot
  String _selectedVehicle = 'Select Vehicle';
  bool _isVehicleDropdownExpanded = false;

  Map<String, dynamic>? _selectedCar1;
  Map<String, dynamic>? _selectedCar2;

  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'SUV',
    'Sedan',
    'Hatchback',
    'Electric/Hybrid',
  ];

  final List<Map<String, dynamic>> _popularComparisons = [
    {
      'car1': {
        'brand': 'Maruti Suzuki',
        'model': 'Swift',
        'price': '₹ 6.36 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/swift.png',
      },
      'car2': {
        'brand': 'Hyundai',
        'model': 'i10 Nios Sportz 1.2',
        'price': '₹ 8.49 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/hyndai_sportz.png',
      },
    },
  ];

  final List<Map<String, dynamic>> _categoryComparisons = [
    {
      'car1': {
        'brand': 'Maruti Suzuki',
        'model': 'Swift',
        'price': '₹ 6.36 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/swift.png',
      },
      'car2': {
        'brand': 'Hyundai',
        'model': 'i10 Nios Sportz 1.2',
        'price': '₹ 8.49 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/hyndai_sportz.png',
      },
    },
    {
      'car1': {
        'brand': 'Tata',
        'model': 'Nexon',
        'price': '₹ 8.10 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/swift.png',
      },
      'car2': {
        'brand': 'Kia',
        'model': 'Sonet',
        'price': '₹ 7.99 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/hyndai_sportz.png',
      },
    },
    {
      'car1': {
        'brand': 'Mahindra',
        'model': 'XUV300',
        'price': '₹ 7.99 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/swift.png',
      },
      'car2': {
        'brand': 'Hyundai',
        'model': 'Venue',
        'price': '₹ 7.89 Lakh',
        'fuel': 'Petrol',
        'image': 'assets/hyndai_sportz.png',
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final w = mq.size.width;
    final h = mq.size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: _buildAppBar(w),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopHero(w),
            _buildSelectVehicleSection(w, h),
            _buildAddCarsContainer(w, h),
            _buildBanner(w, 'assets/compare_banner.png'),
            _buildPopularCarsSection(w, h),
            _buildBanner(w, 'assets/compare_banner2.png'),
            _buildCategoryComparisonSection(w, h),
            _buildFAQSection(w, h),
            SizedBox(height: h * 0.03),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(w, h),
    );
  }

  PreferredSizeWidget _buildAppBar(double w) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF005F65)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Compare Vehicle',
        style: TextStyle(
          color: const Color(0xFF005F65),
          fontSize: w * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: const Color(0xFF005F65),
            size: w * 0.06,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTopHero(double w) {
    return Container(
      width: w,
      padding: EdgeInsets.all(w * 0.04),
      decoration: const BoxDecoration(color: Colors.white),
      child: Image.asset(
        'assets/compare_vs.png',
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          height: 150,
          color: Colors.grey.shade200,
          child: const Icon(Icons.image, size: 50),
        ),
      ),
    );
  }

  Widget _buildSelectVehicleSection(double w, double h) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
      color: Colors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isVehicleDropdownExpanded = !_isVehicleDropdownExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.04,
                vertical: h * 0.012,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(w * 0.03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedVehicle,
                    style: TextStyle(
                      fontSize: w * 0.038,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(
                    _isVehicleDropdownExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
          if (_isVehicleDropdownExpanded) ...[
            SizedBox(height: h * 0.005),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildVehicleTile('Car', w, h),
                _buildVehicleTile('Bike', w, h),
                _buildVehicleTile('EV Car', w, h),
                _buildVehicleTile('EV Bike', w, h),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildVehicleTile(String label, double w, double h) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicle = label;
          _isVehicleDropdownExpanded = false;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: h * 0.01),
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: h * 0.012,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(w * 0.03),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: w * 0.038, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildAddCarsContainer(double w, double h) {
    return Container(
      width: w,
      margin: EdgeInsets.all(w * 0.04),
      padding: EdgeInsets.all(w * 0.06),
      decoration: BoxDecoration(
        color: Colors.white, // Changed to white background
        borderRadius: BorderRadius.circular(w * 0.04),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Add Cars to Compare',
              style: TextStyle(
                color: Colors.black87, // Changed text to black
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: h * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCarSelectionSlot('Select Car', w, h, 1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF005F65), // Teal vs circle on white card
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'Vs',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildCarSelectionSlot('Select Car', w, h, 2),
            ],
          ),
          SizedBox(height: h * 0.03),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFF005F65,
                ), // Teal button on white card
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              onPressed: () {
                if (_selectedCar1 != null && _selectedCar2 != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompareResultPage(
                        car1: _selectedCar1!,
                        car2: _selectedCar2!,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select two cars to compare'),
                    ),
                  );
                }
              },
              child: const Text(
                'Compare Now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 15),
          if (_selectedCar1 != null || _selectedCar2 != null)
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCar1 = null;
                  _selectedCar2 = null;
                });
              },
              child: const Text(
                'Add new comparison',
                style: TextStyle(
                  color: Color(0xFF7E3080), // Purple link on white card
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCarSelectionSlot(String label, double w, double h, int index) {
    final selectedCar = index == 1 ? _selectedCar1 : _selectedCar2;

    if (selectedCar != null) {
      return Expanded(
        child: Column(
          children: [
            Image.asset(selectedCar['image'], height: 75, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              selectedCar['name'],
              style: const TextStyle(
                color: Colors.black, // Dark text on white card
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Text(
              'Alpha AGS',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              'Petrol',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SelectBrandPage()),
        );

        if (result != null && mounted) {
          setState(() {
            if (index == 1) {
              _selectedCar1 = result;
            } else {
              _selectedCar2 = result;
            }
          });
        }
      },
      child: Column(
        children: [
          Container(
            width: w * 0.2,
            height: w * 0.2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: Size(w * 0.2, w * 0.2),
                  painter: DottedCirclePainter(),
                ),
                Container(
                  width: w * 0.18,
                  height: w * 0.18,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color(0xFF7E3080),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(double w, String assetPath) {
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(w * 0.02),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildPopularCarsSection(double w, double h) {
    return _buildComparisonScrollList(
      w,
      h,
      'Popular Car Comparison',
      _popularComparisons,
    );
  }

  Widget _buildCategoryComparisonSection(double w, double h) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
          child: Text(
            'Car Comparison By Category',
            style: TextStyle(
              fontSize: w * 0.045,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 10),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedCategoryIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 25),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected ? kPurple : Colors.transparent,
                        width: 4,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.black54,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        _buildComparisonScrollList(w, h, null, _categoryComparisons),
      ],
    );
  }

  Widget _buildComparisonScrollList(
    double w,
    double h,
    String? title,
    List<Map<String, dynamic>> comparisons,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 10),
            child: Text(
              title,
              style: TextStyle(
                fontSize: w * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        SizedBox(
          height: 280,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: w * 0.04),
            scrollDirection: Axis.horizontal,
            itemCount: comparisons.length,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              final comp = comparisons[index];
              final car1 = comp['car1'];
              final car2 = comp['car2'];

              return Container(
                width: w * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    car1['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    car2['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: kPurple,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.compare_arrows,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: _buildCarDetails(car1)),
                          Container(width: 1, color: Colors.grey.shade100),
                          Expanded(child: _buildCarDetails(car2)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarDetails(Map<String, dynamic> car) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car['brand'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            car['model'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 6),
          Text(
            car['price'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            car['fuel'],
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
          const Spacer(),
          const Text(
            'Ex Showroom Price',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection(double w, double h) {
    final List<String> faqs = [
      'Where can I Sell my car?',
      'Which document are essential for selling my car?',
      'How soon will I receive payment after selling my car to True Motors?',
      'How long does it take to sell my car?',
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...faqs.map(
            (q) => Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                color: Colors.transparent, // Borderless and background-matched
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  q,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black87,
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(double w, double h) {
    final List<Map<String, dynamic>> items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.shopping_cart_outlined, 'label': 'Buy'},
      {'icon': Icons.sell_outlined, 'label': 'Sell'},
      {'icon': Icons.compare_arrows, 'label': 'Compare'},
    ];

    return Container(
      height: 70,
      decoration: const BoxDecoration(color: Color(0xFF005F65)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = _currentBottomIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _currentBottomIndex = index;
              });
            },
            child: _buildNavItem(item['icon'], item['label'], isSelected),
          );
        }),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isSelected ? Colors.white : Colors.white60, size: 24),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double dashWidth = 3;
    final double dashSpace = 3;
    final double circumference = 2 * pi * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = (i * (dashWidth + dashSpace)) / radius;
      final double sweepAngle = dashWidth / radius;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
