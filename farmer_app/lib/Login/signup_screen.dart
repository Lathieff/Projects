import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:farmer_app/services/auth_service.dart';
import 'package:farmer_app/theme/bg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isOtpVisible = false;
  bool _isOtpFilled = false;
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes =
      List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _onPhoneChanged() {
    // Removed automatic OTP visibility trigger
  }

  void _checkOtpFilled() {
    bool filled =
        _otpControllers.every((controller) => controller.text.isNotEmpty);
    if (_isOtpFilled != filled) {
      setState(() {
        _isOtpFilled = filled;
      });
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) {
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google Sign-In Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Handle keyboard manually for the bottom card
      body: Stack(
        children: [
          Container(
            height: height,
            decoration:
                const BoxDecoration(gradient: AppBackground.mainGradient),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.05),
                      // Farmer illustration with green circle background
                      Container(
                        width: width * 0.5,
                        height: width * 0.5,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/login.png', // Add your farmer image here
                            width: width * 0.5,
                            height: width * 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      // Sign Up Title
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      // Name Input
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF66BB6A)),
                        ),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your name',
                            hintStyle: TextStyle(
                              color: const Color(0xFF1B5E20),
                              fontWeight: FontWeight.w500,
                              fontSize: width * 0.035,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                                vertical: height * 0.018),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: const Color(0xFF1B5E20),
                              size: width * 0.05,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      // Phone Number Input
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF66BB6A)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03),
                              decoration: const BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Color(0xFF66BB6A)),
                                ),
                              ),
                              child: Text(
                                '+91',
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  color: const Color(0xFF1B5E20),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: 'Enter mobile number',
                                  hintStyle: TextStyle(
                                    color: const Color(0xFF1B5E20),
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * 0.035,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: width * 0.04,
                                      vertical: height * 0.018),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      // Send OTP Button
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.065,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_phoneController.text.length == 10) {
                              setState(() {
                                _isOtpVisible = true;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please enter a valid 10-digit number')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'SEND OTP',
                            style: TextStyle(
                              fontSize: width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Or continue with
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color(0xFF2E7D32),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.03),
                            child: Text(
                              'or continue with',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.025),
                      // Social Login Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Google
                          _buildSocialButton(
                            icon: FontAwesomeIcons.google,
                            color: Colors.white,
                            iconColor: const Color(0xFFDB4437),
                            onTap: () {
                              _signInWithGoogle();
                            },
                            size: width * 0.14,
                          ),

                          SizedBox(width: width * 0.05),
                          // LinkedIn
                          _buildSocialButton(
                            icon: FontAwesomeIcons.instagram,
                            color: const Color.fromARGB(255, 182, 43, 96),
                            iconColor: Colors.white,
                            onTap: () {
                              // Handle Instagram login
                            },
                            size: width * 0.14,
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isOtpVisible)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  width * 0.06,
                  width * 0.08,
                  width * 0.06,
                  width * 0.08 + MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'verify otp',
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    Text(
                      'Waiting to automatically detect an OTP sent to',
                      style: TextStyle(
                        fontSize: width * 0.03,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '+91 ${_phoneController.text}. ',
                          style: TextStyle(
                            fontSize: width * 0.03,
                            color: Colors.grey[600],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isOtpVisible = false;
                            });
                          },
                          child: Text(
                            'Wrong Number ?',
                            style: TextStyle(
                              fontSize: width * 0.03,
                              color: const Color(0xFF2E7D32),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => SizedBox(
                          width: width * 0.12,
                          height: width * 0.12,
                          child: TextField(
                            controller: _otpControllers[index],
                            focusNode: _otpFocusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              counterText: "",
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Color(0xFF66BB6A)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xFF2E7D32), width: 2),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.length == 1 && index < 5) {
                                _otpFocusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _otpFocusNodes[index - 1].requestFocus();
                              }
                              _checkOtpFilled();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Resend OTP
                          },
                          child: Text(
                            'Resend OTP in',
                            style: TextStyle(
                              fontSize: width * 0.035,
                              color: const Color(0xFF2E7D32),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          '30 Sec',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.04),
                    SizedBox(
                      width: double.infinity,
                      height: height * 0.065,
                      child: ElevatedButton(
                        onPressed: _isOtpFilled
                            ? () async {
                                await AuthService.saveUser(
                                  _nameController.text.isNotEmpty
                                      ? _nameController.text
                                      : "Farmer",
                                  _phoneController.text,
                                );
                                if (context.mounted) {
                                  Navigator.pushNamed(context, '/home');
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isOtpFilled
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFA5D6A7),
                          disabledBackgroundColor: const Color(0xFFA5D6A7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'VERIFY & CONTINUE',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
    required double size,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: FaIcon(
            icon,
            color: iconColor,
            size: size * 0.43,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
