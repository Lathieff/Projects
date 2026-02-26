import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});
  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: AppBackground.mainGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
             surfaceTintColor: Colors.transparent,
            title: const Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  bulletPoint(
                      "We collect personal, rental, device, and location information to run the service."),
                  bulletPoint(
                      "Your data is used for account management, payments, bookings, support, and app improvement."),
                  bulletPoint(
                      "Information is shared only with other users, trusted service providers, or when legally required."),
                  bulletPoint(
                      "We use security measures to protect your data, but no system is 100% secure."),
                  bulletPoint(
                      "You can access, correct, delete, or opt out of marketing communications."),
                  bulletPoint(
                      "Location data and cookies help improve nearby search and app experience."),
                  bulletPoint("The service is for users 18+ only."),
                  bulletPoint("We do not sell your personal information."),
                  bulletPoint(
                      "Policy updates will be notified through the app or email."),
                ],
              ),
            ),
          ),
        ));
  }
}
