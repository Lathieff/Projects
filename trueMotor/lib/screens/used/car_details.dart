import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/used/conform_your_booking.dart';
import 'package:truemotor/screens/used/test_drive.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B664A)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'Buy',
          style: TextStyle(
            color: Color(0xFF0B664A),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(sw * 0.04, sh * 0.01, sw * 0.04, sh * 0.12),
        child: Column(
          children: [
            _imageCard(sw, sh),
            SizedBox(height: sh * 0.012),
            _priceCard(sw, sh),
            SizedBox(height: sh * 0.012),
            _sectionCard(
              sw,
              sh,
              title: 'Car overview',
              rows: const [
                ['Make year', 'Mar 2015'],
                ['Reg year', 'Jun 2015'],
                ['Fuel', 'Petrol'],
                ['Kilometers driven', '10000'],
                ['Transmission', 'Manual(Regular)'],
                ['No.of Owners', '1st owner'],
                ['RTO', 'TN43'],
                ['Car Location', 'Coimbatore'],
                ['Insurance Validity', 'Jun 2025'],
                ['Insurance Type', 'Comprehensive'],
              ],
            ),
            SizedBox(height: sh * 0.012),
            _sectionCard(
              sw,
              sh,
              title: 'Car specifications',
              rows: const [
                ['Mileage', '18.6kmpl'],
                ['Displacement', '1197cc'],
                ['Ground clearance', '170mm'],
                ['No. of cylinders', '4 units'],
                ['Boot Space', '285 litres'],
                ['Steering type', 'Power'],
                ['Seating capacity', '5 units'],
                ['No.of gears', '5 units'],
                ['Fuel tank capacity', '45 litres'],
                ['Front brake type', 'Disc'],
              ],
            ),
            SizedBox(height: sh * 0.012),
            SizedBox(
              width: sw * 0.60,
              height: sh * 0.06,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF8B429A), width: 1.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  backgroundColor: const Color(0xFFF7F7F7),
                ),
                child: Text(
                  'View all specification',
                  style: TextStyle(
                    color: const Color(0xFF202020),
                    fontSize: sw * 0.038,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.012),
            _topFeaturesCard(sw, sh),
            SizedBox(height: sh * 0.012),
            _emiAndApplyCard(sw, sh),
            SizedBox(height: sh * 0.012),
            _sellPromptCard(sw, sh),
            SizedBox(height: sh * 0.012),
            _similarCarsSection(sw, sh),
            SizedBox(height: sh * 0.012),
            _faqSection(sw, sh),
          ],
        ),
      ),
      bottomNavigationBar: _bottomActionBar(context, sw, sh),
    );
  }

  Widget _imageCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: sw * 0.03, vertical: sh * 0.015),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/swift.png',
              height: sh * 0.17,
              fit: BoxFit.contain,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_border, color: const Color(0xFF8B429A), size: sw * 0.065),
                SizedBox(width: sw * 0.02),
                Icon(Icons.share_outlined, color: const Color(0xFF8B429A), size: sw * 0.065),
              ],
            ),
          ),
          Positioned(
            right: sw * 0.01,
            bottom: sh * 0.01,
            child: Container(
              width: sw * 0.055,
              height: sw * 0.055,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF8B429A),
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Maruti Suzuki Swift VXI 2021',
            style: TextStyle(
              fontSize: sw * 0.055,
              color: const Color(0xFF2101AF),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: sh * 0.004),
          Text(
            '25,000 km | Petrol |',
            style: TextStyle(fontSize: sw * 0.044, color: const Color(0xFF222222)),
          ),
          Text(
            'Manual',
            style: TextStyle(fontSize: sw * 0.044, color: const Color(0xFF742B88)),
          ),
          SizedBox(height: sh * 0.004),
          Text(
            'EMI  ₹13,470/mo',
            style: TextStyle(fontSize: sw * 0.040, color: const Color(0xFF3F51B5), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: sh * 0.005),
          Row(
            children: [
              Text(
                '₹ 9.2 Lakh',
                style: TextStyle(fontSize: sw * 0.060, color: const Color(0xFF040084), fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              const Icon(Icons.location_on, color: Colors.red, size: 16),
              Text(
                'Coimbatore',
                style: TextStyle(fontSize: sw * 0.045, color: const Color(0xFF555555)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(
    double sw,
    double sh, {
    required String title,
    required List<List<String>> rows,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: sw * 0.065,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF262626),
            ),
          ),
          SizedBox(height: sh * 0.01),
          ...rows.map((row) {
            return Padding(
              padding: EdgeInsets.only(bottom: sh * 0.01),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      row[0],
                      style: TextStyle(
                        fontSize: sw * 0.035,
                        color: const Color(0xFF989898),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row[1],
                      style: TextStyle(
                        fontSize: sw * 0.037,
                        color: const Color(0xFF262626),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _topFeaturesCard(double sw, double sh) {
    final features = const [
      ['Safety', 'Airbags'],
      ['Rear camera', 'Parking sensors'],
      ['Entertainment & communication', 'Integrated in dash music system'],
      ['Touch screen infotainment system', 'GPS navigation'],
      ['Exterior', 'Rear defogger'],
      ['Comfort & convenience', 'Steering mounted controls'],
      ['Driver height adjustable seat', ''],
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Features',
            style: TextStyle(
              fontSize: sw * 0.045,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF202020),
            ),
          ),
          SizedBox(height: sh * 0.005),
          ...features.map((row) {
            return Padding(
              padding: EdgeInsets.only(top: sh * 0.008),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row[0],
                    style: TextStyle(
                      fontSize: sw * 0.029,
                      color: const Color(0xFF9A9A9A),
                    ),
                  ),
                  SizedBox(height: sh * 0.002),
                  if (row[1].isNotEmpty)
                    Text(
                      row[1],
                      style: TextStyle(
                        fontSize: sw * 0.032,
                        color: const Color(0xFF262626),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  SizedBox(height: sh * 0.005),
                  Container(height: 1, color: const Color(0xFFD1D1D1)),
                ],
              ),
            );
          }),
          SizedBox(height: sh * 0.01),
          Center(
            child: SizedBox(
              width: sw * 0.55,
              height: sh * 0.052,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF8B429A), width: 1.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'View all features',
                  style: TextStyle(
                    color: const Color(0xFF202020),
                    fontSize: sw * 0.036,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emiAndApplyCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(sw * 0.01, sh * 0.004, sw * 0.01, sh * 0.008),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EMI Calculator',
                      style: TextStyle(
                        fontSize: sw * 0.027,
                        color: const Color(0xFF5B2DA1),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: sh * 0.004),
                    _emiRow(sw, 'Loan Amount', '₹8,36,832'),
                    _emiRow(sw, 'Loan tenure', '84 months'),
                    _emiRow(sw, 'Interest rate', '8.25 %'),
                    _emiRow(sw, 'Approx EMI', '₹ 6,795'),
                  ],
                ),
              ),
              SizedBox(width: sw * 0.02),
              SizedBox(
                width: sw * 0.16,
                height: sw * 0.16,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const CircularProgressIndicator(
                      value: 0.7,
                      strokeWidth: 8,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF48C28F)),
                      backgroundColor: Color(0xFFD8D8D8),
                    ),
                    Center(
                      child: Text(
                        'Total EMI\n₹ 70,000',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: sw * 0.018, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.006),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B429A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(width: sw * 0.02),
              SizedBox(
                width: sw * 0.30,
                height: sh * 0.04,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B429A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.zero,
                    elevation: 0,
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontSize: sw * 0.032, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emiRow(double sw, String left, String right) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              left,
              style: TextStyle(fontSize: sw * 0.024, color: const Color(0xFF686868)),
            ),
          ),
          Text(
            right,
            style: TextStyle(fontSize: sw * 0.024, color: const Color(0xFF8B429A), fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _sellPromptCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sw * 0.03),
      color: const Color(0xFFF5E8DD),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do You Want to Sell a Car ?',
                  style: TextStyle(
                    fontSize: sw * 0.042,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1D1D1D),
                  ),
                ),
                SizedBox(height: sh * 0.004),
                Text(
                  'We are committed to providing our customers with exceptional service.',
                  style: TextStyle(
                    fontSize: sw * 0.029,
                    color: const Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: sw * 0.02),
          SizedBox(
            width: sw * 0.24,
            height: sh * 0.045,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8C4B16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                elevation: 0,
              ),
              child: Text(
                'Sell a Car',
                style: TextStyle(fontSize: sw * 0.03, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _similarCarsSection(double sw, double sh) {
    return Column(
      children: [
        Text(
          'Similar Cars',
          style: TextStyle(
            fontSize: sw * 0.062,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1D1D1D),
          ),
        ),
        SizedBox(height: sh * 0.01),
        _similarCarCard(sw, sh),
        SizedBox(height: sh * 0.012),
        _similarCarCard(sw, sh),
        SizedBox(height: sh * 0.012),
        _similarCarCard(sw, sh),
        SizedBox(height: sh * 0.014),
        SizedBox(
          width: sw * 0.35,
          height: sh * 0.055,
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF8B429A), width: 1.2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: sw * 0.05,
                color: const Color(0xFF222222),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _similarCarCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(sw * 0.02, sh * 0.008, sw * 0.02, sh * 0.005),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: sw * 0.25,
                height: sw * 0.18,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: sw * 0.08,
                        height: sw * 0.08,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0A3FA8),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    Center(child: Image.asset('assets/swift.png', fit: BoxFit.contain)),
                  ],
                ),
              ),
              SizedBox(width: sw * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Maruti Suzuki Swift VXI 2021',
                            style: TextStyle(
                              fontSize: sw * 0.038,
                              color: const Color(0xFF2101AF),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.favorite_border, color: const Color(0xFF8B429A), size: sw * 0.05),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: sw * 0.035, color: const Color(0xFF262626)),
                        children: const [
                          TextSpan(text: '25,000 km | Petrol | '),
                          TextSpan(text: 'Manual', style: TextStyle(color: Color(0xFF742B88))),
                        ],
                      ),
                    ),
                    SizedBox(height: sh * 0.002),
                    Row(
                      children: [
                        Text(
                          '₹ 9.2 Lakh',
                          style: TextStyle(
                            fontSize: sw * 0.062,
                            color: const Color(0xFF040084),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'EMI ₹13,470/mo',
                          style: TextStyle(fontSize: sw * 0.028, color: const Color(0xFF3F51B5)),
                        ),
                        const Spacer(),
                        const Icon(Icons.location_on, color: Colors.red, size: 14),
                        Text(
                          'Coimbatore',
                          style: TextStyle(fontSize: sw * 0.04, color: const Color(0xFF555555)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.006),
          const Divider(color: Color(0xFFC8C8C8), height: 1),
          SizedBox(height: sh * 0.005),
          Text(
            'View Seller Details',
            style: TextStyle(
              fontSize: sw * 0.042,
              color: const Color(0xFF8B429A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _faqSection(double sw, double sh) {
    return Column(
      children: [
        Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: sw * 0.062,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1D1D1D),
          ),
        ),
        SizedBox(height: sh * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: sh * 0.008),
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: List.generate(4, (index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.03, vertical: sh * 0.01),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Q.When and where can I take a test drive?',
                            style: TextStyle(fontSize: sw * 0.044, color: const Color(0xFF252525)),
                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: const Color(0xFF6D6D6D), size: sw * 0.06),
                      ],
                    ),
                  ),
                  if (index != 3) const Divider(height: 1, color: Color(0xFFD3D3D3)),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _bottomActionBar(BuildContext context, double sw, double sh) {
    return Container(
      color: const Color(0xFFF2F2F2),
      padding: EdgeInsets.fromLTRB(sw * 0.04, sh * 0.006, sw * 0.04, sh * 0.012),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: sh * 0.057,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ConformYourBookingScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006B70),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(fontSize: sw * 0.048, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(width: sw * 0.03),
          Expanded(
            child: SizedBox(
              height: sh * 0.057,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TestDriveScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF8B429A), width: 1.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Free Test Drive',
                  style: TextStyle(
                    fontSize: sw * 0.048,
                    color: const Color(0xFF8B429A),
                    fontWeight: FontWeight.w600,
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
