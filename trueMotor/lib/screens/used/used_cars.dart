import 'dart:async';
import 'package:flutter/material.dart';
import 'package:truemotor/screens/used/car_details.dart';

class UsedCarsScreen extends StatefulWidget {
  const UsedCarsScreen({super.key});

  @override
  State<UsedCarsScreen> createState() => _UsedCarsScreenState();
}

class _UsedCarsScreenState extends State<UsedCarsScreen> {
  late PageController _bannerController;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;
  final int _bannerTotalItems = 10000;
  final List<String> _bannerImages = const [
    'assets/home_banner.png',
    'assets/compare_banner.png',
    'assets/compare_banner2.png',
  ];

  int _hintIndex = 0;
  late Timer _hintTimer;
  final List<String> _hints = const [
    'Price',
    'Fuel Type',
    'Owner Count',
    'Transmission',
    'Body Type',
    'Kms Driven',
    'Year',
  ];

  String _selectedCategory = 'Budget';
  final Map<String, dynamic> _selectedFilters = {
    'Budget': null,
    'Brand': <String>[],
    'Fuel type': <String>[],
    'Transmission': <String>[],
    'Body type': <String>[],
    'Seater': <String>[],
    'Ownership': <String>[],
    'Year': <String>[],
    'RTO': <String>[],
    'Colors': <String>[],
  };

  final List<String> _categories = const [
    'Budget',
    'Brand',
    'Fuel type',
    'Transmission',
    'Body type',
    'Seater',
    'Ownership',
    'Year',
    'RTO',
    'Colors',
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = PageController(initialPage: _bannerTotalItems ~/ 2);
    _currentBannerIndex = (_bannerTotalItems ~/ 2) % _bannerImages.length;
    _hintTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() => _hintIndex = (_hintIndex + 1) % _hints.length);
    });
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (mounted && _bannerController.hasClients) {
        _bannerController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _hintTimer.cancel();
    _bannerTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0D4D3A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buy Car',
          style: TextStyle(
            color: Color(0xFF0D4D3A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _banner(),
            const SizedBox(height: 8),
            _dots(),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Find the right Cars by',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () => _showFilterOptions(context),
                child: const Row(
                  children: [
                    Icon(Icons.filter_list, color: Color(0xFF0D4D3A)),
                    SizedBox(width: 8),
                    Text(
                      'Sort By',
                      style: TextStyle(
                        color: Color(0xFF0D4D3A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '170 used cars in Coimbatore',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 14),
            ...List.generate(3, (_) => _buildCarCard()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/rental_banner.png', fit: BoxFit.cover),
              ),
            ),
            ...List.generate(3, (_) => _buildCarCard()),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade200, width: 1.5),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.search, color: Colors.grey, size: 28),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Row(
                    children: [
                      const Text('Search Cars by "', style: TextStyle(color: Colors.grey, fontSize: 16)),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          _hints[_hintIndex],
                          key: ValueKey<String>(_hints[_hintIndex]),
                          style: const TextStyle(
                            color: Colors.purple,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Text('"', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                  const TextField(decoration: InputDecoration(border: InputBorder.none)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _banner() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _bannerController,
        itemCount: _bannerTotalItems,
        onPageChanged: (index) => setState(() => _currentBannerIndex = index % _bannerImages.length),
        itemBuilder: (context, index) {
          final imageIndex = index % _bannerImages.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(_bannerImages[imageIndex], fit: BoxFit.fill),
            ),
          );
        },
      ),
    );
  }

  Widget _dots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == _currentBannerIndex ? 24 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: index == _currentBannerIndex ? Colors.purple : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  Widget _buildCarCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  color: Color(0xFF002F9B),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(45)),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 100,
                        alignment: Alignment.center,
                        child: Image.asset('assets/swift.png', width: 110, fit: BoxFit.contain),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    'Maruti Suzuki Swift VXI 2021',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF2101AF),
                                    ),
                                  ),
                                ),
                                Icon(Icons.favorite_border, color: Colors.purple.shade400, size: 20),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text('25,000 km | Petrol | Manual', style: TextStyle(fontSize: 14, color: Color(0xFF3C3C3C))),
                            const SizedBox(height: 6),
                            const Row(
                              children: [
                                Text('₹ 9.2', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF040084))),
                                SizedBox(width: 4),
                                Text('Lakh', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF040084))),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text(
                                  'EMI  ₹13,470/mo',
                                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF3F51B5)),
                                ),
                                const Spacer(),
                                const Icon(Icons.location_on, color: Colors.redAccent, size: 18),
                                const SizedBox(width: 2),
                                const Text('Coimbatore', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Divider(color: Colors.grey.shade300, height: 1),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CarDetailsScreen()));
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'View Seller Details',
                        style: TextStyle(color: Color(0xFF8B429A), fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Filter options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D4D3A))),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade400)),
                            child: const Icon(Icons.close, size: 16, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          decoration: BoxDecoration(color: Colors.grey.shade50, border: Border(right: BorderSide(color: Colors.grey.shade200))),
                          child: ListView.builder(
                            itemCount: _categories.length,
                            itemBuilder: (_, index) {
                              final category = _categories[index];
                              final isSelected = category == _selectedCategory;
                              return GestureDetector(
                                onTap: () => setModalState(() => _selectedCategory = category),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : Colors.transparent,
                                    border: isSelected ? const Border(left: BorderSide(color: Color(0xFF0D4D3A), width: 4)) : null,
                                  ),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? const Color(0xFF0D4D3A) : Colors.black54,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: _buildRightFilterBody(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedFilters.forEach((key, value) {
                                if (value is List) {
                                  value.clear();
                                } else {
                                  _selectedFilters[key] = null;
                                }
                              });
                            });
                          },
                          child: const Text('Clear Filters', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 120,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D4D3A),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Update', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRightFilterBody() {
    if (_selectedCategory == 'Budget') {
      const budgets = ['Under 5 lakhs', '5-10 lakhs', '10-25 lakhs', '25-50 lakhs', '50-75 lakhs', '75-1 crore', 'Above 1 crore'];
      return ListView(
        children: budgets
            .map(
              (b) => RadioListTile<String>(
                title: Text(b),
                value: b,
                groupValue: _selectedFilters['Budget'],
                onChanged: (v) => setState(() => _selectedFilters['Budget'] = v),
              ),
            )
            .toList(),
      );
    }
    const optionMap = {
      'Brand': ['Maruti Suzuki', 'Hyundai', 'Toyota', 'Mahindra', 'Tata', 'Honda', 'Kia'],
      'Fuel type': ['Petrol', 'Diesel', 'CNG', 'Electric'],
      'Transmission': ['AMT', 'CVT', 'DCT', 'IMT', 'Regular Manual'],
      'Body type': ['SUV', 'MUV', 'Sedan', 'Hatchback'],
      'Seater': ['4', '5', '6', '7'],
      'Ownership': ['1st owner', '2nd owner', '3rd owner', '4th owner', 'Above 4 owners'],
      'Year': ['1975-2000', '2001-2005', '2006-2010', '2011-2015', '2016-2020', '2021 & above'],
      'RTO': ['Tiruppur North', 'Tiruppur South', 'Chennai Central', 'Coimbatore North'],
      'Colors': ['White', 'Black', 'Silver', 'Gray', 'Red', 'Blue', 'Navy Blue', 'Maroon', 'Purple'],
    };
    final options = optionMap[_selectedCategory] ?? <String>[];
    final selected = _selectedFilters[_selectedCategory] as List<String>;
    return ListView(
      children: options
          .map(
            (opt) => CheckboxListTile(
              title: Text(opt),
              value: selected.contains(opt),
              onChanged: (v) {
                setState(() {
                  if (v == true) {
                    selected.add(opt);
                  } else {
                    selected.remove(opt);
                  }
                });
              },
            ),
          )
          .toList(),
    );
  }
}
