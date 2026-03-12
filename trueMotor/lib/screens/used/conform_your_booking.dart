import 'package:flutter/material.dart';

class ConformYourBookingScreen extends StatefulWidget {
  const ConformYourBookingScreen({super.key});

  @override
  State<ConformYourBookingScreen> createState() => _ConformYourBookingScreenState();
}

class _ConformYourBookingScreenState extends State<ConformYourBookingScreen> {
  bool _termsAccepted = false;

  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
    _emailController.dispose();
    _deliveryController.dispose();
    super.dispose();
  }

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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Conform Your Booking',
          style: TextStyle(
            color: Color(0xFF0B664A),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(sw * 0.03, sh * 0.01, sw * 0.03, sh * 0.02),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.03),
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/swift.png',
                  height: sh * 0.16,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: sh * 0.008),
              _infoRow(sw, 'Model :', 'Maruti Suzuki Swift', valueColor: const Color(0xFF2101AF)),
              _infoRow(sw, 'Varient :', 'VXI 2021, Red', valueColor: const Color(0xFF742B88)),
              _infoRow(sw, 'Price :', '₹ 9.2 Lakh'),
              _infoRow(sw, 'Price Breakdown :', 'Ex-Showroom, RTO,'),
              _infoRow(sw, 'Buyer Detail :', 'Insurance'),
              _infoRow(sw, 'Full Name', ''),
              SizedBox(height: sh * 0.006),
              _inputField(sw, _contactController, 'Contact Number'),
              SizedBox(height: sh * 0.008),
              _inputField(sw, _emailController, 'Email Address'),
              SizedBox(height: sh * 0.008),
              _inputField(sw, _deliveryController, 'Delivery Address'),
              SizedBox(height: sh * 0.008),
              _dropdownField(sw),
              SizedBox(height: sh * 0.01),
              Text(
                'Estimate Delivery : 7-10 Days',
                style: TextStyle(
                  fontSize: sw * 0.033,
                  color: const Color(0xFF3B3B3B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: sh * 0.003),
              Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    onChanged: (v) => setState(() => _termsAccepted = v ?? false),
                    activeColor: const Color(0xFF8B429A),
                    side: const BorderSide(color: Color(0xFF8B429A)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Expanded(
                    child: Text(
                      'I agree to the terms & conditions',
                      style: TextStyle(
                        fontSize: sw * 0.031,
                        color: const Color(0xFF6A6A6A),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh * 0.006),
              SizedBox(
                width: double.infinity,
                height: sh * 0.06,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006B66),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(
                    'Conform & Proceed to Payment',
                    style: TextStyle(
                      fontSize: sw * 0.037,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(double sw, String label, String value, {Color valueColor = const Color(0xFF1D1D1D)}) {
    return Padding(
      padding: EdgeInsets.only(bottom: sw * 0.003),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: sw * 0.033, color: const Color(0xFF1D1D1D)),
          children: [
            TextSpan(text: '$label '),
            TextSpan(
              text: value,
              style: TextStyle(
                color: valueColor,
                fontWeight: value.isEmpty ? FontWeight.w400 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(double sw, TextEditingController controller, String hint) {
    return SizedBox(
      height: sw * 0.105,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: sw * 0.032, color: const Color(0xFF5B5B5B)),
          contentPadding: EdgeInsets.symmetric(horizontal: sw * 0.025, vertical: sw * 0.015),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF8B429A)),
          ),
          filled: true,
          fillColor: const Color(0xFFECECEC),
        ),
      ),
    );
  }

  Widget _dropdownField(double sw) {
    return Container(
      height: sw * 0.105,
      padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF9E9E9E)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Required Documents: ID & Address Proof',
              style: TextStyle(fontSize: sw * 0.031, color: const Color(0xFF1D1D1D)),
            ),
          ),
          Icon(Icons.keyboard_arrow_down, size: sw * 0.05, color: const Color(0xFF5B5B5B)),
        ],
      ),
    );
  }
}
