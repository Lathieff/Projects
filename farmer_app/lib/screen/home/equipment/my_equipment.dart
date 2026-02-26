import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';
import 'package:farmer_app/widgets/custom_bottom_nav.dart';

class MyEquipmentPage extends StatefulWidget {
  const MyEquipmentPage({super.key});

  @override
  State<MyEquipmentPage> createState() => _MyEquipmentPageState();
}

class _MyEquipmentPageState extends State<MyEquipmentPage> {
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_isSearchExpanded) {
          setState(() => _isSearchExpanded = false);
        } else {
          Navigator.pop(context); // Goes back to Home
        }
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
              onPressed: () {
                if (_isSearchExpanded) {
                  setState(() => _isSearchExpanded = false);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            title: const Text(
              "My Equipment",
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isSearchExpanded ? Icons.close : Icons.search,
                  color: const Color(0xFF2E7D32),
                ),
                onPressed: () {
                  setState(() {
                    if (_isSearchExpanded) {
                      _searchController.clear();
                    }
                    _isSearchExpanded = !_isSearchExpanded;
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: width * 0.044),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_isSearchExpanded)
                  Container(
                    margin: EdgeInsets.only(bottom: width * 0.044),
                    padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: const Color(0xFF2E7D32), width: 1),
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: "Search Equipment...",
                        hintStyle: TextStyle(
                            color: Colors.green.withValues(alpha: 0.7)),
                        border: InputBorder.none,
                        icon:
                            const Icon(Icons.search, color: Color(0xFF2E7D32)),
                      ),
                      style: const TextStyle(color: Color(0xFF2E7D32)),
                    ),
                  ),
                SizedBox(height: width * 0.028),
                Text(
                  "Managing Your Farming Equipment",
                  style: TextStyle(
                    fontSize: width * 0.044,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: width * 0.044),
                // Statistics Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatCard("4", "Total\nEquipment", width),
                    _buildStatCard("3", "Working", width),
                    _buildStatCard("1", "Needs\nService", width),
                  ],
                ),
                SizedBox(height: width * 0.066),
                // Action Buttons Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "/add_equipment"),
                      child: _buildActionButton(
                          Icons.add_circle, "Add\nEquipment", width),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, "/equipment_needed"),
                      child: _buildActionButtonWidget(
                          Image.asset("assets/images/tractor2.png",
                              width: width * 0.083),
                          "Equipment\nNeeded",
                          width),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "/history"),
                      child:
                          _buildActionButton(Icons.history, "History", width),
                    ),
                  ],
                ),
                SizedBox(height: width * 0.066),
                Text(
                  "My Equipement",
                  style: TextStyle(
                    fontSize: width * 0.044,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: width * 0.044),
                // Equipment List
                _buildEquipmentCard(
                  name: "Tractor",
                  model: "Mahindra 575 DI",
                  condition: "Good",
                  hours: "125 h",
                  purchaseDate: "Mar 2020",
                  nextMaintenance: "20 Jan",
                  fuel: "1.2L/hr",
                  status: "Working",
                  width: width,
                ),
                SizedBox(height: width * 0.044),
                _buildEquipmentCard(
                  name: "Sprayer",
                  model: "Battery Operated",
                  condition: "Excellent",
                  hours: "180 h",
                  purchaseDate: "Mar 2020",
                  nextMaintenance: "20 Jan",
                  fuel: "1.5L/hr",
                  status: "Working",
                  width: width,
                ),
                SizedBox(height: width * 0.089),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 3,
            onTap: (index) {
              if (index == 0) {
                Navigator.pushReplacementNamed(context, "/home");
              }
              if (index == 1) {
                Navigator.pushReplacementNamed(context, "/add_crop");
              }
              if (index == 2) {
                Navigator.pushReplacementNamed(context, "/irrigation");
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

  Widget _buildStatCard(String value, String label, double width) {
    return Container(
      width: width * 0.28,
      height: width * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, double width) {
    return _buildActionButtonWidget(
      Icon(icon, color: const Color(0xFF2E7D32), size: 28),
      label,
      width,
    );
  }

  Widget _buildActionButtonWidget(Widget icon, String label, double width) {
    return Container(
      width: width * 0.28,
      height: width * 0.28,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentCard({
    required String name,
    required String model,
    required String condition,
    required String hours,
    required String purchaseDate,
    required String nextMaintenance,
    required String fuel,
    required String status,
    required double width,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF9C4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.agriculture, color: Colors.black87),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      model,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem("Condition", condition),
              _buildDetailItem("Usage Hours", hours),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem("Purchase Date", purchaseDate),
              _buildDetailItem("Next Maintenance", nextMaintenance),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(Icons.water_drop,
                    size: 16, color: Color(0xFF1976D2)),
                const SizedBox(width: 8),
                Text(
                  "Fuel: $fuel",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
