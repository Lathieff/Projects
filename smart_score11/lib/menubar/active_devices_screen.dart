import 'package:flutter/material.dart';

class ActiveDevicesScreen extends StatelessWidget {
  const ActiveDevicesScreen({super.key});

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
        centerTitle: false,
        title: Text(
          'Active Devices',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20 * scale,
            fontFamily: 'Nunito',
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0 * scale),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manage devices that have access to your account',
              style: TextStyle(
                fontSize: 14 * scale,
                color: Colors.black,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 25 * scale),
            _buildDeviceCard(
              context,
              icon: Icons.smartphone,
              deviceName: 'iPhone 13 Pro',
              location: 'New York, USA',
              lastActive: 'Last active: 2 minutes ago',
              isCurrent: true,
              scale: scale,
            ),
            SizedBox(height: 16 * scale),
            _buildDeviceCard(
              context,
              icon: Icons.laptop,
              deviceName: 'MacBook Pro',
              location: 'New York, USA',
              lastActive: 'Last active: 1 hour ago',
              isCurrent: false,
              scale: scale,
            ),
            SizedBox(height: 40 * scale),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14 * scale),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10 * scale),
                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    'Log Out All Other Devices',
                    style: TextStyle(
                      color: const Color(0xFFFF4848),
                      fontSize: 15 * scale,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(
    BuildContext context, {
    required IconData icon,
    required String deviceName,
    required String location,
    required String lastActive,
    required bool isCurrent,
    required double scale,
  }) {
    return Container(
      padding: EdgeInsets.all(16 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10 * scale),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(10 * scale),
            ),
            child: Icon(icon, color: const Color(0xFF2196F3), size: 24 * scale),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      deviceName,
                      style: TextStyle(
                        fontSize: 16 * scale,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    if (isCurrent)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8 * scale,
                          vertical: 2 * scale,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA5F3D7),
                          borderRadius: BorderRadius.circular(12 * scale),
                        ),
                        child: Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 12 * scale,
                            color: const Color(0xFF00AA5B),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      )
                    else
                      Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 14 * scale,
                          color: const Color(0xFFFF4848),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito',
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4 * scale),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.grey[600],
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: 4 * scale),
                Text(
                  lastActive,
                  style: TextStyle(
                    fontSize: 14 * scale,
                    color: Colors.grey[600],
                    fontFamily: 'Nunito',
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
