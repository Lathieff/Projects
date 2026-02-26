import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                gradient: AppBackground.mainGradient,
              ), 
              child:Scaffold(
                backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Community",
          style: TextStyle(
            color: Color(0xFF2E7D32),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
         scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Image.asset(
              'assets/images/tractor_community.png',
              width: double.infinity,
              height: screenHeight * 0.3,
              fit: BoxFit.cover,
            ),

            // Admin Message Banner
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Only admin can send message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
               Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  _buildAlertCard(
                    screenWidth: screenWidth,
                    title: "WEATHER ALERT",
                    time: "10:30AM",
                    content:
                        "Heavy rainfall expected today. Take necessary crop protection measures.",
                    gifPath: "assets/gif/alert.gif",
                    showLeadingImage: true,
                  ),
                  const SizedBox(height: 16),
                  _buildAlertCard(
                    screenWidth: screenWidth,
                    title: "CROP CARE",
                    time: "Yesterday",
                    content:
                        "Maintain proper soil moisture for healthy crop growth.",
                    gifPath: "assets/gif/crop.gif",
                    showLeadingImage: true,
                  ),
                  const SizedBox(height: 16),
                  _buildAlertCard(
                    screenWidth: screenWidth,
                    title: "UPDATE",
                    time: "2 days ago",
                    content: "Early morning is best time for irrigation.",
                    gifPath: "assets/gif/update.gif",
                    showLeadingImage: true,
                  ),
                  const SizedBox(height: 80), // Extra space at bottom
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  Widget _buildAlertCard({
    required double screenWidth,
    required String title,
    required String time,
    required String content,
    required String gifPath,
    bool showLeadingImage = true,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLeadingImage)
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  gifPath,
                  width: screenWidth * 0.18,
                  height: screenWidth * 0.18,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
