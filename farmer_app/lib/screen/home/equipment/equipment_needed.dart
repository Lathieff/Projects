import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class EquipmentNeededPage extends StatelessWidget {
  const EquipmentNeededPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // Base design width used for ratios (e.g. Figma width 360)
    double r(double val) => (val / 360) * width;

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
            icon: Icon(Icons.arrow_back,
                color: const Color(0xFF2E7D32), size: r(24)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Equipment Needed",
            style: TextStyle(
              color: const Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: r(20),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: r(16)),
               child: InkWell(
               onTap: () => Navigator.pushNamed(context, "/location"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on,
                      color: const Color(0xFF2E7D32), size: r(20)),
                  Text(
                    "Coimbatore",
                    style: TextStyle(
                      color: const Color(0xFF2E7D32),
                      fontSize: r(10),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ),
        ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.all(r(16)),
                child: Container(
                  height: r(48),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(r(24)),
                    border:
                        Border.all(color: const Color(0xFF2E7D32), width: 1),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: r(14)),
                      prefixIcon: Icon(Icons.search,
                          color: const Color(0xFF2E7D32), size: r(24)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: r(12)),
                    ),
                  ),
                ),
              ),

              // Recently Viewed Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r(16)),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.black, size: r(20)),
                    SizedBox(width: r(8)),
                    Text(
                      "Recently Viewed",
                      style: TextStyle(
                        fontSize: r(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r(12)),

              // Category Chips
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r(16)),
                child: Wrap(
                  spacing: r(8),
                  runSpacing: r(8),
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/tractor"),
                      child: _buildChip("Tractor", r),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/watertank"),
                      child: _buildChip("Water Tanker", r),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/rotavator"),
                      child: _buildChip("Rotavator", r),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/seedrill"),
                      child: _buildChip("Seed Drill", r),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/sprayer"),
                      child: _buildChip("Sprayer", r),
                    ),
                  ],
                ),
              ),
              SizedBox(height: r(20)),

              // Equipment Rental Cards
              _buildEquipmentCard(
                imageUrl: "assets/equip/vechile_1.png",
                profileUrl: "assets/equip/profile/1.png",
                ownerName: "Ramasamy",
                rating: "4.8",
                distance: "2.3 km away",
                type: "Tractors",
                model: "John Deere 5075E Tractor",
                price: "800",
                width: width,
                r: r,
                context: context,
              ),
              SizedBox(height: r(16)),
              _buildEquipmentCard(
                imageUrl:
                    "assets/equip/vechile_22.png", // Using same image as requested
                profileUrl:
                    "assets/equip/profile/profile_2.png", // Using same image as requested
                ownerName: "Palanisamy",
                rating: "4.2",
                distance: "2.3 km away",
                type: "Tractors",
                model: "Mahindra 575 DI",
                price: "1000",
                width: width,
                r: r,
                context: context,
              ),
              SizedBox(height: r(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, double Function(double) r) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r(12), vertical: r(6)),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(r(18)),
        border: Border.all(color: const Color(0xFF2E7D32), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF2E7D32),
          fontWeight: FontWeight.w500,
          fontSize: r(13),
        ),
      ),
    );
  }

  Widget _buildEquipmentCard({
    required String imageUrl,
    required String profileUrl,
    required String ownerName,
    required String rating,
    required String distance,
    required String type,
    required String model,
    required String price,
    required double width,
    required double Function(double) r,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: r(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Equipment Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(r(20))),
            child: Image.asset(
              imageUrl,
              height: r(180),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(r(12)),
            child: Column(
              children: [
                // Owner Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: r(24),
                      backgroundImage: AssetImage(profileUrl),
                    ),
                    SizedBox(width: r(12)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ownerName,
                            style: TextStyle(
                              fontSize: r(16),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,
                                  color: Colors.orange, size: r(14)),
                              Text(
                                " $rating",
                                style: TextStyle(
                                    fontSize: r(12),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: r(12)),
                              Icon(Icons.location_on_outlined,
                                  color: Colors.black, size: r(14)),
                              Text(
                                " $distance",
                                style: TextStyle(
                                    fontSize: r(12), color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r(12)),
                const Divider(color: Colors.grey, thickness: 0.5),
                SizedBox(height: r(8)),
                // Specs
                Row(
                  children: [
                    SizedBox(
                      width: r(80),
                      child: Text("Tractors",
                          style: TextStyle(
                              fontSize: r(14), fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Text(
                        model,
                        style: TextStyle(
                            fontSize: r(14),
                            color: const Color(0xFF2E7D32),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r(12)),
                Row(
                  children: [
                    SizedBox(
                      width: r(80),
                      child: Text("Per day",
                          style: TextStyle(
                              fontSize: r(14), fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Text(
                        price,
                        style: TextStyle(
                            fontSize: r(14),
                            color: const Color(0xFF2E7D32),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r(16)),
                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon:
                            Icon(Icons.call, color: Colors.white, size: r(18)),
                        label: Text("Call Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: r(13))),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          padding: EdgeInsets.symmetric(vertical: r(10)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(r(8))),
                        ),
                      ),
                    ),
                    SizedBox(width: r(12)),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/booking"),
                        icon: Icon(Icons.calendar_today,
                            color: const Color(0xFF2E7D32), size: r(18)),
                        label: Text("Book Now",
                            style: TextStyle(
                                color: const Color(0xFF2E7D32),
                                fontWeight: FontWeight.bold,
                                fontSize: r(13))),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2E7D32)),
                          padding: EdgeInsets.symmetric(vertical: r(10)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(r(8))),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
