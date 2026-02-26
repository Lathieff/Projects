import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String selectedFilter = "All";

  final Map<String, List<Map<String, String>>> notifications = {
    "All": [
      {
        "icon": "assets/gif/remainder.gif",
        "title": "IRRIGATION REMAINDER",
        "time": "9:30AM",
        "subtitle": "Time to water your crops today."
      },
      {
        "icon": "assets/gif/alert.gif",
        "title": "WEATHER ALERT",
        "time": "10:30AM",
        "subtitle":
            "Heavy rainfall expected today. Take necessary crop protection measures."
      },
      {
        "icon": "assets/gif/crop.gif",
        "title": "CROP CARE",
        "time": "Yesterday",
        "subtitle": "Maintain proper soil moisture for healthy crop growth."
      },
      {
        "icon": "assets/gif/update.gif",
        "title": "UPDATE",
        "time": "2 days ago",
        "subtitle": "Early morning is best time for irrigation."
      },
    ],
    "Admin": [
      {
        "icon": "assets/gif/alert.gif",
        "title": "WEATHER ALERT",
        "time": "10:30AM",
        "subtitle":
            "Heavy rainfall expected today. Take necessary crop protection measures."
      },
      {
        "icon": "assets/gif/crop.gif",
        "title": "CROP CARE",
        "time": "Yesterday",
        "subtitle": "Maintain proper soil moisture for healthy crop growth."
      },
      {
        "icon": "assets/gif/update.gif",
        "title": "UPDATE",
        "time": "2 days ago",
        "subtitle": "Early morning is best time for irrigation."
      },
    ],
    "Weather": [
      {
        "icon": "assets/gif/alert.gif",
        "title": "WEATHER ALERT",
        "time": "10:30AM",
        "subtitle":
            "Heavy rainfall expected today. Take necessary crop protection measures."
      },
    ],
    "Crops": [
      {
        "icon": "assets/gif/crop.gif",
        "title": "CROP CARE",
        "time": "Yesterday",
        "subtitle": "Maintain proper soil moisture for healthy crop growth."
      },
      {
        "icon": "assets/gif/crop.gif",
        "title": "NEW CROP ADDED",
        "time": "2 days ago",
        "subtitle": "Your tomato crop has been successfully added."
      },
    ],
    "Irrigation": [
      {
        "icon": "assets/gif/remainder.gif",
        "title": "IRRIGATION REMAINDER",
        "time": "9:30AM",
        "subtitle": "Time to water your crops today."
      },
      {
        "icon": "assets/gif/update.gif",
        "title": "UPDATE",
        "time": "2 days ago",
        "subtitle": "Early morning is best time for irrigation."
      },
    ],
  };

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Notification",
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
              // Header Image
              Image.asset(
                'assets/images/farmer_notification.png',
                width: width,
                height: width * 0.5,
                fit: BoxFit.cover,
              ),
              SizedBox(height: width * 0.044),
              // Updates Title and Filter Icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Updates",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.filter_list, color: Colors.black87),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => FilterPopup(width: width),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: width * 0.022),
              // Filter Chips - Horizontal Scrollable
              SizedBox(
                height: 40,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                  child: Row(
                    children: [
                      _buildFilterChip("All", width),
                      SizedBox(width: width * 0.022),
                      _buildFilterChip("Admin", width),
                      SizedBox(width: width * 0.022),
                      _buildFilterChip("Weather", width),
                      SizedBox(width: width * 0.022),
                      _buildFilterChip("Crops", width),
                      SizedBox(width: width * 0.022),
                      _buildFilterChip("Irrigation", width),
                    ],
                  ),
                ),
              ),
              SizedBox(height: width * 0.055),
              // Notification List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.044),
                child: Column(
                  children: notifications[selectedFilter]!.map((notif) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: width * 0.033),
                      child: _buildNotificationCard(
                        icon: notif["icon"]!,
                        title: notif["title"]!,
                        time: notif["time"]!,
                        subtitle: notif["subtitle"]!,
                        width: width,
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: width * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, double width) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: width * 0.055),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.black : const Color(0xFF2E7D32),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : const Color(0xFF2E7D32),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required String icon,
    required String title,
    required String time,
    required String subtitle,
    required double width,
  }) {
    return Container(
      padding: EdgeInsets.all(width * 0.044),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            icon,
            width: width * 0.15,
            height: width * 0.15,
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
                    Flexible(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
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
}

class FilterPopup extends StatelessWidget {
  final double width;
  const FilterPopup({super.key, required this.width});

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
