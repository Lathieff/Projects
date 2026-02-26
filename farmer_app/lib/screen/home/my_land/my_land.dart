import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';
import 'package:farmer_app/widgets/custom_bottom_nav.dart';

class MyLandPage extends StatelessWidget {
  const MyLandPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: AppBackground.mainGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(width * (56 / 360)),
          child: Padding(
            padding: EdgeInsets.only(top: width * (24 / 360)),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.transparent,
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "My Land",
                style: TextStyle(
                  color: const Color(0xFF2E7D32),
                  fontSize: width * (20 / 360),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * (20 / 360)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width * (23 / 360)), // Gap to summary row
                // Summary Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryCard("1", "TOTAL LANDS", width),
                    _buildSummaryCard("5", "TOTAL ACRES", width),
                  ],
                ),
                SizedBox(height: width * (37 / 360)), // Gap to Add Select Land
                // Add Select Land Card
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/gps_tracker'),
                  child: Container(
                    width: width * (320 / 360),
                    height: width * (138 / 360),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(width * (8 / 360)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * (48 / 360),
                          height: width * (48 / 360),
                          decoration: const BoxDecoration(
                            color: Colors.white30,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: width * (40 / 360),
                          ),
                        ),
                        SizedBox(height: width * (8 / 360)),
                        Text(
                          "Add Select Land",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * (18 / 360),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: width * (37 / 360)), // Gap to Recent Activity
                Text(
                  "Recent Activity",
                  style: TextStyle(
                    fontSize: width * (18 / 360),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: width * (15 / 360)),
                // Live GPS Card
                Container(
                  width: width * (321 / 360),
                  height: width * (220 / 360),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * (8 / 360)),
                    image: const DecorationImage(
                      image: AssetImage("assets/gps.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: width * (16 / 360),
                        left: width * (16 / 360),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * (12 / 360),
                            vertical: width * (6 / 360),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(width * (8 / 360)),
                            border: Border.all(
                                color: const Color(0xFF2E7D32), width: 1),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.near_me_rounded,
                                color: const Color(0xFF2E7D32),
                                size: width * (18 / 360),
                              ),
                              SizedBox(width: width * (8 / 360)),
                              Text(
                                "Live GPS",
                                style: TextStyle(
                                  color: const Color(0xFF2E7D32),
                                  fontSize: width * (14 / 360),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: width * (50 / 360)), // Extra space before nav
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: 4,
          onTap: (index) {
            if (index == 0) Navigator.pushReplacementNamed(context, '/home');
            if (index == 1)
              Navigator.pushReplacementNamed(context, '/add_crop');
            if (index == 2)
              Navigator.pushReplacementNamed(context, '/irrigation');
            if (index == 3)
              Navigator.pushReplacementNamed(context, '/equipment');
            // currentIndex is 4, so no action for index 4
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String value, String label, double width) {
    return Container(
      width: width * (150 / 360),
      height: width * (85 / 360),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * (4 / 360)),
        border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: width * (24 / 360),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: width * (4 / 360)),
          Text(
            label,
            style: TextStyle(
              fontSize: width * (12 / 360),
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
