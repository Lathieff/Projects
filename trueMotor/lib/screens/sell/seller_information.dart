import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';

class SellerInformationScreen extends StatefulWidget {
  const SellerInformationScreen({super.key});

  @override
  State<SellerInformationScreen> createState() => _SellerInformationScreenState();
}

class _SellerInformationScreenState extends State<SellerInformationScreen> {
  final TextEditingController _sellerNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();

  @override
  void dispose() {
    _sellerNameController.dispose();
    _contactNumberController.dispose();
    _cityController.dispose();
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
                      'Seller Information',
                      style: TextStyle(
                        fontSize: screenWidth * 0.052,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF005F65),
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Scrollable Body
              Expanded(
                child: SingleChildScrollView(
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
                                width: screenWidth * 0.46,
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

                      // ✅ Seller Information Label
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Text(
                          'Seller Information',
                          style: TextStyle(
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.010),

                      // ✅ Form Fields
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            // Seller Name
                            _buildLabel('Seller Name', screenWidth),
                            SizedBox(height: screenHeight * 0.006),
                            _buildTextField(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              controller: _sellerNameController,
                              hint: 'Price',
                            ),

                            SizedBox(height: screenHeight * 0.010),

                            // Contact Number
                            _buildLabel('Contact Number', screenWidth),
                            SizedBox(height: screenHeight * 0.006),
                            _buildTextField(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              controller: _contactNumberController,
                              hint: 'Contact Number',
                              keyboardType: TextInputType.phone,
                            ),

                            SizedBox(height: screenHeight * 0.010),

                            // City
                            _buildLabel('City', screenWidth),
                            SizedBox(height: screenHeight * 0.006),
                            _buildTextField(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              controller: _cityController,
                              hint: 'City',
                            ),

                            SizedBox(height: screenHeight * 0.010),

                            // Additional Info
                            _buildLabel('Additional Info (Optional)', screenWidth),
                            SizedBox(height: screenHeight * 0.004),
                            TextField(
                              controller: _additionalInfoController,
                              maxLines: 4,
                              style: TextStyle(fontSize: screenWidth * 0.037),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.all(screenWidth * 0.04),
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

                            SizedBox(height: screenHeight * 0.03),

                            // ✅ Bottom Buttons — Previous & Submit
                            Row(
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
                                            borderRadius:
                                            BorderRadius.circular(10)),
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
                                        debugPrint('Submit');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF005F65),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                      ),
                                      child: Text(
                                        'Submit',
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

                            SizedBox(height: screenHeight * 0.025),
                          ],
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
  }

  // ✅ Label Widget
  Widget _buildLabel(String text, double screenWidth) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth * 0.037,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }

  // ✅ TextField Widget
  Widget _buildTextField({
    required double screenWidth,
    required double screenHeight,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: screenWidth * 0.037),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.037,
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.016,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF005F65), width: 1.5),
        ),
      ),
    );
  }
}
