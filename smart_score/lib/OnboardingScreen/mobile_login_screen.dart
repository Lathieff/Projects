import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

import '/OnboardingScreen/signup_screen.dart';
import '/OnboardingScreen/username_login.dart';
import '/OnboardingScreen/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileCtrl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Default country → India
  String selectedCountryCode = '91';
  String selectedCountryFlag = '🇮🇳';

  @override
  void dispose() {
    mobileCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomInset + h(0.03)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(0.08)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h(0.07)),

                  /// LOGO
                  Image.asset(
                    "assets/images/smartscore_logo.png",
                    width: w(0.7),
                    height: h(0.08),
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: h(0.06)),

                  /// TITLE
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: sp(0.07),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2672F5),
                    ),
                  ),

                  SizedBox(height: h(0.008)),

                  Text(
                    "Welcome to Smartscore",
                    style: TextStyle(
                      fontSize: sp(0.05),
                      color: const Color(0xFF2672F5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: h(0.006)),

                  Text(
                    "Enter your mobile number to get started",
                    style: TextStyle(
                      fontSize: sp(0.035),
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: h(0.04)),

                  /// LABEL
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Enter Mobile Number",
                      style: TextStyle(
                        fontSize: sp(0.035),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.01)),

                  /// MOBILE INPUT
                  Container(
                    constraints: BoxConstraints(minHeight: h(0.065)),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        /// COUNTRY PICKER
                        GestureDetector(
                          onTap: () {
                            showCountryPicker(
                              context: context,
                              showPhoneCode: true,
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCountryCode = country.phoneCode;
                                  selectedCountryFlag = country.flagEmoji;
                                });
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: w(0.03),
                              vertical: h(0.012),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  selectedCountryFlag,
                                  style: TextStyle(fontSize: sp(0.06)),
                                ),
                                SizedBox(width: w(0.015)),
                                Text(
                                  "+$selectedCountryCode",
                                  style: TextStyle(
                                    fontSize: sp(0.04),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),

                        /// DIVIDER
                        SizedBox(
                          height: h(0.04),
                          child: const VerticalDivider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),

                        /// NUMBER FIELD
                        Expanded(
                          child: TextFormField(
                            controller: mobileCtrl,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: "Enter Mobile Number",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: w(0.04),
                                vertical: h(0.02),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Mobile number is required";
                              }
                              if (value.length != 10) {
                                return "Enter valid 10-digit number";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: h(0.035)),

                  /// CONTINUE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: h(0.065),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final fullNumber =
                              "+$selectedCountryCode${mobileCtrl.text}";

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OtpScreen(mobileNumber: fullNumber),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2672F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: sp(0.045),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.03)),

                  /// OR
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(0.03)),
                        child: const Text("or"),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),

                  SizedBox(height: h(0.025)),

                  /// LOGIN WITH PASSWORD
                  SizedBox(
                    width: double.infinity,
                    height: h(0.065),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserNameLoginScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2672F5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "LOGIN WITH PASSWORD",
                        style: TextStyle(
                          color: Color(0xFF2672F5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.035)),

                  /// REGISTER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't Have An Account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyRegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Please Register",
                          style: TextStyle(
                            color: Color(0xFF2672F5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.05)),

                  /// TERMS
                  const Text(
                    "By continuing, you agree to our Terms of Service and\nPrivacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
