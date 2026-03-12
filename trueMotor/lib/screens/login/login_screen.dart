import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:truemotor/screens/login/otp_screen.dart';
import 'package:truemotor/screens/login/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  String _dialCode = '+91';

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.06),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: sh * 0.06),
                  Center(
                    child: Image.asset(
                      'assets/login/login.png',
                      width: sw * 0.56,
                      height: sh * 0.24,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: sh * 0.02),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: const Color(0xFF222222),
                      fontSize: sw * 0.055,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: sh * 0.012),
                  IntlPhoneField(
                    focusNode: _phoneFocus,
                    controller: _phoneController,
                    initialCountryCode: 'IN',
                    disableLengthCheck: true,
                    flagsButtonPadding: EdgeInsets.only(left: sw * 0.02),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    dropdownIconPosition: IconPosition.trailing,
                    keyboardType: TextInputType.phone,
                    inputFormatters: const [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter mobile number',
                      hintStyle: TextStyle(
                        color: const Color(0xFF9A9A9A),
                        fontSize: sw * 0.032,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFEFEFEF),
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: sw * 0.03,
                        vertical: sh * 0.014,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFC8C8C8)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF006D73), width: 1.3),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red, width: 1.3),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red, width: 1.3),
                      ),
                    ),
                    validator: (value) {
                      final digits = value?.number.replaceAll(RegExp(r'\D'), '') ?? '';
                      if (digits.isEmpty) {
                        return 'Mobile number is required (e.g. 9876543210)';
                      }
                      if (digits.length != 10) {
                        return 'Enter a 10-digit mobile number (e.g. 9876543210)';
                      }
                      return null;
                    },
                    onChanged: (phone) {
                      setState(() {
                        _dialCode = phone.countryCode;
                      });
                    },
                  ),
                  SizedBox(height: sh * 0.012),
                  Text(
                    'We will send a one-time password to $_dialCode ${_phoneController.text.isEmpty ? 'XXXXXXXXXX' : _phoneController.text}',
                    style: TextStyle(
                      color: const Color(0xFF6B6B6B),
                      fontSize: sw * 0.030,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: sh * 0.018),
                  SizedBox(
                    width: double.infinity,
                    height: sh * 0.060,
                    child: ElevatedButton(
                      onPressed: () {
                        final isValid = _formKey.currentState?.validate() ?? false;
                        if (!isValid) {
                          _phoneFocus.requestFocus();
                          return;
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const OtpScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006D73),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: sw * 0.040,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.022),
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Color(0xFFBBBBBB))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
                        child: Text(
                          'or continue with',
                          style: TextStyle(
                            color: const Color(0xFF8A8A8A),
                            fontSize: sw * 0.030,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Color(0xFFBBBBBB))),
                    ],
                  ),
                  SizedBox(height: sh * 0.022),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialIcon('assets/login/icon/google_icon.png', sw),
                      SizedBox(width: sw * 0.06),
                      _socialIcon('assets/login/icon/facebook_icon.png', sw),
                      SizedBox(width: sw * 0.06),
                      _socialIcon('assets/login/icon/apple_icon.png', sw),
                    ],
                  ),
                  SizedBox(height: sh * 0.022),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't Have An Account? ",
                        style: TextStyle(
                          color: const Color(0xFF2A2A2A),
                          fontSize: sw * 0.030,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SignupScreen()),
                          );
                        },
                        child: Text(
                          'Register Now',
                          style: TextStyle(
                            color: const Color(0xFF1F2D99),
                            fontSize: sw * 0.030,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: sh * 0.040),
                  Center(
                    child: Text(
                      'By Continuing you agree to our',
                      style: TextStyle(
                        color: const Color(0xFF7B7B7B),
                        fontSize: sw * 0.025,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        color: const Color(0xFF3B3B3B),
                        fontSize: sw * 0.025,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: sh * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath, double sw) {
    return Image.asset(
      assetPath,
      width: sw * 0.10,
      height: sw * 0.10,
      fit: BoxFit.contain,
    );
  }
}
