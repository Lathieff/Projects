import 'package:flutter/material.dart';
import '/OnboardingScreen/username_login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: "assets/images/onboarding1.gif",
      title: "Instant Credit Score Check",
      description: "Get accurate and secure credit scores in seconds.",
      bullets: [
        "Check ChitScore, MicroScore, and SmartScore",
        "OTP / Non-OTP verification",
        "Secure & reliable score data",
        "Track your score history anytime",
      ],
    ),
    OnboardingContent(
      image: "assets/images/onboarding2.gif",
      title: "Smart Credit Management",
      description: "Monitor your score checks and enquiry activities easily.",
      bullets: [
        "Individual & Company enquiries",
        "Credit usage tracking",
        "Subscription & credits balance",
        "Fast insights with filters & reports",
      ],
    ),
    OnboardingContent(
      image: "assets/images/onboarding3.gif",
      title: "Instant Support",
      description: "Raise issues and get quick resolutions through the app.",
      bullets: [
        "Track status in real time",
        "Auto-notify admin",
        "Faster response and support",
      ],
    ),
  ];

  void _goToNext() {
    if (_currentPage < _contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const UserNameLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // 🔹 Responsive helpers
    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v; // font scaling

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: h(0.12)),

                // ---------------- LOGO ----------------
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: w(0.04),
                    vertical: h(0.008),
                  ),
                  child: Image.asset(
                    "assets/images/smartscore_logo.png",
                    width: w(0.60),
                    height: h(0.06),
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: h(0.02)),

                // ---------------- PAGE VIEW ----------------
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _contents.length,
                    itemBuilder: (context, index) {
                      final content = _contents[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: w(0.08)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(flex: 1),

                            // ---------------- IMAGE ----------------
                            Image.asset(
                              content.image,
                              height: h(0.25),
                              fit: BoxFit.contain,
                            ),

                            const Spacer(flex: 1),

                            // ---------------- TITLE ----------------
                            Text(
                              content.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: sp(
                                  0.06,
                                ), // Matches screenshot large title
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF00067E), // Deep Blue
                              ),
                            ),

                            SizedBox(height: h(0.019)),

                            // ---------------- SUBTITLE ----------------
                            Text(
                              content.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: sp(0.040),
                                color: const Color(0xFF013EA8), // Blueish
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(height: h(0.01)),

                            // ---------------- BULLETS ----------------
                            // Align bullets to the start visually, but center the block
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: content.bullets
                                    .map((b) => _bullet(context, b))
                                    .toList(),
                              ),
                            ),

                            const Spacer(flex: 2),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // ---------------- PAGE INDICATOR ----------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _contents.length,
                    (index) => _dot(index == _currentPage),
                  ),
                ),

                SizedBox(height: h(0.04)),

                // ---------------- NEXT BUTTON ----------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w(0.08)),
                  child: SizedBox(
                    width: double.infinity,
                    height: h(0.065),
                    child: ElevatedButton(
                      onPressed: _goToNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E6FF2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                          fontSize: sp(0.045),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h(0.05)),
              ],
            ),

            if (_currentPage == 0)
              Positioned(
                top: h(0.03),
                right: w(0.04),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: sp(0.05),
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2E6FF2),
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF2E6FF2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- BULLET ----------------
  Widget _bullet(BuildContext context, String text) {
    final size = MediaQuery.of(context).size;
    final sp = size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6, right: 10),
            child: Icon(Icons.circle, size: 5, color: const Color(0xFF013EA8)),
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                children: _parseBulletText(text, sp * 0.04),
                style: TextStyle(
                  fontSize: sp * 0.04,
                  color: const Color(0xFF013EA8), // Blue text
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _parseBulletText(String text, double fontSize) {
    // Basic rich text parsing to match colorful screenshots if needed
    // "Check ChitScore, MicroScore, and SmartScore" -> ChitScore (Green), MicroScore (Pink), SmartScore (Blue)
    // This is hardcoded for the specific string in the screenshot
    if (text.contains("ChitScore")) {
      return [
        const TextSpan(
          text: "Check ",
          style: TextStyle(color: Color(0xFF013EA8)),
        ),
        const TextSpan(
          text: "ChitScore",
          style: TextStyle(color: Color(0xFF4CAF50)),
        ), // Green
        const TextSpan(
          text: ", ",
          style: TextStyle(color: Color(0xFF013EA8)),
        ),
        const TextSpan(
          text: "MicroScore",
          style: TextStyle(color: Color(0xFFE91E63)),
        ), // Pink
        const TextSpan(
          text: ", and ",
          style: TextStyle(color: Color(0xFF013EA8)),
        ),
        const TextSpan(
          text: "SmartScore",
          style: TextStyle(color: Color(0xFF2E6FF2)),
        ), // Blue
      ];
    }

    // For other bullets, just return default style
    // Screenshot 2 & 3 have all blue bullets
    return [
      TextSpan(
        text: text,
        style: const TextStyle(color: Color(0xFF013EA8)),
      ),
    ];
  }

  // ---------------- DOT ----------------
  Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF2E6FF2) : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;
  final List<String> bullets;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
    required this.bullets,
  });
}
