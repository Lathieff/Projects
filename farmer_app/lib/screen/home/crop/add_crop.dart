import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';
import 'package:farmer_app/widgets/custom_bottom_nav.dart';

class AddCropPage extends StatelessWidget {
  const AddCropPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context); // Goes back to Home
      },
      child: Container(
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "Crop Information",
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: false,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Stats Cards Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatCard(
                            screenWidth: screenWidth,
                            label: "Active Crops",
                            value: "3",
                            iconPath: "assets/icon/active_crops.png",
                          ),
                          _buildStatCard(
                            screenWidth: screenWidth,
                            label: "Active Land",
                            value: "15",
                            iconPath: "assets/icon/active_land.png",
                            isLand: true,
                          ),
                          _buildStatCard(
                            screenWidth: screenWidth,
                            label: "Empty Land",
                            value: "10",
                            iconPath: "assets/icon/empty_land.png",
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Action Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/add_new_crop"),
                            child: _buildActionButton(
                              screenWidth: screenWidth,
                              label: "Add",
                              icon: Icons.add,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/timeline"),
                            child: _buildActionButton(
                              screenWidth: screenWidth,
                              label: "Timeline",
                              icon: Icons.access_time_filled,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, "/pest"),
                            child: _buildActionButton(
                              screenWidth: screenWidth,
                              label: "Pest",
                              icon: Icons.bug_report,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Crop List
                      _buildCropDetailCard(
                        context: context,
                        screenWidth: screenWidth,
                        name: "Tomato",
                        acres: "2 Acres",
                        date: "1/12/25",
                        status: "Growing",
                        statusColor: const Color(0xFFBBDEFB),
                        statusTextColor: const Color(0xFF1976D2),
                        invest: "₹ 45k",
                        expected: "₹ 12k",
                        profit: "₹ 75k",
                        imagePath: "assets/images/tomato.png",
                      ),
                      const SizedBox(height: 16),
                      _buildCropDetailCard(
                        context: context,
                        screenWidth: screenWidth,
                        name: "cotton",
                        acres: "5 Acres",
                        date: "1/10/25",
                        status: "Flowering",
                        statusColor: const Color(0xFFFFF9C4),
                        statusTextColor: const Color(0xFFFBC02D),
                        invest: "₹ 120k",
                        expected: "₹ 280k",
                        profit: "₹ 160k",
                        imagePath: "assets/images/cotton.png",
                      ),
                      const SizedBox(height: 16),
                      _buildCropDetailCard(
                        context: context,
                        screenWidth: screenWidth,
                        name: "Wheat",
                        acres: "3 Acres",
                        date: "1/10/25",
                        status: "Ready to\nharvest",
                        statusColor: const Color(0xFFC8E6C9),
                        statusTextColor: const Color(0xFF2E7D32),
                        invest: "₹ 45k",
                        expected: "₹ 130k",
                        profit: "₹ 80k",
                        imagePath:
                            "assets/images/cotton.png", // Reusing cotton as wheat per instruction or if available
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacementNamed(context, "/home");
              }
              if (index == 2) {
                Navigator.pushReplacementNamed(context, "/irrigation");
              }
              if (index == 3) {
                Navigator.pushReplacementNamed(context, "/equipment");
              }
              if (index == 4) {
                Navigator.pushReplacementNamed(context, "/my_land");
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required double screenWidth,
    required String label,
    required String value,
    required String iconPath,
    bool isLand = false,
  }) {
    return Container(
      width: screenWidth * 0.28,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(iconPath, height: 32, width: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required double screenWidth,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          width: screenWidth * 0.25,
          height: screenWidth * 0.12,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 18),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCropDetailCard({
    required BuildContext context,
    required double screenWidth,
    required String name,
    required String acres,
    required String date,
    required String status,
    required Color statusColor,
    required Color statusTextColor,
    required String invest,
    required String expected,
    required String profit,
    required String imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: screenWidth * 0.15,
                  height: screenWidth * 0.15,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
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
                            color: statusColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: statusTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      acres,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      "Snow:$date",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black26),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFinancialItem("Investman", invest),
              _buildFinancialItem("Expected", expected),
              _buildFinancialItem("profit", profit),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildFlatButton("View Financial", () {
                  Navigator.pushNamed(context, "/timeline");
                }),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFlatButton("View Timeline", () {
                  Navigator.pushNamed(context, "/timeline");
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildFlatButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF2E7D32),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
