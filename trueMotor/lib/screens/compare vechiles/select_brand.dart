import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/compare%20vechiles/select_variant.dart';

class SelectBrandPage extends StatefulWidget {
  const SelectBrandPage({super.key});

  @override
  State<SelectBrandPage> createState() => _SelectBrandPageState();
}

class _SelectBrandPageState extends State<SelectBrandPage> {
  String? _expandedBrand;

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  final Map<String, List<String>> _brandModels = {
    'Maruthi Suzuki': ['Baleno', 'Brezza', 'Ciaz', 'Swift', 'Alto'],
    'TATA': ['Curvv', 'Punch', 'Altroz', 'Harrier', 'Tiago'],
    'KIA': ['Seltos', 'Sonet', 'Carens', 'EV6'],
    'Mahindra': ['XUV700', 'Scorpio N', 'Thar', 'XUV300'],
    'Renault': ['Kwid', 'Kiger', 'Triber'],
    'Hyundai': ['Creta', 'Venue', 'Verna', 'i20'],
  };

  final List<String> brands = [
    'Maruthi Suzuki',
    'TATA',
    'KIA',
    'Mahindra',
    'Renault',
    'Hyundai',
    'Skoda',
    'Jeep',
    'Ford',
    'Toyota',
    'Honda',
    'MG',
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
      body: SingleChildScrollView(
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
                    Icon(Icons.search, color: Colors.grey.shade600, size: 20),
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

            // Select Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: const Text(
                'Select your car brand',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),

            SizedBox(height: h * 0.015),

            // Brand List Tiles
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04),
              child: Column(
                children: brands
                    .map((brand) => _buildBrandItem(brand))
                    .toList(),
              ),
            ),

            SizedBox(height: h * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandItem(String brand) {
    final isExpanded = _expandedBrand == brand;
    final models = _brandModels[brand] ?? [];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 0,
                ),
                title: Text(
                  brand,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                trailing: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: const Color(0xFF7E3080),
                ),
                onTap: () {
                  setState(() {
                    _expandedBrand = isExpanded ? null : brand;
                  });
                },
              ),
              if (isExpanded)
                Column(
                  children: models
                      .map((model) => _buildModelItem(model))
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModelItem(String model) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SelectVariantPage(brand: _expandedBrand!, model: model),
          ),
        );

        if (result != null && mounted) {
          // Return the full car data back to compare_home.dart
          Navigator.pop(context, result);
        }
      },
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFF7F7F7),
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Text(
          model,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ),
    );
  }
}
