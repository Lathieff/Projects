import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const Color tealColor    = Color(0xFF2A7C76);
  static const Color appBarColor  = Color(0xFFFBF8F8);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
      ),
        body: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── App Bar ──────────────────────────────────────────
              Container(
                color: appBarColor,
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04,
                  vertical:   sw * 0.04,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: tealColor,
                        size: sw * 0.06,
                      ),
                    ),
                    SizedBox(width: sw * 0.03),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize:   sw * 0.055,
                        fontWeight: FontWeight.w600,
                        color:      tealColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: sh * 0.03),

              // ── Search Bar ────────────────────────────────────────

              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                      size: sw * 0.06,
                    ),
                    SizedBox(width: sw * 0.03),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                          fontSize: sw * 0.04,
                          color:    Colors.black87,
                        ),
                        decoration: InputDecoration(
                          border:      InputBorder.none,
                          isDense:     true,
                          hintText:    'Search for your city',
                          hintStyle: TextStyle(
                            fontSize: sw * 0.04,
                            color:    Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: sh * 0.03),

              // ── Divider ───────────────────────────────────────────
              Divider(
                color:     Colors.grey.shade300,
                thickness: 1,
                height:    1,
              ),

              SizedBox(height: sh * 0.03),

              // ── Auto Detect My Location ───────────────────────────
              GestureDetector(
                onTap: () {
                  // TODO: trigger GPS location detection
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                  child: Row(
                    children: [
                      Icon(
                        Icons.my_location,
                        color: Colors.black87,
                        size: sw * 0.065,
                      ),
                      SizedBox(width: sw * 0.04),
                      Text(
                        'Auto Detect My Location',
                        style: TextStyle(
                          fontSize:   sw * 0.042,
                          color:      Colors.black87,
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
      );
  }
}

