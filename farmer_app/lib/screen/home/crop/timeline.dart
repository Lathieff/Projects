import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  bool isFiltered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

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
          title: const Text(
            "Crop TimeLine",
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Image/Section placeholder if needed,
              // but screenshot shows immediate "Upcoming Activities"

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upcoming Activities",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      onPressed: () => _showFilterDialog(context, width),
                    ),
                  ],
                ),
              ),
              SizedBox(height: width * 0.044),

              // Activity Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                child: Column(
                  children: [
                    _buildActivityCard(
                      dateImage: 'assets/images/timeline/date_25.png',
                      timeframe: "Today",
                      title: "Irrigation Tomato",
                      subtitle:
                          "Water tomato plants today. Keep soil moist and avoid overwatering.",
                      icon: 'assets/images/timeline/irrigation_timeline.png',
                      width: width,
                    ),
                    SizedBox(height: width * 0.044),
                    _buildActivityCard(
                      dateImage: 'assets/images/timeline/date_26.png',
                      timeframe: "Tomorrow",
                      title: "Fertilizer to Cotton",
                      subtitle: "Apply fertilizer and irrigate lightly.",
                      icon: 'assets/images/timeline/cotton_timeline.png',
                      width: width,
                    ),
                    if (!isFiltered) ...[
                      SizedBox(height: width * 0.044),
                      _buildActivityCard(
                        dateImage: 'assets/images/timeline/date_27.png',
                        timeframe: "Day After Tommorrow",
                        title: "Wheat Ready for Harvest",
                        subtitle: "Harvest mature wheat when grains are dry.",
                        icon: 'assets/images/timeline/harvest_timeline.png',
                        width: width,
                      ),
                    ],
                  ],
                ),
              ),

              if (!isFiltered) ...[
                SizedBox(height: width * 0.066),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                  child: const Text(
                    "This Week Summary - 1/1/2026",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: width * 0.044),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                  child: Container(
                    padding: EdgeInsets.all(width * 0.044),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: _buildSummaryItem(
                                    'assets/images/timeline/no_1.png',
                                    "Irrigation",
                                    width)),
                            SizedBox(width: width * 0.044),
                            Expanded(
                                child: _buildSummaryItem(
                                    'assets/images/timeline/no_2.png',
                                    "Fertilizer",
                                    width)),
                          ],
                        ),
                        SizedBox(height: width * 0.044),
                        Row(
                          children: [
                            Expanded(
                                child: _buildSummaryItem(
                                    'assets/images/timeline/no_3.png',
                                    "Pest Check",
                                    width)),
                            SizedBox(width: width * 0.044),
                            Expanded(
                                child: _buildSummaryItem(
                                    'assets/images/timeline/no_1.png',
                                    "Harvest",
                                    width)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: width * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityCard({
    required String dateImage,
    required String timeframe,
    required String title,
    required String subtitle,
    required String icon,
    required double width,
  }) {
    return Container(
      padding: EdgeInsets.all(width * 0.044),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
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
          Image.asset(
            dateImage,
            width: width * 0.18,
            height: width * 0.18,
            fit: BoxFit.contain,
          ),
          SizedBox(width: width * 0.044),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      timeframe,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Image.asset(
                      icon,
                      width: width * 0.08,
                      height: width * 0.08,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: width * 0.01),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: width * 0.022),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
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

  Widget _buildSummaryItem(String numberImage, String label, double width) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: width * 0.033, horizontal: width * 0.022),
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
          Image.asset(
            numberImage,
            height: width * 0.08,
            fit: BoxFit.contain,
          ),
          SizedBox(height: width * 0.022),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context, double width) {
    showDialog(
      context: context,
      builder: (context) => FilterPopup(
        width: width,
        onSubmit: () {
          setState(() {
            isFiltered = true;
          });
        },
      ),
    );
  }
}

class FilterPopup extends StatelessWidget {
  final double width;
  final VoidCallback onSubmit;
  const FilterPopup({super.key, required this.width, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(width * 0.044),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Date Range",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel_outlined, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: width * 0.044),
            _buildDateInput("From"),
            SizedBox(height: width * 0.033),
            _buildDateInput("To"),
            SizedBox(height: width * 0.066),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onSubmit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8E6C9),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.11, vertical: width * 0.033),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInput(String label) {
    return Row(
      children: [
        SizedBox(
          width: width * 0.16,
          child: Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.033, vertical: width * 0.022),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("dd-mm-yyyy", style: TextStyle(color: Colors.grey)),
                Icon(Icons.calendar_today,
                    color: const Color(0xFF2E7D32), size: width * 0.05),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
