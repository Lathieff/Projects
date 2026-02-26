import 'package:flutter/material.dart';
import '/app_image.dart';
import '../OnboardingScreen/on_boarding_screen3.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w(0.08)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: h(0.04)),

              // ---------------- SMART SCORE PILL ----------------
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w(0.04),
                  vertical: h(0.008),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppImage.company_logo,
                      width: size.width * 0.70, // ✅ correct width
                      height: size.height * 0.08,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              SizedBox(height: h(0.05)),

              // ---------------- MAIN ILLUSTRATION ----------------
              Image.asset(
                AppImage.score_check2,
                height: h(0.28),
                fit: BoxFit.contain,
              ),

              SizedBox(height: h(0.05)),

              // ---------------- TITLE ----------------
              const Text(
                "Smart Credit Management",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1F44),
                ),
              ),

              SizedBox(height: h(0.012)),

              // ---------------- SUBTITLE ----------------
              const Text(
                "Monitor your score checks and enquiry activities easily.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF013EA8)),
              ),

              SizedBox(height: h(0.03)),

              // ---------------- BULLET POINTS (CENTERED BLOCK) ----------------
              _bullet(context, "Individual & Company enquiries"),
              _bullet(context, "Credit usage tracking"),
              _bullet(context, "Subscription & credits balance"),
              _bullet(context, "Fast insights with filters & reports"),

              const Spacer(),

              // ---------------- PAGE INDICATOR (CENTERED) ----------------
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _dot(false),
                  const SizedBox(width: 6),
                  _dot(true),
                  const SizedBox(width: 6),
                  _dot(false),
                  const SizedBox(width: 6),
                ],
              ),

              SizedBox(height: h(0.025)),

              // ---------------- NEXT BUTTON ----------------
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen3(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E6FF2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "NEXT",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: h(0.03)),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- BULLET WIDGET (PERFECTLY CENTERED) ----------------
  Widget _bullet(BuildContext context, String text) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Center(
        // ✅ THIS was missing
        child: SizedBox(
          width: size.width * 0.75, // bullet block width
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Icon(Icons.circle, size: 6, color: Color(0xFF013EA8)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF013EA8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- DOT ----------------
  Widget _dot(bool active) {
    return Container(
      width: active ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
