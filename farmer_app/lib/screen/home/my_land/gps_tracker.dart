import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class GPSTrackerPage extends StatelessWidget {
  const GPSTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double scale = width / 360;

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "GPS Tracker",
            style: TextStyle(
              color: const Color(0xFF2E7D32),
              fontSize: 20 * scale,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: (85 - 80) *
                        scale), // Gap from AppBar (80) to Land Detection (85)
                // Land Detection Card
                Container(
                  width: 320 * scale,
                  height: 91 * scale,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9C4).withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8 * scale),
                    border: Border.all(
                        color: const Color(0xFFFBC02D).withValues(alpha: 0.3)),
                  ),
                  padding: EdgeInsets.all(16 * scale),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info_outline,
                          color: const Color(0xFFFBC02D), size: 24 * scale),
                      SizedBox(width: 12 * scale),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Land Detection",
                              style: TextStyle(
                                fontSize: 16 * scale,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4 * scale),
                            Text(
                              "Walk around your land or adjust the boundary on the map to mark your land area accurately.",
                              style: TextStyle(
                                fontSize: 12 * scale,
                                color: Colors.black87,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: (204 - (85 + 91)) *
                        scale), // Gap from Land Detection to Map
                // Allow GPS Layout (Map View)
                Container(
                  width: 320 * scale,
                  height: 137 * scale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8 * scale),
                    image: const DecorationImage(
                      image: AssetImage("assets/gps.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16 * scale, vertical: 8 * scale),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8 * scale),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.near_me_rounded,
                              color: const Color(0xFF673AB7), size: 18 * scale),
                          SizedBox(width: 8 * scale),
                          Text(
                            "Allow Gps",
                            style: TextStyle(
                              color: const Color(0xFF673AB7),
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * scale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    height:
                        (377 - (204 + 137)) * scale), // Gap from Map to Confirm
                // Confirm Land Boundary Button
                SizedBox(
                  width: 320 * scale,
                  height: 40 * scale,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7CB342)
                          .withValues(alpha: 0.9), // Lighter green
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4 * scale),
                      ),
                    ),
                    child: Text(
                      "confirm Land boundary",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
