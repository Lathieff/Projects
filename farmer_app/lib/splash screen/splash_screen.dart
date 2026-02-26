import 'package:farmer_app/theme/bg.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../Login/entry_screen.dart';
import 'package:farmer_app/services/auth_service.dart';
import 'package:farmer_app/services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Start animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        startAnimation = true;
      });
      _controller.forward();
    });

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SplashScreen2(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[300]!,
              const Color(0xFFD4C5A0),
              const Color(0xFF8B7355),
            ],
          ),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              top: h * 0.42,
              left: startAnimation ? w * 0.28 : -180,
              child: AnimatedScale(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                scale: startAnimation ? 1.1 : 0.8,
                child: Image.asset(
                  'assets/images/tractor.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  String _statusText = "Detecting Location...";

  @override
  void initState() {
    super.initState();
    _startApp();
  }

  Future<void> _startApp() async {
    // Initial delay for splash visual
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      await _checkLocationAndNavigate();
    }
  }

  Future<void> _checkLocationAndNavigate() async {
    bool serviceEnabled = await LocationService.isServiceEnabled();

    if (!serviceEnabled) {
      // Show dialog if location is off
      if (mounted) {
        await _showLocationServiceDialog();
      }
      return;
    }

    bool hasPermission = await LocationService.handleLocationPermission();
    if (hasPermission) {
      await LocationService.updateCurrentLocation();
      if (mounted) {
        setState(() {
          _statusText = LocationService.currentCity;
        });
        // Show the location for a moment
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    if (mounted) {
      bool isLoggedIn = await AuthService.isLoggedIn();
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _navigateToHome();
      }
    }
  }

  Future<void> _showLocationServiceDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Location Services Disabled"),
        content: const Text(
            "Please turn on your location to get local weather and crop advice."),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openLocationSettings();
              // Check again after returning from settings
              _checkLocationAndNavigate();
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToHome(); // Proceed anyway with default
            },
            child: const Text("Later"),
          ),
        ],
      ),
    );
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const FarmerScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppBackground.mainGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tractor.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              _statusText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            if (_statusText == "Detecting Location...")
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: CircularProgressIndicator(
                  color: Color(0xFF2E7D32),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
