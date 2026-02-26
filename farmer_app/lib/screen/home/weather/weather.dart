import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:farmer_app/theme/bg.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int _selectedDayIndex = 0;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<Map<String, String>> _dailyWeather = [
    {
      "day": "Monday",
      "status": "Warm sunshine",
      "temp": "30°C",
      "minTemp": "24°",
      "maxTemp": "30°",
      "icon": 'assets/weather/partly_cloudy.png',
      "bg": 'assets/weather/sun.png',
      "gif": 'assets/weather/gifs/sunny.gif',
      "date": "Mon, 27 Dec, 07:00 am"
    },
    {
      "day": "Tuesday",
      "status": "Rain Shower",
      "temp": "25°C",
      "minTemp": "24°",
      "maxTemp": "30°",
      "icon": 'assets/weather/rainy_lightning.png',
      "bg": 'assets/weather/weather_bg.png',
      "gif": 'assets/weather/gifs/rainy.gif',
      "date": "Tue, 28 Dec, 07:00 am"
    },
    {
      "day": "Wednesday",
      "status": "Cloudy skies",
      "temp": "27°C",
      "minTemp": "24°",
      "maxTemp": "30°",
      "icon": 'assets/weather/heavy_rain.png',
      "bg": 'assets/weather/cloud.png',
      "gif": 'assets/weather/gifs/cloudy.gif',
      "date": "Wed, 29 Dec, 07:00 am"
    },
    {
      "day": "Thursday",
      "status": "Rainy",
      "temp": "24°C",
      "minTemp": "24°",
      "maxTemp": "30°",
      "icon": 'assets/weather/partly_cloudy.png',
      "bg": 'assets/weather/sun.png',
      "gif": 'assets/weather/gifs/sunny.gif',
      "date": "Thu, 30 Dec, 07:00 am"
    },
    {
      "day": "Friday",
      "status": "Rainy",
      "temp": "26°C",
      "minTemp": "24°",
      "maxTemp": "30°",
      "icon": 'assets/weather/rainy_lighting.png',
      "bg": 'assets/weather/weather_bg.png',
      "gif": 'assets/weather/gifs/rainy.gif',
      "date": "Fri, 31 Dec, 07:00 am"
    },
    {
      "day": "Saturday",
      "status": "Rainy",
      "temp": "25°C",
      "minTemp": "24°",
      "maxTemp": "30°",
      "icon": 'assets/weather/heavy_rain.png',
      "bg": 'assets/weather/cloud.png',
      "gif": 'assets/weather/gifs/cloudy.gif',
      "date": "Sat, 01 Jan, 07:00 am"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF2E7D32),
      statusBarIconBrightness: Brightness.light,
    ));

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final currentDay = _dailyWeather[_selectedDayIndex];

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
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF2E7D32),
            statusBarIconBrightness: Brightness.light,
          ),
          leading: IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.arrow_back,
                color: const Color(0xFF1B5E20)),
            onPressed: () {
              if (_isSearching) {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: "Search Location...",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Color(0xFF1B5E20)),
                  ),
                  style: const TextStyle(
                      color: Color(0xFF1B5E20), fontWeight: FontWeight.bold),
                )
              : const Text(
                  "Weather Info",
                  style: TextStyle(
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
          actions: [
            if (!_isSearching)
              IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF1B5E20)),
                onPressed: () {
                  setState(() {
                    _isSearching = true;
                  });
                },
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Stack(
                children: [
                  Container(
                    height: size.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(currentDay['bg']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.2),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06,
                          vertical: width * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on,
                                      color: Colors.green, size: 18),
                                  SizedBox(width: 4),
                                  Text(
                                    "Coimbatore",
                                    style: TextStyle(
                                      color: Color(0xFF1B5E20),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      currentDay['temp']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 42,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      currentDay['status']!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      currentDay['date']!,
                                      style: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.9),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  currentDay['gif']!,
                                  width: width * 0.35,
                                ),
                              ],
                            ),
                            const SizedBox(height: 45),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Hourly",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildHourlyItem("30°C", "08:00",
                              'assets/weather/partly_cloudy.png'),
                          _buildHourlyItem(
                              "23°C", "09:00", 'assets/weather/heavy_rain.png'),
                          _buildHourlyItem(
                              "20°C", "10:00", 'assets/weather/heavy_rain.png'),
                          _buildHourlyItem("28°C", "11:00",
                              'assets/weather/partly_cloudy.png'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Daily",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(_dailyWeather.length, (index) {
                      final day = _dailyWeather[index];
                      return _buildDailyItem(
                        index,
                        day["day"]!,
                        day["status"]!,
                        day["minTemp"]!,
                        day["maxTemp"]!,
                        day["icon"]!,
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyItem(String temp, String time, String iconPath) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, width: 40, height: 40),
          const SizedBox(height: 4),
          Text(
            temp,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyItem(int index, String day, String status, String minTemp,
      String maxTemp, String iconPath) {
    bool isSelected = _selectedDayIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDayIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isSelected ? Colors.green.withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xFF2E7D32), width: 1.5)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 50, height: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    status,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Text(
              "$minTemp / $maxTemp",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
