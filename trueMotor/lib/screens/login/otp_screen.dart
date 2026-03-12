import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truemotor/screens/home/home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  bool _isOtpComplete() {
    return _controllers.every((c) => c.text.trim().length == 1);
  }

  void _onVerify() {
    if (!_isOtpComplete()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter complete OTP')),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F3F3),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B6B6F)),
        ),
        titleSpacing: 0,
        title: Text(
          'OTP Verification',
          style: TextStyle(
            color: const Color(0xFF2A2A2A),
            fontSize: sw * 0.040,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
        child: Column(
          children: [
            SizedBox(height: sh * 0.03),
            Image.asset(
              'assets/login/otp.png',
              width: sw * 0.58,
              height: sh * 0.23,
              fit: BoxFit.contain,
            ),
            SizedBox(height: sh * 0.02),
            Text(
              'Your One Time Password (OTP) has been\nSend via SMS to Registered Mobile Number',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF494949),
                fontSize: sw * 0.030,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: sh * 0.022),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                (index) => _otpBox(sw, sh, index),
              ),
            ),
            SizedBox(height: sh * 0.02),
            Row(
              children: [
                Text(
                  'Resend OTP in',
                  style: TextStyle(
                    color: const Color(0xFF2F8D90),
                    fontSize: sw * 0.032,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: sw * 0.02),
                Text(
                  '30 Sec',
                  style: TextStyle(
                    color: const Color(0xFF2F8D90),
                    fontSize: sw * 0.032,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: sh * 0.03),
            SizedBox(
              width: double.infinity,
              height: sh * 0.058,
              child: ElevatedButton(
                onPressed: _onVerify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006D73),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'VERIFY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: sw * 0.038,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpBox(double sw, double sh, int index) {
    return Container(
      width: sw * 0.12,
      height: sh * 0.055,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF6FA3A8)),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          isCollapsed: true,
        ),
        style: TextStyle(
          fontSize: sw * 0.05,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1F1F1F),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}
