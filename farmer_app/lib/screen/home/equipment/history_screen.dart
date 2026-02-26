import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
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
            "History",
            style: TextStyle(
              color: const Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: r(20),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: r(8)),
              child: IconButton(
                icon: Icon(Icons.search,
                    color: const Color(0xFF2E7D32), size: r(24)),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: r(16)),
              _buildHistoryCard(
                profileUrl: "assets/equip/profile/1.png",
                name: "Ramasamy",
                phone: "9876543219",
                equipment: "John Deere 5075E Tractor",
                time: "10:30AM",
                status: "Accepted",
                r: r,
              ),
              SizedBox(height: r(16)),
              _buildHistoryCard(
                profileUrl: "assets/equip/profile/1.png",
                name: "Palanisamy",
                phone: "9876543219",
                equipment: "Mahindra 575 DI",
                time: "yesterday",
                status: "Rejected",
                r: r,
              ),
              SizedBox(height: r(16)),
              _buildHistoryCard(
                profileUrl: "assets/equip/profile/1.png",
                name: "Murugan",
                phone: "9876543219",
                equipment: "water tanker with pump",
                time: "21/12/2026",
                status: "Accepted",
                r: r,
              ),
              SizedBox(height: r(20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard({
    required String profileUrl,
    required String name,
    required String phone,
    required String equipment,
    required String time,
    required String status,
    required double Function(double) r,
  }) {
    final bool isAccepted = status == "Accepted";

    return Container(
      margin: EdgeInsets.symmetric(horizontal: r(16)),
      padding: EdgeInsets.all(r(12)),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: r(30),
            backgroundImage: AssetImage(profileUrl),
          ),
          SizedBox(width: r(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: r(16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: r(12),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r(4)),
                Text(
                  phone,
                  style: TextStyle(
                    fontSize: r(14),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: r(4)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        equipment,
                        style: TextStyle(
                          fontSize: r(14),
                          color: const Color(0xFF2E7D32),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: r(12), vertical: r(4)),
                      decoration: BoxDecoration(
                        color: isAccepted
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(r(12)),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          fontSize: r(12),
                          color: isAccepted
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFD32F2F),
                          fontWeight: FontWeight.bold,
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
