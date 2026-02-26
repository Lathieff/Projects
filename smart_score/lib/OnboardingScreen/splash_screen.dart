import 'dart:async';
import 'package:flutter/material.dart';
import '/OnboardingScreen/on_boarding_screen.dart';

class SmartScoreScreen extends StatefulWidget {
  const SmartScoreScreen({super.key});

  @override
  State<SmartScoreScreen> createState() => _SmartScoreScreenState();
}

class _SmartScoreScreenState extends State<SmartScoreScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ 5 seconds delay
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // 🔹 Background Gradient
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF5B9DFF), Color(0xFF1BA7A6), Color(0xFF0DB14B)],
          ),
        ),

        // 🔹 Center Logo
        child: Center(
          child: Image.asset(
            "assets/images/smartscore_logo.png",
            width: size.width * 0.80,
            height: size.height * 0.110,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
