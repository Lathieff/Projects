import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/sell/sell_car.dart';
import 'package:truemotor/screens/used/car_details.dart';
import 'package:truemotor/widgets/bottom_navigation.dart';

class SellHomeScreen extends StatefulWidget {
  const SellHomeScreen({super.key});

  @override
  State<SellHomeScreen> createState() => _SellHomeScreenState();
}

class _SellHomeScreenState extends State<SellHomeScreen> {
  String? selectedVehicle;
  final TextEditingController _regController = TextEditingController();
  final Set<int> _expandedFaqs = {};

  @override
  void dispose() {
    _regController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> carBrands = [
    {'image': 'assets/icons/logo/suzuki_logo.png', 'fallback': 'M'},
    {'image': 'assets/icons/logo/toyota_logo.png', 'fallback': 'T'},
    {'image': 'assets/icons/logo/hyundai_logo.png', 'fallback': 'H'},
    {'image': 'assets/icons/logo/honda_logo.png', 'fallback': 'Ho'},
    {'image': 'assets/icons/logo/tata_logo.png', 'fallback': 'Ta'},
    {'image': 'assets/icons/logo/ford_logo.png', 'fallback': 'F'},
    {'image': 'assets/icons/logo/nissan_logo.png', 'fallback': 'N'},
    {'image': 'assets/icons/logo/fiat_logo.png', 'fallback': 'Fi'},
    {'image': 'assets/icons/logo/kia_logo.png', 'fallback': 'K'},
    {'image': 'assets/icons/logo/mahindra_logo.png', 'fallback': 'Ma'},
  ];

  final List<Map<String, dynamic>> trendingCars = [
    {
      'name': 'Maruti Suzuki Swift',
      'year': '2021',
      'km': '7,680 km',
      'price': 'Rs 6.98 Lakh',
      'image': 'assets/swift.png'
    },
    {
      'name': 'Maruti Suzuki Baleno',
      'year': '2020',
      'km': '45,000 km',
      'price': 'Rs 7.50 Lakh',
      'image': 'assets/jimmy.png'
    },
    {
      'name': 'Maruti Suzuki Swift',
      'year': '2021',
      'km': '7,680 km',
      'price': 'Rs 6.98 Lakh',
      'image': 'assets/swift.png'
    },
  ];

  final List<String> faqs = [
    'Where can I Sell my car?',
    'Which document is essential for selling my car?',
    'How soon will I receive payment after selling my car to True Motors?',
    'How long does it take to sell my car?',
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double sw = mediaQuery.size.width;
    final double sh = mediaQuery.size.height;
    final double hp = sw * 0.03;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
      body: SafeArea(
        child: Column(
            children: [
              // ── App Bar ──────────────────────────────────────────────
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: hp, vertical: sh * 0.025),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      child: const Icon(Icons.arrow_back,
                          color: Colors.black87),
                    ),
                    SizedBox(width: sw * 0.03),
                    Text(
                      'Sell car',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: sw * 0.045),
                    ),
                  ],
                ),
              ),

              // ── Scrollable Body ──────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeroBanner(sw, sh, hp),
                      SizedBox(height: sh * 0.02),
                      _buildPricingCard(sw, sh, hp),
                      SizedBox(height: sh * 0.025),
                      _buildTrendingCars(sw, sh, hp),
                      SizedBox(height: sh * 0.025),
                      _buildProcessSection(sw, sh, hp),
                      SizedBox(height: sh * 0.025),
                      _buildTestimonials(sw, sh, hp),
                      SizedBox(height: sh * 0.025),
                      _buildFAQ(sw, sh, hp),
                      SizedBox(height: sh * 0.03),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  // ─── Hero Banner ─────────────────────────────────────────────────────────────
  Widget _buildHeroBanner(double sw, double sh, double hp) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: hp, vertical: sh * 0.01),
      width: double.infinity,
      height: sh * 0.23,
      decoration: BoxDecoration(
        color: const Color(0xFF00274B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/swift.png',
              width: sw * 0.48,
              height: sh * 0.20,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => SizedBox(
                width: sw * 0.42,
                child: Icon(Icons.directions_car,
                    size: sw * 0.28, color: Colors.white24),
              ),
            ),
          ),
          Positioned(
            right: sw * 0.04,
            top: 0,
            bottom: 0,
            width: sw * 0.48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sell Your Car Instantly',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: sw * 0.038,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: sh * 0.006),
                Text(
                  'Best price. Free inspection.\nInstant payment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: sw * 0.030,
                      fontWeight: FontWeight.w600,
                      height: 1.4),
                ),
                SizedBox(height: sh * 0.015),
                SizedBox(
                  width: sw * 0.42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellCarScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0D1B5E),
                      padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.04, vertical: sh * 0.012),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Get Free Quote',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sw * 0.032),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Pricing Card ─────────────────────────────────────────────────────────────
  Widget _buildPricingCard(double sw, double sh, double hp) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: hp),
          padding: EdgeInsets.all(sw * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Your Vehicle Best Price Now',
                style: TextStyle(
                    fontSize: sw * 0.043,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF003399)),
              ),
              SizedBox(height: sh * 0.018),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: sw * 0.03, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(
                      'Select Vehicle',
                      style: TextStyle(
                          color: Colors.black, fontSize: sw * 0.034),
                    ),
                    value: selectedVehicle,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black54),
                    items: ['Car', 'Bike', 'Scooty', 'Commercial Vehicle']
                        .map((e) => DropdownMenuItem<String>(
                        value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) =>
                        setState(() => selectedVehicle = val),
                  ),
                ),
              ),
              SizedBox(height: sh * 0.015),
              Text(
                'Enter Your Car Registration Number',
                style: TextStyle(
                    color: Colors.black54, fontSize: sw * 0.030),
              ),
              SizedBox(height: sh * 0.006),
              TextField(
                controller: _regController,
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(
                    fontSize: sw * 0.035, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  hintText: 'TN 42 A 4872',
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: sw * 0.034),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: sw * 0.04, vertical: sh * 0.016),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color(0xFF005F65), width: 1.5)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: sh * 0.018),
              Center(
                child: SizedBox(
                  width: sw * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellCarScreen(),
                        ),
                      );  
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF005F65),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: sh * 0.018),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sell my vehicle',
                      style: TextStyle(
                          fontSize: sw * 0.042,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Text(
              'or Select your car brand',
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(horizontal: hp),
          padding: EdgeInsets.all(sw * 0.035),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(0, 4))
            ],
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: sw * 0.025,
              mainAxisSpacing: sw * 0.025,
              childAspectRatio: 1.0,
            ),
            itemCount: carBrands.length,
            itemBuilder: (context, index) {
              final brand = carBrands[index];
              return GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: const Color(0xFFB9B9B9)),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    brand['image'] as String,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Center(
                      child: Text(
                        brand['fallback'] as String,
                        style: TextStyle(
                            fontSize: sw * 0.030,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF005F65)),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── Trending Cars ────────────────────────────────────────────────────────────
  Widget _buildTrendingCars(double sw, double sh, double hp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hp),
          child: Text(
            'Trending Cars',
            style: TextStyle(
                fontSize: sw * 0.048,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ),
        SizedBox(height: sh * 0.015),
        SizedBox(
          height: sh * 0.30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: hp),
            itemCount: trendingCars.length,
            itemBuilder: (context, index) {
              final car = trendingCars[index];
              final cardWidth = sw * 0.72;
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: cardWidth,
                  margin: EdgeInsets.only(right: sw * 0.03),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10,
                          offset: const Offset(0, 13))
                    ],
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: sh * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(14)),
                        ),
                        child: Center(
                          child: Image.asset(
                            car['image'] as String,
                            width: cardWidth * 0.90,
                            height: sh * 0.15,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) => Icon(
                                Icons.directions_car,
                                color: Colors.grey.shade400,
                                size: sw * 0.22),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sw * 0.025,
                              vertical: sh * 0.010),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Expanded(
                                      child: Text(
                                        car['name'] as String,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sw * 0.036),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      car['year'] as String,
                                      style: TextStyle(
                                          fontSize: sw * 0.032,
                                          color: Colors.grey.shade600),
                                    ),
                                  ]),
                                  const SizedBox(height: 2),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Test Drive Available',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontSize: sw * 0.028),
                                      ),
                                      Text(
                                        car['price'] as String,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sw * 0.034,
                                            color: const Color(
                                                0xFF4C4845)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: sw * 0.35,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                          color: Color(0xFF6C3CE1)),
                                      foregroundColor:
                                      const Color(0xFF6C3CE1),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sw * 0.04,
                                          vertical: sh * 0.006),
                                      textStyle: TextStyle(
                                          fontSize: sw * 0.032),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                    ),
                                    child: const Text('View Details'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ─── Process Section ──────────────────────────────────────────────────────────
  Widget _buildProcessSection(double sw, double sh, double hp) {
    final List<Map<String, dynamic>> steps = [
      {
        'image': 'assets/sell_1.png',
        'title': 'Get price online',
        'desc':
        'Answer some question about your car to help us understand its condition',
      },
      {
        'image': 'assets/sell_2.png',
        'title': 'Car inspection',
        'desc':
        'Our car expert will physically verify your cars condition and give you the final offer',
      },
      {
        'image': 'assets/sell_3.png',
        'title': 'Car pick up & payment',
        'desc':
        'We will transfer the amount directly to your bank account before your car is picked up',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Process of selling cars',
            style: TextStyle(
                fontSize: sw * 0.048,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(height: sh * 0.015),
          ...steps.map(
                (step) => Container(
              margin: EdgeInsets.only(bottom: sh * 0.015),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F0FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    child: Image.asset(
                      step['image'] as String,
                      width: sw * 0.36,
                      height: sh * 0.14,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        width: sw * 0.36,
                        height: sh * 0.14,
                        color: Colors.purple.shade100,
                        child: Icon(Icons.image,
                            color: Colors.purple.shade300,
                            size: sw * 0.10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.035,
                          vertical: sh * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: sw * 0.036,
                                color: const Color(0xFF742B88)),
                          ),
                          SizedBox(height: sh * 0.006),
                          Text(
                            step['desc'] as String,
                            style: TextStyle(
                                fontSize: sw * 0.028,
                                color: Colors.black87,
                                height: 1.45),
                          ),
                        ],
                      ),
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

  // ─── Testimonials ─────────────────────────────────────────────────────────────
  Widget _buildTestimonials(double sw, double sh, double hp) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Testimonials – What Our Customers Say',
            style: TextStyle(
                fontSize: sw * 0.042,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(height: sh * 0.015),
          Container(
            padding: EdgeInsets.all(sw * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  const Text('🏍️', style: TextStyle(fontSize: 18)),
                  const SizedBox(width: 8),
                  Text(
                    'Harish – Coimbatore',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: sw * 0.036,
                        color: const Color(0xFF000EAD)),
                  ),
                ]),
                SizedBox(height: sh * 0.008),
                Row(children: [
                  Text('Rating: ',
                      style: TextStyle(
                          fontSize: sw * 0.033, color: Colors.black87)),
                  ...List.generate(
                      4,
                          (_) => Icon(Icons.star,
                          size: sw * 0.038, color: Colors.amber)),
                  Icon(Icons.star_border,
                      size: sw * 0.038, color: Colors.amber),
                  Text(' (4.5/5)',
                      style: TextStyle(
                          fontSize: sw * 0.030, color: Colors.black87)),
                ]),
                SizedBox(height: sh * 0.010),
                Text(
                  '"Great range of bikes and quick service!"\nFound the exact model I was looking for, and they delivered it on time. Customer support was responsive even after the sale.',
                  style: TextStyle(
                      fontSize: sw * 0.035,
                      color: Colors.black87,
                      height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── FAQ ──────────────────────────────────────────────────────────────────────
  Widget _buildFAQ(double sw, double sh, double hp) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
                fontSize: sw * 0.045,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          SizedBox(height: sh * 0.012),
          ...faqs.asMap().entries.map((entry) {
            final i = entry.key;
            final faq = entry.value;
            final isExpanded = _expandedFaqs.contains(i);

            return Column(
              children: [
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(
                        horizontal: sw * 0.01),
                    trailing: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),
                    title: Text(
                      'Q. $faq',
                      style: TextStyle(
                          fontSize: sw * 0.038,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87),
                    ),
                    onExpansionChanged: (expanded) => setState(() {
                      expanded
                          ? _expandedFaqs.add(i)
                          : _expandedFaqs.remove(i);
                    }),
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            sw * 0.01, 0, sw * 0.04, sh * 0.012),
                        child: Text(
                          'Please contact our support team or visit the nearest True Motors center for assistance.',
                          style: TextStyle(
                              fontSize: sw * 0.030,
                              color: Colors.grey.shade600,
                              height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
