import 'package:flutter/material.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';
import '/OnboardingScreen/signup_screen.dart';
import '/OnboardingScreen/mobile_login_screen.dart';


class UserNameLoginScreen extends StatefulWidget {
  const UserNameLoginScreen({super.key});

  @override
  State<UserNameLoginScreen> createState() => _UserNameLoginScreenState();
}

class _UserNameLoginScreenState extends State<UserNameLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isPasswordHidden = true;

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
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
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomInset + h(0.02)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w(0.08)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h(0.05)),

                  // ---------------- LOGO ----------------
                  Image.asset(
                    "assets/images/smartscore_logo.png",
                    width: w(0.65), // Adjusted width
                    height: h(0.12), // Adjusted height
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: h(0.04)), // Reduced gap
                  // ---------------- TITLE ----------------
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: sp(0.075),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E6FF2),
                    ),
                  ),

                  SizedBox(height: h(0.01)),

                  Text(
                    "Welcome to Smartscore",
                    style: TextStyle(
                      fontSize: sp(0.05),
                      color: const Color(0xFF2E6FF2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: h(0.04)),

                  // ---------------- USERNAME ----------------
                  TextFormField(
                    controller: usernameCtrl,
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: const TextStyle(color: Colors.black38),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: w(0.02),
                        vertical: h(0.01),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username is required";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: h(0.025)),

                  // ---------------- PASSWORD ----------------
                  TextFormField(
                    controller: passwordCtrl,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.black38),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: w(0.02),
                        vertical: h(0.01),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF817979)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(165, 189, 189, 189),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: h(0.01)),

                  // ---------------- FORGOT PASSWORD ----------------
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: sp(0.035),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.03)),

                  // ---------------- LOGIN BUTTON ----------------
                  SizedBox(
                    width: double.infinity,
                    height: h(0.065),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E6FF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: sp(0.045),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.025)),

                  const Text(
                    "or",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: h(0.025)),

                  // ---------------- LOGIN WITH MOBILE ----------------
                  SizedBox(
                    width: double.infinity,
                    height: h(0.065),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2E6FF2)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "LOGIN WITH MOBILE NUMBER",
                        style: TextStyle(
                          fontSize: sp(0.040),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2E6FF2),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.03)),

                  // ---------------- REGISTER ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t Have An Account? ",
                        style: TextStyle(
                          fontSize: sp(0.035),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
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
                        child: Text(
                          "Please Register",
                          style: TextStyle(
                            fontSize: sp(0.035),
                            color: const Color(0xFF2E6FF2),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: const Color(0xFF2E6FF2),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.08)),

                  Text(
                    "By continuing, you agree to our Terms of Service and\nPrivacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: sp(0.03),
                      color: Colors.grey.shade500,
                    ),
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
