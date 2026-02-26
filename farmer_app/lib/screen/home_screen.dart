import 'dart:async';
import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
import 'package:farmer_app/widgets/custom_bottom_nav.dart';
import 'package:farmer_app/services/auth_service.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  final List<String> _bannerImages = [
    'assets/images/home_farmer.png',
    'assets/images/banner_pesticides.png',
    'assets/images/banner_ingredients.png',
  ];

  // Voice recognition variables
  final TextEditingController _searchController = TextEditingController();

  // Speech to text variables
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _userName = "Farmer";
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();

    _speech = stt.SpeechToText();
    _searchController.addListener(_onSearchChanged);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? name = await AuthService.getUserName();
    String? image = await AuthService.getUserImage();
    if (name != null && name.isNotEmpty) {
      setState(() {
        _userName = name;
        _imagePath = image;
      });
    }
  }

  void _onSearchChanged() {
    setState(() {}); // Trigger rebuild to update suffix icon
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    });
  }

  void _listen() async {
    if (!_isListening) {
      // Check for microphone permission
      var status = await Permission.microphone.status;
      if (status.isDenied) {
        status = await Permission.microphone.request();
      }

      if (status.isPermanentlyDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Microphone access is required for voice search. Please enable it in settings."),
            ),
          );
        }
        return;
      }

      if (status.isGranted) {
        bool available = await _speech.initialize(
          onError: (val) => debugPrint('Error: $val'),
          onStatus: (val) {
            debugPrint('Status: $val');
            if (val == 'done' || val == 'notListening') {
              setState(() {
                _isListening = false;
              });
              // Check if any text was captured after a short delay to ensure speech recognition finished
              Future.delayed(const Duration(milliseconds: 500), () {
                if (mounted &&
                    _searchController.text.isEmpty &&
                    !_isListening) {
                  _showNoSpeechDetectedPopup();
                }
              });
            }
          },
        );

        if (available) {
          setState(() {
            _isListening = true;
            _searchController.clear(); // Clear before starting
          });

          _speech.listen(
            onResult: (result) {
              setState(() {
                _searchController.text = result.recognizedWords;
              });
            },
          );
        }
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _showNoSpeechDetectedPopup() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Voice Search"),
        content: const Text("Unable to hear voice. Please try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK", style: TextStyle(color: Color(0xFF2E7D32))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _timer.cancel();
    _pageController.dispose();
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
        Navigator.pushReplacementNamed(context, '/login');
      },
      child: Container(
          decoration: const BoxDecoration(
              gradient: AppBackground
                  .mainGradient), // Light green background matching design
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(width * (56 / 360)),
              child: Padding(
                padding: EdgeInsets.only(top: width * (24 / 360)),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  surfaceTintColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  title: GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(context, '/profile');
                      _loadUserData();
                    },
                    child: Row(
                      children: [
                        Container(
                          width: width * (40 / 360),
                          height: width * (40 / 360),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: _imagePath != null
                                ? DecorationImage(
                                    image: FileImage(File(_imagePath!)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _imagePath == null
                              ? Icon(Icons.person,
                                  color: const Color(0xFF2E7D32),
                                  size: width * (24 / 360))
                              : null,
                        ),
                        SizedBox(width: width * (12 / 360)),
                        Text(
                          _userName,
                          style: TextStyle(
                            color: const Color(0xFF1B5E20),
                            fontSize: width * (18 / 360),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/notification_detail'),
                      icon: Icon(Icons.notifications_none_outlined,
                          color: const Color(0xFF2E7D32),
                          size: width * (22 / 360)),
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/location'),
                      icon: Icon(Icons.location_on_outlined,
                          color: const Color(0xFF2E7D32),
                          size: width * (22 / 360)),
                    ),
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/language'),
                      icon: Image.asset(
                        "assets/lang.png",
                        width: width * (22 / 360),
                        height: width * (22 / 360),
                      ),
                    ),
                    SizedBox(width: width * (8 / 360)),
                  ],
                ),
              ),
            ),
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: width * (16 / 360),
                    vertical: width * (8 / 360)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width * (12 / 360)),
                    // Search Bar
                    Center(
                      child: Container(
                        width: width * (328 / 360),
                        height: width * (44 / 360),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(width * (22 / 360)),
                          border: Border.all(
                              color: const Color(0xFF2E7D32).withOpacity(0.4),
                              width: 1),
                        ),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(fontSize: width * (14 / 360)),
                          decoration: InputDecoration(
                            hintText: _isListening ? "Listening..." : "Search",
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: width * (14 / 360)),
                            prefixIcon: Icon(Icons.search,
                                color: const Color(0xFF2E7D32),
                                size: width * (20 / 360)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _searchController.text.isNotEmpty
                                    ? Icons.close
                                    : (_isListening
                                        ? Icons.mic
                                        : Icons.mic_none),
                                color: const Color(0xFF2E7D32),
                                size: width * (20 / 360),
                              ),
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  _searchController.clear();
                                } else {
                                  _listen();
                                }
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: width * (10 / 360)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: width * (16 / 360)),

                    // Farming Tips Banner Carousel
                    Container(
                      width: width * (328 / 360),
                      height: width * (160 / 360),
                      margin:
                          EdgeInsets.symmetric(horizontal: width * (0 / 360)),
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: _bannerImages.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              _bannerImages[index],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: width * (8 / 360)),
                    // Functional Dots indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _bannerImages.length,
                        (index) => Container(
                          width: _currentPage == index
                              ? width * (24 / 360)
                              : width * (8 / 360),
                          height: width * (4 / 360),
                          margin: EdgeInsets.symmetric(
                              horizontal: width * (2 / 360)),
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? const Color(0xFF2E7D32)
                                : Colors.grey.shade400,
                            borderRadius:
                                BorderRadius.circular(width * (2 / 360)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: width * (16 / 360)),

                    _buildWeatherSection(width),
                    SizedBox(height: width * (16 / 360)),

                    // Quick Action Heading
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: width * (4 / 360)),
                      child: Text(
                        "Quick Action",
                        style: TextStyle(
                          fontSize: width * (16 / 360),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: width * (12 / 360)),

                    // Quick Action Grid
                    _buildQuickActionGrid(width),
                    SizedBox(height: width * (24 / 360)),

                    // My Crops Heading
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: width * (4 / 360)),
                      child: Text(
                        "My Crops",
                        style: TextStyle(
                          fontSize: width * (16 / 360),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: width * (12 / 360)),

                    // My Crops List
                    Column(
                      children: [
                        _buildCropCard(
                          "Tomato",
                          "2 Acres",
                          "Sowed: 12/25",
                          "Growing",
                          const Color(0xFFE3F2FD),
                          const Color(0xFF1976D2),
                          "₹ 45k",
                          "₹ 121k",
                          "₹ 76k",
                          "assets/images/tomato.png",
                          width,
                        ),
                        SizedBox(height: width * (16 / 360)),
                        _buildCropCard(
                          "Cotton",
                          "3 Acres",
                          "Sowed: 10/25",
                          "Flowering",
                          const Color(0xFFFFFDE7),
                          const Color(0xFFFBC02D),
                          "₹ 45k",
                          "₹ 130k",
                          "₹ 85k",
                          "assets/images/cotton.png",
                          width,
                        ),
                      ],
                    ),
                    SizedBox(height: width * (24 / 360)),

                    // Live GPS Section
                    _buildLiveGPSSection(width),
                    SizedBox(height: width * (16 / 360)),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: 0,
              onTap: (index) {
                if (index == 0) {
                  // Already on Home
                } else if (index == 1) {
                  Navigator.pushNamed(context, '/add_crop');
                } else if (index == 2) {
                  Navigator.pushNamed(context, '/irrigation');
                } else if (index == 3) {
                  Navigator.pushNamed(context, '/equipment');
                } else if (index == 4) {
                  Navigator.pushNamed(context, '/my_land');
                }
              },
            ),
          )),
    );
  }

  Widget _buildWeatherSection(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * (4 / 360)),
          child: Text(
            "Weather Info",
            style: TextStyle(
              fontSize: width * (14 / 360),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: width * (12 / 360)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/weather'),
          child: SizedBox(
            width: width * (328 / 360),
            height: width * (100 / 360),
            child: Card(
              color: Colors.white,
              elevation: 4,
              shadowColor: Colors.black.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * (12 / 360)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * (12 / 360)),
                child: Row(
                  children: [
                    // Left Part (40%)
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: EdgeInsets.all(width * (12 / 360)),
                        color: const Color(0xFFECF5E8),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("19 Dec",
                                    style: TextStyle(
                                        fontSize: width * (14 / 360),
                                        fontWeight: FontWeight.bold)),
                                Text("28°C",
                                    style: TextStyle(
                                        fontSize: width * (18 / 360),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Positioned(
                              right: -width * (5 / 360),
                              bottom: -width * (5 / 360),
                              child: Image.asset(
                                "assets/weather/thermo.png",
                                width: width * (65 / 360),
                                height: width * (65 / 360),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Right Part (60%)
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: EdgeInsets.all(width * (12 / 360)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Spraying Conditions",
                                    style: TextStyle(
                                        fontSize: width * (12 / 360),
                                        color: Colors.grey)),
                                Text("Until 4 Pm",
                                    style: TextStyle(
                                        fontSize: width * (10 / 360),
                                        color: Colors.grey)),
                              ],
                            ),
                            SizedBox(height: width * (8 / 360)),
                            Text("Unfavorable",
                                style: TextStyle(
                                    fontSize: width * (16 / 360),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionGrid(double width) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 156 / 100,
      crossAxisSpacing: width * (16 / 360),
      mainAxisSpacing: width * (16 / 360),
      children: [
        _buildQuickActionCard(
          "",
          Image.asset("assets/images/add_crop.png", fit: BoxFit.contain),
          () => Navigator.pushNamed(context, '/add_crop'),
          width,
        ),
        _buildQuickActionCard(
          "",
          Image.asset("assets/images/irrigation.png", fit: BoxFit.contain),
          () => Navigator.pushNamed(context, '/irrigation'),
          width,
        ),
        _buildQuickActionCard(
          "",
          Image.asset("assets/images/equipment.png", fit: BoxFit.contain),
          () => Navigator.pushNamed(context, '/equipment'),
          width,
        ),
        _buildQuickActionCard(
          "Community",
          Image.asset("assets/images/community.png",
              height: width * (50 / 360), width: width * (50 / 360)),
          () => Navigator.pushNamed(context, '/community'),
          width,
        ),
      ],
    );
  }

  Widget _buildLiveGPSSection(double width) {
    return Column(
      children: [
        Container(
          width: width * (328 / 360),
          height: width * (180 / 360),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * (16 / 360)),
            image: const DecorationImage(
              image: AssetImage("assets/gps.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: width * (12 / 360),
                left: width * (12 / 360),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/gps_tracker'),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * (12 / 360),
                        vertical: width * (6 / 360)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * (20 / 360)),
                      border: Border.all(color: const Color(0xFF2E7D32)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on,
                            color: const Color(0xFF2E7D32),
                            size: width * (16 / 360)),
                        SizedBox(width: width * (4 / 360)),
                        Text(
                          "Live GPS",
                          style: TextStyle(
                            color: const Color(0xFF2E7D32),
                            fontWeight: FontWeight.bold,
                            fontSize: width * (12 / 360),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCropCard(
    String name,
    String acres,
    String date,
    String status,
    Color statusBg,
    Color statusColor,
    String invest,
    String expected,
    String profit,
    String imagePath,
    double screenWidth,
  ) {
    return Container(
      width: screenWidth * (320 / 360),
      height: screenWidth * (200 / 360),
      padding: EdgeInsets.all(screenWidth * (16 / 360)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * (8 / 360)),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth * (50 / 360),
                height: screenWidth * (50 / 360),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * (8 / 360)),
                  image: DecorationImage(
                      image: AssetImage(imagePath), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: screenWidth * (12 / 360)),
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
                            fontSize: screenWidth * (16 / 360),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * (12 / 360),
                              vertical: screenWidth * (4 / 360)),
                          decoration: BoxDecoration(
                            color: statusBg,
                            borderRadius:
                                BorderRadius.circular(screenWidth * (20 / 360)),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: screenWidth * (12 / 360),
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$acres • Sowed: $date",
                      style: TextStyle(
                          fontSize: screenWidth * (12 / 360),
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth * (12 / 360)),
          const Divider(height: 1),
          SizedBox(height: screenWidth * (12 / 360)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFinancialInfo("Investment", invest, screenWidth),
              _buildFinancialInfo("Expected", expected, screenWidth),
              _buildFinancialInfo("Profit", profit, screenWidth),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/financial');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenWidth * (8 / 360)),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenWidth * (10 / 360)),
                  ),
                  child: Text("View Sales",
                      style: TextStyle(
                          color: const Color(0xFF2E7D32),
                          fontSize: screenWidth * (12 / 360))),
                ),
              ),
              SizedBox(width: screenWidth * (12 / 360)),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/timeline');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenWidth * (8 / 360)),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenWidth * (10 / 360)),
                  ),
                  child: Text("View Timeline",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * (12 / 360))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialInfo(String label, String value, double screenWidth) {
    return Column(
      children: [
        Text(
          label,
          style:
              TextStyle(fontSize: screenWidth * (10 / 360), color: Colors.grey),
        ),
        SizedBox(height: screenWidth * (2 / 360)),
        Text(
          value,
          style: TextStyle(
              fontSize: screenWidth * (14 / 360),
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
      String title, Widget icon, VoidCallback onTap, double screenWidth) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * (150 / 360),
        height: screenWidth * (100 / 360),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * (8 / 360)),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              if (title.isNotEmpty) ...[
                SizedBox(height: screenWidth * (8 / 360)),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * (12 / 360),
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
