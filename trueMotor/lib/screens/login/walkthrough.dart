import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class WalkthroughScreen extends StatefulWidget {
  const WalkthroughScreen({super.key});

  @override
  State<WalkthroughScreen> createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final int _totalPages = 2;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _totalPages - 1) {
        _onNext();
      } else {
        _timer?.cancel();
      }
    });
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void _onNext() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _timer?.cancel();
      _goToLogin(); // Last page — Get Started
    }
  }

  void _onSkip() {
    _timer?.cancel();
    _goToLogin(); // Skip — direct to Login
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _totalPages - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button — hidden on last page
            if (!isLastPage)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 20),
                  child: GestureDetector(
                    onTap: _onSkip,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xFF006D5B),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF006D5B),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF006D5B),
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 44),

            // PageView — swipe enabled
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                  // If user swipes to the last page, cancel the timer
                  if (index == _totalPages - 1) {
                    _timer?.cancel();
                  }
                },
                children: const [_WalkthroughPage1(), _WalkthroughPage2()],
              ),
            ),

            // Static Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalPages, (index) {
                final bool isActive = _currentPage == index;
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 32 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF006D5B)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Next / Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006D5B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    isLastPage ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Page 1 — Buy & Sell with Ease
// ─────────────────────────────────────────────
class _WalkthroughPage1 extends StatelessWidget {
  const _WalkthroughPage1();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        Image.asset(
          'assets/login/walkthrough_1.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        const Spacer(),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Buy & Sell with Ease',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Browse top vehicle listings, compare models, or list your own vehicle for sale in just a few taps.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
          ),
        ),

        const Spacer(flex: 2),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Page 2 — Choose. Book. Drive.
// ─────────────────────────────────────────────
class _WalkthroughPage2 extends StatelessWidget {
  const _WalkthroughPage2();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Image.asset(
            'assets/login/walkthrough_2.png',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),

        const Spacer(),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'Choose. Book. Drive.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

        const SizedBox(height: 16),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Find a wide range of vehicles for rent — from budget-friendly hatchbacks to premium SUVs.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
          ),
        ),

        const Spacer(flex: 2),
      ],
    );
  }
}