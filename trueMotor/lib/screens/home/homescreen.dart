// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:truemotor/screens/rental/rental_booking.dart';
// import 'package:truemotor/screens/service/service_vechicle.dart';
// import 'package:truemotor/widgets/bottom_navigation.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final media = MediaQuery.of(context).size;
//     final w = media.width;
//     final h = media.height;

//     return Scaffold(
//       drawer: _appDrawer(w),
//       backgroundColor: const Color(0xFFF5F5F5),
//       bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _topHeroSection(w, h),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Transform.translate(
//                   offset: Offset(0, -h * 0.022),
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFF5F5F5),
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.05)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: h * 0.0190),
//                         SizedBox(height: h * 0.0175),
//                         _serviceGrid(context, w, h),
//                         SizedBox(height: h * 0.0125),
//                         _sectionTitle('Trending Cars', w),
//                         _trendingCarsList(w, h),
//                         SizedBox(height: h * 0.015),
//                         _bannerCard('assets/compare_banner.png', w),
//                         SizedBox(height: h * 0.015),
//                         _sectionTitle('Categories', w),
//                         _categoriesGrid(w, h),
//                         SizedBox(height: h * 0.0125),
//                         _bikesRow(w, h),
//                         SizedBox(height: h * 0.0125),
//                         _bannerCard('assets/home_banner.png', w, height: h * 0.20),
//                         SizedBox(height: h * 0.025),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _topHeroSection(double w, double h) {
//     return SizedBox(
//       height: h * 0.22,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           Image.asset('assets/home_bg.png', fit: BoxFit.cover),
//           Container(color: Colors.black.withValues(alpha: 0.28)),
//           Padding(
//             padding: EdgeInsets.fromLTRB(w * 0.033, h * 0.01, w * 0.033, h * 0.015),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Builder(
//                       builder: (ctx) => InkWell(
//                         onTap: () => Scaffold.of(ctx).openDrawer(),
//                         borderRadius: BorderRadius.circular(w * 0.05),
//                         child: Padding(
//                           padding: EdgeInsets.all(w * 0.022),
//                           child: Icon(Icons.menu, color: Colors.white, size: w * 0.065),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(w * 0.016),
//                           child: Icon(Icons.location_on_outlined, color: Colors.white, size: w * 0.064),
//                         ),
//                         SizedBox(width: w * 0.022),
//                         Padding(
//                           padding: EdgeInsets.all(w * 0.016),
//                           child: Icon(Icons.notifications_none, color: Colors.white, size: w * 0.064),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: h * 0.020),
//                 Center(
//                   child: AnimatedHintSearchBar(w: w, h: h),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _appDrawer(double w) {
//     return Drawer(
//       child: SafeArea(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(color: Color(0xFF00A99D)),
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: Text(
//                   'Menu',
//                   style: TextStyle(color: Colors.white, fontSize: w * 0.061, fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//             const ListTile(leading: Icon(Icons.home_outlined), title: Text('Home')),
//             const ListTile(leading: Icon(Icons.person_outline), title: Text('Profile')),
//             const ListTile(leading: Icon(Icons.info_outline), title: Text('About')),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _serviceGrid(BuildContext context, double w, double h) {
//     final items = [
//       ('assets/icons/used_vechile_icon.png', 'Used Vehicle'),
//       ('assets/icons/sell_vechile_icon.png', 'Sell Vehicle'),
//       ('assets/icons/rent_vechile_icon.png', 'Rental\nVehicle'),
//       ('assets/icons/compare_vechile_icon.png', 'Compare\nVehicle'),
//       ('assets/icons/service_vechile_icon.png', 'Service\nVehicle'),
//     ];

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: w * 0.028),
//       child: Wrap(
//         spacing: w * 0.03,
//         runSpacing: h * 0.014,
//         alignment: WrapAlignment.start,
//         children: items.map((e) {
//           return InkWell(
//             borderRadius: BorderRadius.circular(w * 0.03),
//             onTap: () {
//               if (e.$2.startsWith('Rental')) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const RentalBookingPage()),
//                 );
//               } else if (e.$2.startsWith('Service')) {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const ServiceVehicleScreen()),
//                 );
//               }
//             },
//             child: Container(
//               width: w * 0.285,
//               height: h * 0.125,
//               padding: EdgeInsets.symmetric(vertical: h * 0.010, horizontal: w * 0.01),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(w * 0.03),
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFFFFFFFF), Color(0xFFFFF1F4), Color(0xFFFFEBE3)],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.06),
//                     blurRadius: w * 0.012,
//                     offset: Offset(0, h * 0.003),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(e.$1, height: w * 0.094, width: w * 0.094),
//                   SizedBox(height: h * 0.0075),
//                   Text(
//                     e.$2,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: w * 0.031, fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title, double w) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: w * 0.033),
//       child: Text(title, style: TextStyle(fontSize: w * 0.039, fontWeight: FontWeight.w700)),
//     );
//   }

//   Widget _trendingCarsList(double w, double h) {
//     final cards = [
//       ('assets/swift.png', 'Maruti Suzuki Swift', '2021', '6.98'),
//       ('assets/jimmy.png', 'Maruti Suzuki Baleno', '2021', '7.12'),
//       ('assets/swift.png', 'Maruti Suzuki Swift', '2020', '6.64'),
//       ('assets/jimmy.png', 'Maruti Suzuki Baleno', '2022', '7.45'),
//     ];

//     return SizedBox(
//       height: h * 0.30,
//       child: ListView.separated(
//         padding: EdgeInsets.fromLTRB(w * 0.033, h * 0.01, w * 0.033, 0),
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (_, i) => Container(
//           width: w * 0.84,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(w * 0.045),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(w * 0.03),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: h * 0.11,
//                   width: double.infinity,
//                   child: Image.asset(cards[i].$1, fit: BoxFit.contain),
//                 ),
//                 SizedBox(height: h * 0.007),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         cards[i].$2,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(fontSize: w * 0.045, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     SizedBox(width: w * 0.02),
//                     Text(
//                       cards[i].$3,
//                       style: TextStyle(fontSize: w * 0.055, color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: h * 0.003),
//                 Row(
//                   children: [
//                     Text(
//                       'Test Drive Available',
//                       style: TextStyle(fontSize: w * 0.038, color: Colors.black54),
//                     ),
//                     const Spacer(),
//                     RichText(
//                       text: TextSpan(
//                         style: TextStyle(fontSize: w * 0.04, color: Colors.black87),
//                         children: [
//                           const TextSpan(text: '₹ '),
//                           TextSpan(
//                             text: cards[i].$4,
//                             style: const TextStyle(fontWeight: FontWeight.w700),
//                           ),
//                           const TextSpan(text: ' Lakh'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Spacer(),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.004),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(w * 0.02),
//                       border: Border.all(color: const Color(0xFF742B88), width: 1),
//                     ),
//                     child: Text(
//                       'View Details',
//                       style: TextStyle(
//                         fontSize: w * 0.035,
//                         color: const Color(0xFF742B88),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         separatorBuilder: (_, _) => SizedBox(width: w * 0.03),
//         itemCount: cards.length,
//       ),
//     );
//   }

//   Widget _bannerCard(String path, double w, {double? height}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: w * 0.010),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(w * 0.028),
//         child: SizedBox(
//           height: height,
//           width: double.infinity,
//           child: Image.asset(path, fit: BoxFit.cover),
//         ),
//       ),
//     );
//   }

//   Widget _categoriesGrid(double w, double h) {
//     final categories = [
//       ('assets/icons/SUV_icon.png', 'SUV'),
//       ('assets/icons/sedan_icon.png', 'Sedan'),
//       ('assets/icons/hatchback_icon.png', 'Hatchback'),
//     ];

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: w * 0.033, vertical: h * 0.01),
//       child: Row(
//         children: categories
//             .map(
//               (e) => Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: w * 0.011),
//                   child: Container(
//                     height: h * 0.14,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(w * 0.04),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.05),
//                           blurRadius: w * 0.01,
//                           offset: Offset(0, h * 0.002),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(w * 0.04),
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Center(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: w * 0.01),
//                                 child: Image.asset(e.$1, height: h * 0.06, fit: BoxFit.contain),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(vertical: h * 0.009),
//                             color: const Color(0xFF007A78),
//                             child: Text(
//                               e.$2,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: w * 0.03,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }

//   Widget _bikesRow(double w, double h) {
//     final bikes = [
//       ('assets/icons/e-bikes_icon.png', 'e-Bikes'),
//       ('assets/icons/bikes_icon.png', 'Bikes'),
//     ];

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: w * 0.033, vertical: h * 0.01),
//       child: Row(
//         children: bikes
//             .map(
//               (e) => Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: w * 0.011),
//                   child: Container(
//                     height: h * 0.14,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(w * 0.04),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.05),
//                           blurRadius: w * 0.01,
//                           offset: Offset(0, h * 0.002),
//                         ),
//                       ],
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(w * 0.04),
//                       child: Column(
//                         children: [
//                           Expanded(
//                             child: Center(
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: w * 0.01),
//                                 child: Image.asset(e.$1, height: h * 0.06, fit: BoxFit.contain),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(vertical: h * 0.009),
//                             color: const Color(0xFF007A78),
//                             child: Text(
//                               e.$2,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: w * 0.03,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

// class AnimatedHintSearchBar extends StatefulWidget {
//   const AnimatedHintSearchBar({super.key, required this.w, required this.h});

//   final double w;
//   final double h;

//   @override
//   State<AnimatedHintSearchBar> createState() => _AnimatedHintSearchBarState();
// }

// class _AnimatedHintSearchBarState extends State<AnimatedHintSearchBar> {
//   final TextEditingController _controller = TextEditingController();
//   final List<String> _filters = const ['"Kms Driven"', '"Body Type"', '"No Of owners"'];
//   late final Timer _timer;
//   int _index = 0;

//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       if (!mounted || _controller.text.isNotEmpty) return;
//       setState(() => _index = (_index + 1) % _filters.length);
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.w * 0.850,
//       height: widget.h * 0.045,
//       child: Stack(
//         alignment: Alignment.centerLeft,
//         children: [
//           TextField(
//             controller: _controller,
//             onChanged: (_) => setState(() {}),
//             style: TextStyle(fontSize: widget.w * 0.033, color: Colors.black87),
//             decoration: InputDecoration(
//               isDense: true,
//               contentPadding: EdgeInsets.symmetric(vertical: widget.h * 0.012),
//               prefixIcon: Icon(Icons.search, color: Colors.grey, size: widget.w * 0.055),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.w * 0.028),
//                 borderSide: const BorderSide(color: Color(0xFF742B88), width: 1),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.w * 0.028),
//                 borderSide: const BorderSide(color: Color(0xFF742B88), width: 1),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(widget.w * 0.028),
//                 borderSide: const BorderSide(color: Color(0xFF742B88), width: 1),
//               ),
//             ),
//           ),
//           if (_controller.text.isEmpty)
//             IgnorePointer(
//               child: Padding(
//                 padding: EdgeInsets.only(left: widget.w * 0.117, right: widget.w * 0.022),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Search cars by ',
//                       style: TextStyle(fontSize: widget.w * 0.033, color: Colors.grey),
//                     ),
//                     Expanded(
//                       child: AnimatedSwitcher(
//                         duration: const Duration(milliseconds: 350),
//                         transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
//                         child: Text(
//                           _filters[_index],
//                           key: ValueKey(_filters[_index]),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(fontSize: widget.w * 0.033, color: const Color(0xFF742B88)),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


