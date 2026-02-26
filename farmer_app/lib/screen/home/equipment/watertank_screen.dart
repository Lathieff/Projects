import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class WaterTankScreen extends StatelessWidget {
  const WaterTankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // Base design width for ratios
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
            "Water Tanker",
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
            children: [
              _buildEquipmentCard(
                imageUrl: "assets/equip/watertanker_1.png",
                profileUrl: "assets/equip/profile/profile_3.png",
                ownerName: "Murugan",
                rating: "4.2",
                distance: "2.3 km away",
                label: "Tractors",
                model: "water tanker with pump",
                price: "1200",
                width: width,
                r: r,
                context: context,
              ),
              SizedBox(height: r(20)),
              _buildEquipmentCard(
                imageUrl: "assets/equip/watertanker_2.png",
                profileUrl: "assets/equip/profile/profile_4.png",
                ownerName: "Velmurugan",
                rating: "4.2",
                distance: "2.3 km away",
                label: "Tractors",
                model: "Portable Water Tanker",
                price: "1350",
                width: width,
                r: r,
                context: context,
                showPriceRowButton: true,
              ),
              SizedBox(height: r(20)),
            ],
          ),
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
    required String label,
    required String model,
    required String price,
    required double width,
    required double Function(double) r,
    required BuildContext context,
    bool showPriceRowButton = false,
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
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
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
                Row(
                  children: [
                    SizedBox(
                      width: r(80),
                      child: Text(label,
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
                    if (showPriceRowButton)
                      SizedBox(
                        height: r(30),
                      ),
                  ],
                ),
                SizedBox(height: r(16)),
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
                        onPressed: () => Navigator.pushNamed(
                            context, "/booking",
                            arguments: imageUrl),
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
