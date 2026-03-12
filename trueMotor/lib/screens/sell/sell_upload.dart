import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/sell/sell_terms.dart';
import 'package:truemotor/screens/sell/seller_information.dart';

class SellCarimage extends StatefulWidget {
  const SellCarimage({super.key});

  @override
  State<SellCarimage> createState() => _SellCarimageState();
}

class _SellCarimageState extends State<SellCarimage> {
  bool _allowTestDrive = false;
  final TextEditingController _additionalInfoController = TextEditingController();

  @override
  void dispose() {
    _additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth  = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
            children: [

              // ✅ AppBar
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                color: Colors.white,
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
                      child: Icon(Icons.arrow_back,
                          size: screenWidth * 0.06, color: Colors.black),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Sell car',
                      style: TextStyle(
                        fontSize: screenWidth * 0.052,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ✅ Banner Card
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        height: screenHeight * 0.17,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1B5E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Image.asset(
                                'assets/swift_car.png',
                                width: screenWidth * 0.42,
                                height: screenHeight * 0.16,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => Icon(
                                  Icons.directions_car,
                                  size: screenWidth * 0.2,
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                            Positioned(
                              right: screenWidth * 0.04,
                              top: screenHeight * 0.015,
                              bottom: screenHeight * 0.015,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sell Your Car Instantly.',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('Best price. Free inspection.',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.028,
                                          color: Colors.white70)),
                                  Text('Instant payment.',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.028,
                                          color: Colors.white70)),
                                  SizedBox(height: screenHeight * 0.01),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFF0D1B5E),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.04,
                                        vertical: screenHeight * 0.006,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Get Free Quote',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ Sell Vehicle label
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Text(
                          'Sell Vehicle – TN 57 BB 1010',
                          style: TextStyle(
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.018),

                      // ✅ Photo Upload Box — Dashed Border
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: GestureDetector(
                          onTap: () {},
                          child: CustomPaint(
                            painter: DashedBorderPainter(
                              color: const Color(0xFF005F65),
                              strokeWidth: 1.5,
                              dashWidth: 8,
                              dashSpace: 5,
                              borderRadius: 12,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight * 0.035),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tap to upload your photo',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.038,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    size: screenWidth * 0.12,
                                    color: const Color(0xFF005F65),
                                  ),
                                  SizedBox(height: screenHeight * 0.010),
                                  Text(
                                    'Maximum 5 MB file size',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.012),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          indent: screenWidth * 0.08,
                                          endIndent: screenWidth * 0.03,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      Text('or',
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.033,
                                              color: Colors.black45)),
                                      Expanded(
                                        child: Divider(
                                          indent: screenWidth * 0.03,
                                          endIndent: screenWidth * 0.08,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screenHeight * 0.012),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF005F65),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.12,
                                        vertical: screenHeight * 0.013,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8)),
                                    ),
                                    child: Text(
                                      'Open Camera',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.038,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.012),

                      // ✅ Add more images
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Icon(Icons.add,
                                  size: screenWidth * 0.045,
                                  color: const Color(0xFF742B88)),
                              SizedBox(width: screenWidth * 0.01),
                              Text(
                                'Add more images',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.036,
                                  color: const Color(0xFF742B88),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.014),

                      // ✅ Terms & Conditions — Gradient
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TermsAndConditionsScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFFD59090),
                                  Color(0xFFDF7B7B),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Terms & Conditions For Sell Vehicle',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.037,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.014),

                      // ✅ Allow Test Drive Checkbox
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _allowTestDrive = !_allowTestDrive;
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenWidth * 0.055,
                                height: screenWidth * 0.055,
                                child: Checkbox(
                                  value: _allowTestDrive,
                                  onChanged: (val) {
                                    setState(() {
                                      _allowTestDrive = val ?? false;
                                    });
                                  },
                                  activeColor: const Color(0xFF005F65),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3)),
                                  side: const BorderSide(
                                      color: Color(0xFF742B88), width: 1.5),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.025),
                              Text(
                                'Allow Test drive',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.037,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.014),

                      // ✅ Additional Info
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Additional Info (Optional)',
                              style: TextStyle(
                                fontSize: screenWidth * 0.037,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.010),
                            TextField(
                              controller: _additionalInfoController,
                              maxLines: 4,
                              style: TextStyle(fontSize: screenWidth * 0.037),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding:
                                EdgeInsets.all(screenWidth * 0.04),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF005F65), width: 1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),

              // ✅ Bottom Buttons
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                color: const Color(0xFFF2F2F2),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: screenHeight * 0.065,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF005F65),
                            side: const BorderSide(
                                color: Color(0xFF005F65), width: 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: SizedBox(
                        height: screenHeight * 0.065,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SellerInformationScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF005F65),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            'Save & Next',
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}

// ✅ Dashed Border Painter
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedBorderPainter({
    this.color = const Color(0xFF005F65),
    this.strokeWidth = 1.5,
    this.dashWidth = 8,
    this.dashSpace = 5,
    this.borderRadius = 12,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rrect);
    final PathMetrics metrics = path.computeMetrics();

    for (final PathMetric metric in metrics) {
      double distance = 0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
