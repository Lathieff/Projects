import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth  = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
                    SizedBox(width: screenWidth * 0.04),
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: screenWidth * 0.052,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF005F65),
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ✅ Intro — left aligned
                      Text(
                        'By listing your vehicle for sale on the True Motors platform, you agree to the following terms and conditions:',
                        style: TextStyle(
                          fontSize: screenWidth * 0.036,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // ✅ Sections — indented
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '1.',
                              title: 'Eligibility',
                              bullets: [
                                'The seller must be the legal owner or an authorized representative of the vehicle.',
                                'The vehicle must not be stolen, under legal dispute, or restricted from resale.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '2.',
                              title: 'Vehicle Details',
                              bullets: [
                                'All vehicle information (make, model, year, mileage, condition, etc.) must be accurate and truthful.',
                                'Misrepresentation may lead to account suspension and removal of listings.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '3.',
                              title: 'Ownership & Documentation',
                              bullets: [
                                'The seller must have valid ownership documents, including:',
                              ],
                              subBullets: [
                                'RC (Registration Certificate)',
                                'Pollution Certificate',
                                'Insurance (active or expired copy)',
                                'ID proof of seller',
                              ],
                              trailingBullets: [
                                'The seller is responsible for facilitating ownership transfer after sale.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '4.',
                              title: 'Pricing and Payments',
                              bullets: [
                                'Vehicle price is set by the seller. True Motors does not interfere with pricing.',
                                'True Motors does not handle payments directly unless agreed in advance through escrow or premium plans.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '5.',
                              title: 'Vehicle Condition & Inspection',
                              bullets: [
                                'The seller must allow inspection or test drive, if requested by the buyer.',
                                'Vehicles must be in the stated condition at the time of handover.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '6.',
                              title: 'Liability Disclaimer',
                              bullets: [
                                'True Motors acts as a digital listing platform only.',
                                'We are not responsible for disputes, payment defaults, or legal issues between buyer and seller.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '7.',
                              title: 'Listing Removal',
                              bullets: [
                                'True Motors reserves the right to remove any listing that violates its terms, is reported fake, or is inactive.',
                              ],
                            ),

                            _buildSection(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              number: '8.',
                              title: 'Privacy and Communication',
                              bullets: [
                                'By listing, you agree to be contacted by potential buyers and the True Motors team.',
                                'Your contact details are shared with buyers only upon serious inquiry.',
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  // ✅ Section Builder
  Widget _buildSection({
    required double screenWidth,
    required double screenHeight,
    required String number,
    required String title,
    required List<String> bullets,
    List<String>? subBullets,
    List<String>? trailingBullets,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.018),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$number ',
                style: TextStyle(
                  fontSize: screenWidth * 0.036,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.036,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.006),

          // Main Bullets
          ...bullets.map((b) => _buildBullet(b, screenWidth, screenHeight)),

          // Sub Bullets (indented)
          if (subBullets != null)
            ...subBullets.map(
                    (s) => _buildSubBullet(s, screenWidth, screenHeight)),

          // Trailing Bullets
          if (trailingBullets != null)
            ...trailingBullets.map(
                    (t) => _buildBullet(t, screenWidth, screenHeight)),
        ],
      ),
    );
  }

  // ✅ Bullet Item
  Widget _buildBullet(String text, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.006),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.006),
            child: Container(
              width: screenWidth * 0.015,
              height: screenWidth * 0.015,
              decoration: const BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.025),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.034,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Sub Bullet Item (indented)
  Widget _buildSubBullet(String text, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.only(
          left: screenWidth * 0.05, bottom: screenHeight * 0.005),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.006),
            child: Container(
              width: screenWidth * 0.012,
              height: screenWidth * 0.012,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black87, width: 1.2),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.025),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: screenWidth * 0.034,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
