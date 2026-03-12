import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';

class SelectVariantPage extends StatefulWidget {
  final String brand;
  final String model;

  const SelectVariantPage({
    super.key,
    required this.brand,
    required this.model,
  });

  @override
  State<SelectVariantPage> createState() => _SelectVariantPageState();
}

class _SelectVariantPageState extends State<SelectVariantPage> {
  String? _selectedVariant;

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  final List<Map<String, String>> _variants = [
    {'name': 'Alpha AGS', 'fuel': 'Petrol'},
    {'name': 'Alpha MT', 'fuel': 'Petrol'},
    {'name': 'Zeta CNG MT', 'fuel': 'CNG'},
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF005F65)),
          onPressed: _goToHome,
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
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Image
                Container(
                  width: w,
                  color: Colors.white,
                  child: Image.asset(
                    'assets/brandpage__image.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.04,
                    vertical: h * 0.02,
                  ),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Icon(
                          Icons.search,
                          color: Colors.grey.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(bottom: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Breadcrumb & Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Variants',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.brand} / ${widget.model}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF7E3080),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: h * 0.02),

                // Variant List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _variants.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    final variant = _variants[index];
                    final isSelected = _selectedVariant == variant['name'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedVariant = variant['name'];
                        });
                      },
                      child: Container(
                        color: isSelected
                            ? Colors.purple.withOpacity(0.05)
                            : Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.04,
                          vertical: 15,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              variant['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              variant['fuel']!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Divider(height: 1, color: Colors.grey.shade300, thickness: 1),

                SizedBox(height: h * 0.1), // Spacing for fab
              ],
            ),
          ),

          // Confirm Booking Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(w * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: _selectedVariant == null
                    ? null
                    : () {
                        // Return selected car data
                        String imageAsset;
                        if (widget.model == 'Swift') {
                          imageAsset = 'assets/swift.png';
                        } else if (widget.model == 'Curvv') {
                          imageAsset = 'assets/curvv.png';
                        } else if (widget.model == 'Jimny') {
                          imageAsset = 'assets/jimmy.png';
                        } else {
                          imageAsset = 'assets/vitara.png';
                        }

                        Navigator.pop(context, {
                          'name': widget.model,
                          'brand': widget.brand,
                          'variant': _selectedVariant,
                          'image': imageAsset,
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF005F65),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
