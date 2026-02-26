import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.mobileNumber});

  final String mobileNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> otpCtrls = List.generate(
    6,
    (_) => TextEditingController(),
  );

  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  int seconds = 105; // 01:45
  Timer? timer;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (seconds == 0) {
        t.cancel();
      } else {
        setState(() => seconds--);
      }
    });
  }

  String get timeFormatted {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    for (var c in otpCtrls) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: bottomInset + h(0.04)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w(0.08)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: h(0.05)),

                  // ---------------- LOGO ----------------
                  Image.asset(
                    "assets/images/smartscore_logo.png",
                    width: w(0.7),
                    height: h(0.08),
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: h(0.04)),

                  Text(
                    "Welcome to Smartscore",
                    style: TextStyle(
                      fontSize: sp(0.045),
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: h(0.008)),

                  Text(
                    "Enter your mobile number to get started",
                    style: TextStyle(
                      fontSize: sp(0.035),
                      color: Color(0xFF2B2D42),
                    ),
                  ),

                  SizedBox(height: h(0.030)),

                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "← Change Number",
                      style: TextStyle(
                        fontSize: sp(0.035),
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.03)),

                  Text(
                    "Enter The OTP Sent To Your Mobile",
                    style: TextStyle(fontSize: sp(0.035)),
                  ),

                  SizedBox(height: h(0.025)),

                  // ---------------- OTP BOXES ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (i) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.11,
                        child: TextField(
                          controller: otpCtrls[i],
                          focusNode: focusNodes[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: "",
                            contentPadding: EdgeInsets.symmetric(
                              vertical: h(0.018),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (v) {
                            if (v.isNotEmpty && i < 5) {
                              focusNodes[i + 1].requestFocus();
                            } else if (v.isEmpty && i > 0) {
                              focusNodes[i - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: h(0.02)),

                  // ---------------- TIMER ----------------
                  Text(
                    timeFormatted,
                    style: TextStyle(
                      fontSize: sp(0.04),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: h(0.02)),

                  // ---------------- RESEND ----------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't Receive The Code? ",
                        style: TextStyle(fontSize: sp(0.035)),
                      ),
                      GestureDetector(
                        onTap: seconds == 0
                            ? () {
                                setState(() {
                                  seconds = 105;
                                  _startTimer();
                                });
                              }
                            : null,
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                            fontSize: sp(0.035),
                            color: seconds == 0
                                ? Colors.blue
                                : Colors.grey.shade400,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.04)),

                  // ---------------- VERIFY BUTTON ----------------
                  SizedBox(
                    width: double.infinity,
                    height: h(0.065),
                    child: ElevatedButton(
                      onPressed: isNavigating
                          ? null
                          : () async {
                              final otp = otpCtrls.map((e) => e.text).join();

                              if (otp.length != 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please enter valid 6-digit OTP",
                                    ),
                                  ),
                                );
                                return;
                              }

                              setState(() => isNavigating = true);
                              timer?.cancel();
                              FocusManager.instance.primaryFocus?.unfocus();

                              final navigator = Navigator.of(context);
                              await Future.delayed(
                                const Duration(milliseconds: 100),
                              );
                              if (!mounted) return;

                              navigator.pushAndRemoveUntil(
                                PageRouteBuilder(
                                  transitionDuration: const Duration(
                                    milliseconds: 250,
                                  ),
                                  pageBuilder: (c, a1, a2) =>
                                      const DashboardScreen(),
                                ),
                                (_) => false,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E6FF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Verify & Continue",
                        style: TextStyle(
                          fontSize: sp(0.045),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.06)),

                  Text(
                    "By continuing, you agree to our Terms of Service and\nPrivacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sp(0.03), color: Colors.black45),
                  ),

                  SizedBox(height: h(0.02)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
