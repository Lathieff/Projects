import 'dart:async';
import 'package:flutter/material.dart';
import 'booking_summary.dart';

class ConformBookingScreen extends StatefulWidget {
  const ConformBookingScreen({super.key});

  @override
  State<ConformBookingScreen> createState() => _ConformBookingScreenState();
}

class _ConformBookingScreenState extends State<ConformBookingScreen> {
  final List<int> _expandedFaqs = [];
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> carouselItems = [
    {'name': 'Bikes', 'image': 'assets/bike.png'},
    {'name': 'Cars', 'image': 'assets/car.png'},
    {'name': 'Commercial', 'image': 'assets/commercial vechiles.png'},
    {'name': 'Tractor', 'image': 'assets/tract.png'},
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
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final h = media.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        title: const Text('Confirm Booking'),
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
                      height: h * 0.25,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/sevice_image2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    _buildConfirmationCard(),
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

  Widget _buildConfirmationCard() {
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(w * 0.04),
      padding: EdgeInsets.all(w * 0.05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Conform Service Booking',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          _buildDetailRow('🚗', 'Vehicle', 'Hyundai Creta (Petrol)'),
          _buildDetailRow(
            '🔧',
            'Services Selected',
            'General Service AC Repair',
          ),
          _buildDetailRow('📍', 'Pickup', '123, Main Road, Chennai'),
          _buildDetailRow('🗓️', 'Scheduled', 'Aug 3, 2025 | 10:00 AM'),
          const SizedBox(height: 12),
          const Text(
            'Special Instructions : Kindly call before arriving.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // 🔥 Confirm Booking (Bigger)
              Expanded(
                flex: 1, // 👈 increase value = more width
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006970),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Conform Booking',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BookingSummaryScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              // 🔥 Edit (Smaller)
              Expanded(
                // flex: 1, // 👈 smaller width
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006970),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Edit',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String emoji, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: '$label : ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    final media = MediaQuery.of(context).size;
    final w = media.width;

    return Center(
      child: Container(
        width: w * 0.9,
        padding: EdgeInsets.all(w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // 🔥 border radius added
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
            const SizedBox(height: 14),

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
            child: Text('• ', style: TextStyle(fontSize: 18)),
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
    final media = MediaQuery.of(context).size;
    final h = media.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 0),
          child: const Text(
            'Popular Service Vehicle',
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
    final w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(w * 0.04),
      padding: EdgeInsets.all(w * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6), // reduced

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
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$number. $question',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
            if (isExpanded)
              const Padding(
                padding: EdgeInsets.only(top: 8.0, left: 24),
                child: Text(
                  'Typically, a standard service takes 4-6 hours. Complex repairs may take longer. Our team will keep you updated.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


