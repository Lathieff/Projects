import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/used/car_details.dart';
import 'package:truemotor/screens/used/used_cars.dart';
import 'package:truemotor/widgets/bottom_navigation.dart';

class _VehicleTypeItem {
  final String title;
  final String image;

  const _VehicleTypeItem({required this.title, required this.image});
}

class _TrendingCarItem {
  final String image;
  final String name;
  final String year;
  final String price;

  const _TrendingCarItem({
    required this.image,
    required this.name,
    required this.year,
    required this.price,
  });
}

class UsedVehicleScreen extends StatefulWidget {
  const UsedVehicleScreen({super.key});

  @override
  State<UsedVehicleScreen> createState() => _UsedVehicleScreenState();
}

class _UsedVehicleScreenState extends State<UsedVehicleScreen> {
  int _heroIndex = 0;
  final PageController _heroController = PageController();

  final List<String> _heroBanners = const [
    'assets/home_banner.png',
    'assets/compare_banner.png',
    'assets/home_banner.png',
  ];

  final List<_VehicleTypeItem> _vehicleTypes = const [
    _VehicleTypeItem(title: 'Car', image: 'assets/car.png'),
    _VehicleTypeItem(title: 'Bike', image: 'assets/bike.png'),
    _VehicleTypeItem(title: 'Scooty', image: 'assets/bike.png'),
    _VehicleTypeItem(title: 'Backhoe\nLoader Vehicle', image: 'assets/icons/service_vechile_icon.png'),
    _VehicleTypeItem(title: 'Commercial\nVehicle', image: 'assets/commercial vechiles.png'),
    _VehicleTypeItem(title: 'Tractor', image: 'assets/tractor.png'),
  ];

  final List<_VehicleTypeItem> _electricVehicleTypes = const [
    _VehicleTypeItem(title: 'e-Car', image: 'assets/car.png'),
    _VehicleTypeItem(title: 'e-Scooty', image: 'assets/icons/e-bikes_icon.png'),
    _VehicleTypeItem(title: 'e-Bike', image: 'assets/icons/bikes_icon.png'),
  ];

  final List<_TrendingCarItem> _trendingCars = const [
    _TrendingCarItem(
      image: 'assets/swift.png',
      name: 'Maruti Suzuki Swift',
      year: '2021',
      price: '\u20B9 6.98 Lakh',
    ),
    _TrendingCarItem(
      image: 'assets/jimmy.png',
      name: 'Maruti Suzuki Baleno',
      year: '2022',
      price: '\u20B9 8.50 Lakh',
    ),
    _TrendingCarItem(
      image: 'assets/swift.png',
      name: 'Maruti Suzuki Swift',
      year: '2021',
      price: '\u20B9 6.98 Lakh',
    ),
  ];

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87, size: sw * 0.058),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
        ),
        titleSpacing: 0,
        title: Text(
          'Used Vehicle',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: sw * 0.045,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: sh * 0.010),
              _buildHeroBanner(sw, sh),
              SizedBox(height: sh * 0.009),
              _buildIndicator(sw),
              SizedBox(height: sh * 0.014),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.035),
                child: Text(
                  "Let's find your vehicle",
                  style: TextStyle(
                    fontSize: sw * 0.040,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: sh * 0.014),
              _buildVehicleGrid(sw, sh),
              SizedBox(height: sh * 0.018),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.035),
                child: Text(
                  'Electric Vehicles',
                  style: TextStyle(
                    fontSize: sw * 0.040,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: sh * 0.012),
              _buildElectricRow(sw, sh),
              SizedBox(height: sh * 0.014),
              _buildRentalBanner(sw, sh),
              SizedBox(height: sh * 0.018),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.035),
                child: Text(
                  'Trending Cars',
                  style: TextStyle(
                    fontSize: sw * 0.045,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: sh * 0.012),
              _buildTrendingCars(sw, sh),
              SizedBox(height: sh * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroBanner(double sw, double sh) {
    return SizedBox(
      height: sh * 0.15,
      child: PageView.builder(
        controller: _heroController,
        itemCount: _heroBanners.length,
        onPageChanged: (index) => setState(() => _heroIndex = index),
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(sw * 0.02),
              child: Image.asset(
                _heroBanners[index],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, _, _) => Container(
                  color: Colors.red.shade100,
                  alignment: Alignment.center,
                  child: Text(
                    'Banner',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                      fontSize: sw * 0.04,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIndicator(double sw) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_heroBanners.length, (index) {
        final isActive = _heroIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          margin: EdgeInsets.symmetric(horizontal: sw * 0.010),
          height: sw * 0.018,
          width: isActive ? sw * 0.040 : sw * 0.018,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sw * 0.04),
            color: isActive ? const Color(0xFF8E44AD) : const Color(0xFFD1D1D1),
          ),
        );
      }),
    );
  }

  Widget _buildVehicleGrid(double sw, double sh) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
      child: Wrap(
        spacing: sw * 0.010,
        runSpacing: sh * 0.012,
        children: _vehicleTypes.map((item) {
          return SizedBox(
            width: (sw - (sw * 0.025 * 2) - (sw * 0.010 * 2)) / 3,
            child: _vehicleTypeCard(sw, sh, item),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildElectricRow(double sw, double sh) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
      child: Row(
        children: List.generate(_electricVehicleTypes.length, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index == _electricVehicleTypes.length - 1 ? 0 : sw * 0.01,
              ),
              child: _vehicleTypeCard(sw, sh, _electricVehicleTypes[index]),
            ),
          );
        }),
      ),
    );
  }

  Widget _vehicleTypeCard(double sw, double sh, _VehicleTypeItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UsedCarsScreen()),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: sh * 0.010, horizontal: sw * 0.010),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(sw * 0.025),
          border: Border.all(color: const Color(0xFFE5E5E5)),
        ),
        child: Column(
          children: [
            Container(
              height: sw * 0.13,
              width: sw * 0.13,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(sw * 0.03),
              ),
              child: Padding(
                padding: EdgeInsets.all(sw * 0.012),
                child: Image.asset(
                  item.image,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => Icon(
                    Icons.directions_car,
                    color: Colors.grey.shade500,
                    size: sw * 0.07,
                  ),
                ),
              ),
            ),
            SizedBox(height: sh * 0.008),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: sw * 0.028,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentalBanner(double sw, double sh) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.02),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(sw * 0.018),
        child: SizedBox(
          height: sh * 0.11,
          width: double.infinity,
          child: Image.asset(
            'assets/rental_banner.png',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              color: const Color(0xFFFFF3CD),
              alignment: Alignment.center,
              child: Text(
                'Rental Banner',
                style: TextStyle(
                  color: const Color(0xFFB26A00),
                  fontWeight: FontWeight.w600,
                  fontSize: sw * 0.04,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingCars(double sw, double sh) {
    return SizedBox(
      height: sh * 0.24,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: sw * 0.03),
        itemCount: _trendingCars.length,
        separatorBuilder: (_, _) => SizedBox(width: sw * 0.03),
        itemBuilder: (_, index) => _trendingCarCard(sw, sh, _trendingCars[index]),
      ),
    );
  }

  Widget _trendingCarCard(double sw, double sh, _TrendingCarItem item) {
    return Container(
      width: sw * 0.56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw * 0.03),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(sw * 0.03)),
            child: Image.asset(
              item.image,
              width: double.infinity,
              height: sh * 0.105,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                height: sh * 0.105,
                color: const Color(0xFFEEEEEE),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(sw * 0.022, sh * 0.008, sw * 0.022, sh * 0.008),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: sw * 0.030,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: sw * 0.010),
                    Text(
                      item.year,
                      style: TextStyle(
                        fontSize: sw * 0.028,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.003),
                Text(
                  'Test Drive Available',
                  style: TextStyle(fontSize: sw * 0.025, color: Colors.black54),
                ),
                SizedBox(height: sh * 0.005),
                Text(
                  item.price,
                  style: TextStyle(
                    fontSize: sw * 0.029,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: sh * 0.007),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF8E44AD), width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(sw * 0.02),
                      ),
                      minimumSize: Size(sw * 0.25, sh * 0.035),
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.02, vertical: sh * 0.003),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(fontSize: sw * 0.027, color: Colors.black87),
                    ),
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
