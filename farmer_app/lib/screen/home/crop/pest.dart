import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class PestPage extends StatelessWidget {
  const PestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: AppBackground.mainGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B5E20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Pest",
          style: TextStyle(
            color: Color(0xFF1B5E20),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Colors.black87),
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "Common pest and diseses",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildPestCard(
                        context: context,
                        title: "Pink Balloworm",
                        crop: "Cotton",
                        description:
                            "Pink Colored larvae ,damaged balls,exist holes in balls",
                        severity: "High",
                        severityColor: const Color(0xFFFFEBEE),
                        severityTextColor: const Color(0xFFD32F2F),
                        imagePath: "assets/images/pest_bug.png",
                      ),
                      const SizedBox(height: 15),
                      _buildPestCard(
                        context: context,
                        title: "Leaf Curl Virus",
                        crop: "Tomato",
                        description:
                            "Upwards Curling of leaves,yellowing,stunted growth",
                        severity: "Medium",
                        severityColor: const Color(0xFFFFF3E0),
                        severityTextColor: const Color(0xFFEF6C00),
                        imagePath: "assets/images/pest_bug.png",
                      ),
                      const SizedBox(height: 15),
                      _buildPestCard(
                        context: context,
                        title: "Aphids",
                        crop: "Multiple crops",
                        description:
                            "Small insects on leaves, honeydews secretion,leaf curling",
                        severity: "Low",
                        severityColor: const Color(0xFFFFFDE7),
                        severityTextColor: const Color(0xFFFBC02D),
                        imagePath: "assets/images/pest_bug.png",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPestCard({
    required BuildContext context,
    required String title,
    required String crop,
    required String description,
    required String severity,
    required Color severityColor,
    required Color severityTextColor,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9).withValues(alpha:0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: const Icon(Icons.bug_report, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          // Content
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: severityColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        severity,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: severityTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  crop,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
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
