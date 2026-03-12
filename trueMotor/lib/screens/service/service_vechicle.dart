import 'dart:async';
import 'package:flutter/material.dart';
import 'package:truemotor/widgets/bottom_navigation.dart';
import 'confirm_booking.dart';

class ServiceVehicleScreen extends StatefulWidget {
  const ServiceVehicleScreen({super.key});

  @override
  State<ServiceVehicleScreen> createState() => _ServiceVehicleScreenState();
}

class _ServiceVehicleScreenState extends State<ServiceVehicleScreen> {
  String? selectedVehicle;
  String? selectedService;
  String? selectedLocation;
  String? _expandedDropdown;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  final List<int> _expandedFaqs = [];

  final List<Map<String, String>> carouselItems = [
    {'name': 'Bikes', 'image': 'assets/bike.png'},
    {'name': 'Cars', 'image': 'assets/car.png'},
    {'name': 'Commercial', 'image': 'assets/commercial vechiles.png'},
    {'name': 'Tractor', 'image': 'assets/tractor.png'},
  ];

  int _currentPage = 0;
  Timer? _timer;

  final List<String> vehicles = [
    'Car',
    'Bike',
    'Commercial Vehicle',
    'Tractor or Agricultural Vehicle',
  ];

  final List<String> serviceTypes = [
    'General Service',
    'Oil Change',
    'Filter Replacement (Air/Oil/Fuel)',
    'Brake Inspection & Replacement',
    'Coolant Top-Up',
    'Battery Check & Replacement',
    'Spark Plug Replacement',
  ];

  final List<String> locations = [
    'Chennai - Anna Nagar',
    'Chennai - T Nagar',
    'Bangalore - Koramangala',
  ];

  final List<Map<String, String>> faqs = [
    {'q': 'How long does it take to service vehicle?'},
    {'q': 'How long does it take to service vehicle?'},
    {'q': 'How long does it take to service vehicle?'},
    {'q': 'How long does it take to service vehicle?'},
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (mounted) {
        setState(() {
          if (_currentPage < carouselItems.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pickupController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final h = media.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
      appBar: AppBar(
        title: const Text('Service Vehicle'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0D4D3A),
        elevation: 1,
      ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Top Banner Image
                    Container(
                      width: double.infinity,
                      height: h * 0.24,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/service_image1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    _buildBookingForm(),
                    _buildSkodaAd(),
                    _buildWhyChooseUs(),
                    _buildPopularVehiclesCarousel(),
                    _buildFAQ(),

                    SizedBox(height: h * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildBookingForm() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Book a Service',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '"Ensure your vehicle stays in top condition. Book your service with TrueMotors\' trusted partners today."',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),

          _buildDropdown(
            'Select Vehicle',
            vehicles,
            selectedVehicle,
            (v) => selectedVehicle = v,
            dropdownKey: 'vehicle',
          ),
          const SizedBox(height: 12),
          _buildDropdown(
            'Service Type',
            serviceTypes,
            selectedService,
            (v) => selectedService = v,
            dropdownKey: 'service',
          ),
          const SizedBox(height: 12),
          _buildDateTimePicker(),
          const SizedBox(height: 12),
          _buildDropdown(
            'Select Location',
            locations,
            selectedLocation,
            (v) => selectedLocation = v,
            dropdownKey: 'location',
          ),

          const SizedBox(height: 16),
          const Text(
            'Pickup Address',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          _buildTextField(_pickupController, ''), // ✅ clean call

          const SizedBox(height: 16),
          const Text(
            'Special Instruction',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          _buildTextArea(_instructionController, ''),

          const SizedBox(height: 24),
          _buildBookButton(),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? value,
    ValueChanged<String> onChanged, {
    required String dropdownKey,
  }) {
    final isExpanded = _expandedDropdown == dropdownKey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedDropdown = isExpanded ? null : dropdownKey;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: TextStyle(
                      fontSize: 14,
                      color: value == null ? Colors.black54 : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: const Color(0xFF6B1D8C),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) ...[
          const SizedBox(height: 4),
          ...items.map(
            (e) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: InkWell(
                onTap: () {
                  setState(() {
                    onChanged(e);
                    _expandedDropdown = null;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    e,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDateTimePicker() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: const [
          Text(
            'Select Preferred Date & Time',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Icon(Icons.arrow_drop_down, color: Color(0xFF6B1D8C)),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent, // 🔥 background removed
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTextArea(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,

        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: TextField(
        controller: controller,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(12),
        ),
      ),
    );
  }

  Widget _buildBookButton() {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        width: w * 0.52,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ConformBookingScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF006970),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: h * 0.017),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          child: const Text(
            'Book Service Now',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget _buildSkodaAd() {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(w * 0.04),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset('assets/compare_banner2.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // Reduced width
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Why Choose Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Our certified and trained technicians ensure that your vehicle gets the care it deserves. From routine servicing to complex repairs, your car is in safe hands.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),

            _buildBulletItem(
              'Expert Technicians:',
              'Certified professionals for every service.',
            ),

            _buildBulletItem(
              'Genuine Parts:',
              'Guaranteed quality and reliability.',
            ),

            _buildBulletItem(
              'Transparent Pricing:',
              'No hidden charges, upfront estimates.',
            ),

            _buildBulletItem(
              'Convenience:',
              'Home pickup & drop for hassle-free servicing.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletItem(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Text(
              '• ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularVehiclesCarousel() {
    final h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12, left: 18, bottom: 4),
          child: Text(
            'Popular Service Vehicles:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: h * 0.24,
          width: double.infinity,
          // margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 1000),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                      ),
                      child: child,
                    ),
                  );
                },
                child: Center(
                  key: ValueKey<int>(_currentPage),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset(
                      carouselItems[_currentPage]['image']!,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFAQ() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ), // reduced margin
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // slightly smaller radius
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.all(8), // 🔥 reduced padding
      child: Column(
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 15, // slightly reduced
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10), // reduced spacing
          ...List.generate(faqs.length, (index) {
            return _buildFAQTile(index + 1, faqs[index]['q']!);
          }),
        ],
      ),
    );
  }

  Widget _buildFAQTile(int number, String question) {
    bool isExpanded = _expandedFaqs.contains(number);

    return InkWell(
      onTap: () {
        setState(() {
          if (isExpanded) {
            _expandedFaqs.remove(number);
          } else {
            _expandedFaqs.add(number);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10), // 🔥 reduced
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$number. $question',
                    style: const TextStyle(
                      fontSize: 12, // reduced font
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20, // smaller icon
                  color: Colors.black54,
                ),
              ],
            ),
            if (isExpanded)
              const Padding(
                padding: EdgeInsets.only(top: 6.0, left: 20),
                child: Text(
                  'Typically, a standard service takes 4-6 hours. Complex repairs may take longer. Our team will keep you updated.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}



