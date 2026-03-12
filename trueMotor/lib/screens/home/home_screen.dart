import 'dart:async';
import 'package:flutter/material.dart';
import 'package:truemotor/widgets/bottom_navigation.dart';
import 'search_screen.dart';
import 'location_screen.dart';
import 'notification_screen.dart';
import 'menu/dashboard_screen.dart';
import 'package:truemotor/screens/sell/sell_home.dart';
import 'package:truemotor/screens/used/car_details.dart';
import 'package:truemotor/screens/used/used_vechile.dart';
import 'package:truemotor/screens/compare%20vechiles/compare_home.dart';

class _ActionItem {
  final String asset, label;
  final IconData fallback;
  const _ActionItem(this.asset, this.label, this.fallback);
}

class _CategoryItem {
  final String asset, label;
  final IconData fallback;
  const _CategoryItem(this.asset, this.label, this.fallback);
}

class _CarItem {
  final String image, name, year, price;
  const _CarItem(this.image, this.name, this.year, this.price);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _discountBannerSlide = 0;
  int _heroSlide = 0;

  final PageController _discountController = PageController();
  final PageController _heroController = PageController();

  Timer? _heroTimer;

  final List<String> _searchPlaceholders = [
    '"Price"',
    '"Brand"',
    '"Model"',
    '"Year"',
  ];
  int _placeholderIndex = 0;
  Timer? _placeholderTimer;

  final List<String> _discountImages = const [
    'assets/compare_banner.png',
    'assets/home_banner.png',
    'assets/compare_banner.png',
  ];

  final List<String> _heroImages = const [
    'assets/home_banner.png',
    'assets/compare_banner.png',
    'assets/home_banner.png',
  ];

  final List<_ActionItem> _actions = const [
    _ActionItem('assets/icons/used_vechile_icon.png', 'Used Vehicle', Icons.directions_car),
    _ActionItem('assets/icons/sell_vechile_icon.png', 'Sell Vehicle', Icons.sell),
    _ActionItem('assets/icons/rent_vechile_icon.png', 'Rental\nVehicle', Icons.car_rental),
    _ActionItem('assets/icons/compare_vechile_icon.png', 'Compare\nVehicle', Icons.compare_arrows),
    _ActionItem('assets/icons/service_vechile_icon.png', 'Service\nVehicle', Icons.build_outlined),
  ];

  final List<_CarItem> _trendingCars = const [
    _CarItem('assets/swift.png', 'Maruti Suzuki Swift', '2021', '? 6.98 Lakh'),
    _CarItem('assets/jimmy.png', 'Maruti Suzuki Baleno', '2022', '? 8.50 Lakh'),
    _CarItem('assets/swift.png', 'Maruti Suzuki Swift', '2021', '? 6.98 Lakh'),
    _CarItem('assets/jimmy.png', 'Maruti Suzuki Baleno', '2022', '? 8.50 Lakh'),
  ];

  final List<_CategoryItem> _categories = const [
    _CategoryItem('assets/icons/SUV_icon.png', 'SUV', Icons.directions_car),
    _CategoryItem('assets/icons/sedan_icon.png', 'Sedan', Icons.directions_car_filled),
    _CategoryItem('assets/icons/hatchback_icon.png', 'Hatchbacks', Icons.car_repair),
    _CategoryItem('assets/icons/e-bikes_icon.png', 'e-Bikes', Icons.electric_moped),
    _CategoryItem('assets/icons/bikes_icon.png', 'Bikes', Icons.motorcycle),
  ];

  @override
  void initState() {
    super.initState();
    _heroTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_heroController.hasClients) return;
      final next = (_heroSlide + 1) % _heroImages.length;
      _heroController.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });

    _placeholderTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _placeholderIndex = (_placeholderIndex + 1) % _searchPlaceholders.length;
      });
    });
  }

  @override
  void dispose() {
    _heroTimer?.cancel();
    _placeholderTimer?.cancel();
    _discountController.dispose();
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
      drawer: SizedBox(
        width: sw * 0.85,
        child: const ProfileDrawer(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: sh * 0.32),
                  SizedBox(height: sh * 0.02),
                  _buildQuickActions(sw, sh),
                  SizedBox(height: sh * 0.025),
                  _buildTrendingCars(sw, sh),
                  SizedBox(height: sh * 0.02),
                  _buildDiscountBanner(sw, sh),
                  SizedBox(height: sh * 0.025),
                  _buildCategories(sw, sh),
                  SizedBox(height: sh * 0.02),
                  _buildHeroSlider(sw, sh),
                  SizedBox(height: sh * 0.03),
                ],
              ),
            ),
            _buildHeroBannerOverlay(sw, sh),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBannerOverlay(double sw, double sh) {
    return SizedBox(
      width: double.infinity,
      height: sh * 0.32,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/home_bg.png',
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Icon(Icons.directions_car, size: sw * 0.3, color: Colors.white24),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black54, Colors.black26, Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.45, 1.0],
              ),
            ),
          ),
          Column(
            children: [
              _buildTopBar(sw),
              _buildSearchBar(sw),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(double sw) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.045, vertical: sw * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Icon(Icons.menu, size: sw * 0.08, color: Colors.white),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocationScreen()),
                ),
                child: _assetIcon(
                  'assets/home_location.png',
                  sw * 0.070,
                  color: Colors.white,
                  fallback: Icons.location_on_outlined,
                ),
              ),
              SizedBox(width: sw * 0.045),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NotificationScreen()),
                ),
                child: _assetIcon(
                  'assets/home_notif.png',
                  sw * 0.070,
                  color: Colors.white,
                  fallback: Icons.notifications_none_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(double sw) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sw * 0.01),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        ),
        child: Container(
          height: sw * 0.13,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(sw * 0.03),
            border: Border.all(color: const Color(0xFF7C3AED), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(width: sw * 0.04),
              Icon(Icons.search, color: Colors.grey.shade500, size: sw * 0.055),
              SizedBox(width: sw * 0.025),
              Text(
                'Search  Cars by  ',
                style: TextStyle(color: Colors.grey.shade600, fontSize: sw * 0.04),
              ),
              ClipRect(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    final inAnimation = Tween<Offset>(
                      begin: const Offset(0, -1.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
                    final outAnimation = Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0, 1.0),
                    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: child.key == ValueKey<int>(_placeholderIndex)
                            ? inAnimation
                            : outAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    _searchPlaceholders[_placeholderIndex],
                    key: ValueKey<int>(_placeholderIndex),
                    style: TextStyle(
                      color: const Color(0xFF7C3AED),
                      fontSize: sw * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(double sw, double sh) {
    final boxW = (sw - sw * 0.08 - sw * 0.06) / 3;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _actions.take(3).map((a) => _buildActionBox(a, sw, sh, boxW)).toList(),
          ),
          SizedBox(height: sh * 0.012),
          Row(
            children: [
              _buildActionBox(_actions[3], sw, sh, boxW),
              SizedBox(width: sw * 0.03),
              _buildActionBox(_actions[4], sw, sh, boxW),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBox(_ActionItem item, double sw, double sh, double boxW) {
    return GestureDetector(
      onTap: () {
        if (item.label == 'Used Vehicle') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const UsedVehicleScreen()),
          );
        } else if (item.label == 'Sell Vehicle') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SellHomeScreen()),
          );
        } else if (item.label == 'Compare\nVehicle') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CompareVehicleScreen()),
          );
        }
      },
      child: Container(
        width: boxW,
        padding: EdgeInsets.symmetric(horizontal: sw * 0.015, vertical: sh * 0.012),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFFFF1F4), Color(0xFFFFEBE3)],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(sw * 0.04),
          border: Border.all(color: const Color(0xFFEBEBEB), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withValues(alpha: 0.07),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.asset,
              width: sw * 0.13,
              height: sw * 0.13,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Icon(item.fallback, size: sw * 0.12, color: Colors.orange),
            ),
            SizedBox(height: sh * 0.007),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: sw * 0.031, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingCars(double sw, double sh) {
    final cardW = sw * 0.60;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
          child: Text(
            'Trending Cars',
            style: TextStyle(fontSize: sw * 0.052, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(height: sh * 0.018),
        SizedBox(
          height: sh * 0.230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
            itemCount: _trendingCars.length,
            separatorBuilder: (_, _) => SizedBox(width: sw * 0.03),
            itemBuilder: (_, i) => _buildCarCard(_trendingCars[i], sw, sh, cardW),
          ),
        ),
      ],
    );
  }

  Widget _buildCarCard(_CarItem car, double sw, double sh, double cardW) {
    return Container(
      width: cardW,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(sw * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(sw * 0.03)),
            child: Image.asset(
              car.image,
              width: double.infinity,
              height: sh * 0.111,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(height: sh * 0.150, color: Colors.grey.shade200),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(sw * 0.03, sw * 0.025, sw * 0.03, sw * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        car.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sw * 0.032,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: sw * 0.01),
                    Text(
                      car.year,
                      style: TextStyle(color: Colors.black54, fontSize: sw * 0.030, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.004),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Test Drive Available', style: TextStyle(color: Colors.black54, fontSize: sw * 0.026)),
                    Text(
                      car.price,
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: sw * 0.028),
                    ),
                  ],
                ),
                SizedBox(height: sh * 0.01),
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
                      side: BorderSide(color: Colors.purple.shade300, width: 1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sw * 0.015)),
                      padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.006),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text('View Details', style: TextStyle(color: Colors.black87, fontSize: sw * 0.03)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscountBanner(double sw, double sh) {
    return SizedBox(
      width: double.infinity,
      height: sh * 0.20,
      child: PageView.builder(
        controller: _discountController,
        itemCount: _discountImages.length,
        onPageChanged: (i) => setState(() => _discountBannerSlide = i),
        itemBuilder: (_, index) => Image.asset(
          _discountImages[index],
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFFFFC107), Color(0xFFFF5722)]),
            ),
            child: Padding(
              padding: EdgeInsets.all(sw * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'BEST ',
                          style: TextStyle(color: Colors.white, fontSize: sw * 0.055, fontWeight: FontWeight.w900),
                        ),
                        TextSpan(
                          text: 'CAR',
                          style: TextStyle(color: const Color(0xFFFFD700), fontSize: sw * 0.055, fontWeight: FontWeight.w900),
                        ),
                        TextSpan(
                          text: ' FOR\nRENT TODAY',
                          style: TextStyle(color: Colors.white, fontSize: sw * 0.055, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sh * 0.015),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                    label: const Text('Rent Now', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF5722),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(double sw, double sh) {
    final itemW = (sw - sw * 0.08 - sw * 0.06) / 3;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(fontSize: sw * 0.052, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: sh * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _categories.take(3).map((c) => _buildCategoryCard(c, sw, sh, itemW)).toList(),
          ),
          SizedBox(height: sw * 0.03),
          Row(
            children: [
              _buildCategoryCard(_categories[3], sw, sh, itemW),
              SizedBox(width: sw * 0.03),
              _buildCategoryCard(_categories[4], sw, sh, itemW),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(_CategoryItem cat, double sw, double sh, double itemW) {
    return SizedBox(
      width: itemW,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(sw * 0.025),
        child: Column(
          children: [
            Image.asset(
              cat.asset,
              width: itemW,
              height: itemW * 0.72,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                width: itemW,
                height: itemW * 0.72,
                color: Colors.grey.shade200,
                child: Icon(cat.fallback, size: sw * 0.1, color: Colors.grey),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: sh * 0.008),
              color: const Color(0xFF00695C),
              child: Text(
                cat.label,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: sw * 0.033, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSlider(double sw, double sh) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: sh * 0.20,
          child: PageView.builder(
            controller: _heroController,
            itemCount: _heroImages.length,
            onPageChanged: (i) => setState(() => _heroSlide = i),
            itemBuilder: (_, index) => Image.asset(
              _heroImages[index],
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB71C1C), Color(0xFFF57F17)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Get your dream\nCAR TODAY!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: sh * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_heroImages.length, (i) {
            final active = i == _heroSlide;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: sw * 0.008),
              width: active ? sw * 0.045 : sw * 0.018,
              height: sw * 0.018,
            );
          }),
        ),
      ],
    );
  }

  Widget _assetIcon(String asset, double size, {required IconData fallback, Color color = Colors.black87}) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      child: Image.asset(
        asset,
        width: size,
        height: size,
        errorBuilder: (_, _, _) => Icon(fallback, size: size, color: color),
      ),
    );
  }
}
