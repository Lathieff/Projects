import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _selectedFilter = 'All';

  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: "Payment Received",
      category: "Payments",
      description: "You received a payment of ₹ 5000",
      date: "Dec 12, 2025",
      isRead: true,
      section: "Today",
    ),
    NotificationItem(
      title: "Credit Check Completed",
      category: "Credit Checks",
      description: "Credit check for John Doe has been completed",
      date: "Dec 12, 2025",
      isRead: false,
      section: "Today",
    ),
    NotificationItem(
      title: "Payment Received",
      category: "Payments",
      description: "You received a payment of ₹ 5000",
      date: "Dec 12, 2025",
      isRead: true,
      section: "Yesterday",
    ),
    NotificationItem(
      title: "Credit Check Completed",
      category: "Credit Checks",
      description: "Credit check for John Doe has been completed",
      date: "Dec 12, 2025",
      isRead: false,
      section: "Yesterday",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70 * scale,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF2E86C1), // Blueish
                Color(0xFF00BFA5), // Greenish teal
              ],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latest Notification',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Sort by Date ',
                      style: TextStyle(
                        fontSize: 12 * scale,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8 * scale),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12 * scale,
                        vertical: 6 * scale,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF26A69A), // Teal color
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 16 * scale,
                          ),
                          SizedBox(width: 4 * scale),
                          Text(
                            'Pick Date',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
            child: Row(
              children:
                  [
                    'All',
                    'Credit Checks',
                    'Payments & Wallet',
                    'Low Balance Alerts',
                    'Reports',
                    'User / Agent Activity',
                    'Security Alerts',
                    'System Updates',
                  ].map((filter) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12.0 * scale),
                      child: _buildFilterChip(
                        filter,
                        scale,
                        icon: filter == 'All' ? Icons.sort : null,
                      ),
                    );
                  }).toList(),
            ),
          ),

          SizedBox(height: 10 * scale),
          const Divider(thickness: 1, color: Color(0xFFEEEEEE)),

          // Notification List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0 * scale),
              children: [
                _buildSection("Today", scale),
                SizedBox(height: 16 * scale),
                _buildSection("Yesterday", scale),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, double scale, {IconData? icon}) {
    final bool isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16 * scale,
          vertical: 8 * scale,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2979FF) : Colors.white,
          borderRadius: BorderRadius.circular(8 * scale),
          border: Border.all(color: const Color(0xFF2979FF), width: 1),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18 * scale,
                color: isSelected ? Colors.white : const Color(0xFF2979FF),
              ),
              SizedBox(width: 6 * scale),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13 * scale,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, double scale) {
    final sectionItems = _notifications
        .where((item) => item.section == title)
        .toList();

    if (sectionItems.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0 * scale),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        ...sectionItems
            .map((item) => _buildNotificationCard(item, scale))
            .toList(),
      ],
    );
  }

  Widget _buildNotificationCard(NotificationItem item, double scale) {
    return Container(
      margin: EdgeInsets.only(bottom: 12 * scale),
      padding: EdgeInsets.all(12 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4 * scale,
            offset: Offset(0, 2 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8 * scale),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6 * scale,
                        vertical: 2 * scale,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4 * scale),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        item.category,
                        style: TextStyle(
                          fontSize: 10 * scale,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (item.isRead)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8 * scale,
                    vertical: 2 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4 * scale),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'Read',
                    style: TextStyle(
                      fontSize: 10 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8 * scale,
                    vertical: 2 * scale,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF424242),
                    borderRadius: BorderRadius.circular(4 * scale),
                  ),
                  child: Text(
                    'unread',
                    style: TextStyle(
                      fontSize: 10 * scale,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8 * scale),
          // Description
          Text(
            item.description,
            style: TextStyle(
              fontSize: 14 * scale,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          SizedBox(height: 8 * scale),
          // Date
          Text(
            item.date,
            style: TextStyle(fontSize: 13 * scale, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String title;
  final String category;
  final String description;
  final String date;
  final bool isRead;
  final String section;

  NotificationItem({
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.isRead,
    required this.section,
  });
}
