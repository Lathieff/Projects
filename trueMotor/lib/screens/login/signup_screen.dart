import 'package:flutter/material.dart';
import 'package:truemotor/screens/login/login_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sh * 0.06),
                Center(
                  child: Image.asset(
                    'assets/login/signup.png',
                    width: sw * 0.58,
                    height: sh * 0.24,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: sh * 0.02),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: const Color(0xFF222222),
                    fontSize: sw * 0.055,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: sh * 0.012),
                _input(sw, sh, 'Enter Your Name'),
                SizedBox(height: sh * 0.012),
                _input(sw, sh, 'Enter Mobile Number'),
                SizedBox(height: sh * 0.012),
                _input(sw, sh, 'Enter Mail ID'),
                SizedBox(height: sh * 0.022),
                SizedBox(
                  width: double.infinity,
                  height: sh * 0.060,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
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
                      'GET STARTED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: sw * 0.035,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.022),
                const Divider(color: Color(0xFFBBBBBB)),
                SizedBox(height: sh * 0.018),
                Center(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'Already have an Account? ',
                        style: TextStyle(
                          color: const Color(0xFF2A2A2A),
                          fontSize: sw * 0.028,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: const Color(0xFF1F2D99),
                            fontSize: sw * 0.028,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: sh * 0.012),
                Center(
                  child: Text(
                    'T&C\'s . Privacy policy',
                    style: TextStyle(
                      color: const Color(0xFF5A5A5A),
                      fontSize: sw * 0.026,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: sh * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _input(double sw, double sh, String hint) {
    return SizedBox(
      height: sh * 0.060,
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color(0xFF8E8E8E),
            fontSize: sw * 0.032,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: sw * 0.03),
          filled: true,
          fillColor: const Color(0xFFF3F3F3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFBEBEBE)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFBEBEBE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF006D73), width: 1.3),
          ),
        ),
      ),
    );
  }
}
