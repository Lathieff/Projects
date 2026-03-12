import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truemotor/screens/used/car_details.dart';

// ─────────────────────────────────────────────
// Theme Colors
// ─────────────────────────────────────────────
const Color kPrimary   = Color(0xFF1A6B5A);
const Color kBgGrey    = Color(0xFFF2F4F3);
const Color kBorder    = Color(0xFFD0E4DF);
const Color kCardBg    = Colors.white;
const Color kCompleted = Color(0xFF4CAF50);
const Color kPending   = Color(0xFFFF9800);
const Color kCancelled = Color(0xFFF44336);

// ─────────────────────────────────────────────
// Data Models
// ─────────────────────────────────────────────
enum BookingStatus { completed, pending, cancelled, confirmed }

class RentalBooking {
  final String carName;
  final String fuelType;
  final String transmission;
  final int kmsIncluded;
  final bool withFuel;
  final double extraKmRate;
  final String imagePath;
  final BookingStatus status;
  const RentalBooking({
    required this.carName, required this.fuelType, required this.transmission,
    required this.kmsIncluded, required this.withFuel, required this.extraKmRate,
    required this.imagePath, required this.status,
  });
}

class ServiceBooking {
  final String carName;
  final String serviceType;
  final bool pickup;
  final String serviceDate;
  final String workshop;
  final String bookingId;
  final BookingStatus status;
  final String imagePath;
  const ServiceBooking({
    required this.carName, required this.serviceType, required this.pickup,
    required this.serviceDate, required this.workshop, required this.bookingId,
    required this.status, required this.imagePath,
  });
}

// ─────────────────────────────────────────────
// Demo Data
// ─────────────────────────────────────────────
final List<RentalBooking> _rentalBookings = [
  const RentalBooking(carName: 'Hyundai Santro MT', fuelType: 'Petrol', transmission: 'Manual',
      kmsIncluded: 438, withFuel: false, extraKmRate: 20, imagePath: 'assets/menu_santro.png', status: BookingStatus.confirmed),
  const RentalBooking(carName: 'Hyundai Santro MT', fuelType: 'Petrol', transmission: 'Manual',
      kmsIncluded: 438, withFuel: false, extraKmRate: 20, imagePath: 'assets/menu_santro.png', status: BookingStatus.pending),
  const RentalBooking(carName: 'Hyundai Santro MT', fuelType: 'Petrol', transmission: 'Manual',
      kmsIncluded: 438, withFuel: false, extraKmRate: 20, imagePath: 'assets/menu_santro.png', status: BookingStatus.completed),
];

final List<ServiceBooking> _serviceBookings = [
  const ServiceBooking(carName: 'Tata Nexon', serviceType: 'General Service', pickup: true,
      serviceDate: 'Aug 05, 2025', workshop: 'ABC Auto Care', bookingId: '#TRMS12345',
      status: BookingStatus.completed, imagePath: 'assets/menu_tata.png'),
  const ServiceBooking(carName: 'Tata Nexon', serviceType: 'General Service', pickup: true,
      serviceDate: 'Aug 05, 2025', workshop: 'ABC Auto Care', bookingId: '#TRMS12345',
      status: BookingStatus.completed, imagePath: 'assets/menu_tata.png'),
];

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────
class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});
  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  int _selectedTab = 0;
  final List<String> _rentalFilters  = ['Sort by', 'Booking Status', 'Vehicle Type', 'Date'];
  final List<String> _serviceFilters = ['Sort by', 'Service Type', 'Vehicle Type', 'Status'];

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;
    final bool isSmall  = screenW < 360;
    final bool isMedium = screenW >= 360 && screenW < 480;

    final double hPad     = isSmall ? 12 : (isMedium ? 16 : 24);
    final double titleFS  = isSmall ? 16 : (isMedium ? 18 : 20);
    final double tabFS    = isSmall ? 11 : (isMedium ? 12 : 13);
    final double tabPadV  = isSmall ? 10 : (isMedium ? 11 : 13);
    final double bannerH  = screenH * (isSmall ? 0.20 : (isMedium ? 0.22 : 0.24));
    final double chipFS   = isSmall ? 10 : (isMedium ? 11 : 12);
    final double chipPadH = isSmall ? 8  : (isMedium ? 10 : 12);
    final double chipPadV = isSmall ? 5  : (isMedium ? 6  : 7);
    final double chipRowH = chipPadV * 2 + chipFS * 1.6 + 4;
    final List<String> activeFilters = _selectedTab == 0 ? _rentalFilters : _serviceFilters;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // ── Status bar: white background + dark icons (matches Image 1) ──
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,   // Android dark icons
        statusBarBrightness: Brightness.light,       // iOS dark icons
      ),
      child: Scaffold(
        backgroundColor: kBgGrey,

        // ── AppBar exactly like Image 1 ──
        // • White background
        // • Green back arrow (←) on left
        // • "My Booking" green bold title
        // • No gap between status bar and AppBar
        // • No color change on scroll
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 56,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: kPrimary, size: 24),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            'My Booking',
            style: TextStyle(
              color: kPrimary,
              fontWeight: FontWeight.w700,
              fontSize: titleFS,
            ),
          ),
        ),

        body: CustomScrollView(
          slivers: [

            // ── Banner image ──
            SliverToBoxAdapter(child: _BannerWidget(height: bannerH)),

            // ── "My Booking" heading ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: hPad, right: hPad, top: 12, bottom: 10),
                child: Text(
                  'My Booking',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: isSmall ? 17 : (isMedium ? 19 : 22),
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // ── Tab buttons ──
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: hPad, right: hPad, bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: _tabBtn(
                        label: 'Rental Vehicle',
                        isActive: _selectedTab == 0,
                        onTap: () => setState(() => _selectedTab = 0),
                        tabFS: tabFS, tabPadV: tabPadV,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _tabBtn(
                        label: 'Service Vehicle',
                        isActive: _selectedTab == 1,
                        onTap: () => setState(() => _selectedTab = 1),
                        tabFS: tabFS, tabPadV: tabPadV,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Divider ──
            const SliverToBoxAdapter(
              child: Divider(height: 1, color: kBorder),
            ),

            // ── Filter chips (horizontally scrollable) ──
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  height: chipRowH,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    itemCount: activeFilters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (_, i) => _FilterChip(
                      label: activeFilters[i],
                      icon: i == 0 ? Icons.sort_rounded : null,
                      fontSize: chipFS, padH: chipPadH, padV: chipPadV,
                    ),
                  ),
                ),
              ),
            ),

            // ── Booking cards ──
            if (_selectedTab == 0)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                    padding: EdgeInsets.only(left: hPad, right: hPad, bottom: 10),
                    child: _RentalCard(
                      booking: _rentalBookings[index],
                      screenW: screenW, screenH: screenH,
                      isSmall: isSmall, isMedium: isMedium,
                    ),
                  ),
                  childCount: _rentalBookings.length,
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                    padding: EdgeInsets.only(left: hPad, right: hPad, bottom: 10),
                    child: _ServiceCard(
                      booking: _serviceBookings[index],
                      screenW: screenW, screenH: screenH,
                      isSmall: isSmall, isMedium: isMedium,
                    ),
                  ),
                  childCount: _serviceBookings.length,
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }

  Widget _tabBtn({
    required String label, required bool isActive,
    required VoidCallback onTap, required double tabFS, required double tabPadV,
  }) {
    if (isActive) {
      return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimary, elevation: 2,
          shadowColor: kPrimary.withOpacity(0.3),
          padding: EdgeInsets.symmetric(vertical: tabPadV),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(label,
            style: TextStyle(fontSize: tabFS, fontWeight: FontWeight.w700, color: Colors.white)),
      );
    }
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white, foregroundColor: Colors.black87,
        side: const BorderSide(color: Color(0xFFCCCCCC), width: 1.2),
        padding: EdgeInsets.symmetric(vertical: tabPadV),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label,
          style: TextStyle(fontSize: tabFS, fontWeight: FontWeight.w500, color: Colors.black87)),
    );
  }
}

// ─────────────────────────────────────────────
// Banner Widget
// ─────────────────────────────────────────────
class _BannerWidget extends StatelessWidget {
  final double height;
  const _BannerWidget({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Image.asset(
        'assets/menu_app_banner.png',
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => Container(
          width: double.infinity,
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Filter Chip Widget
// ─────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final double fontSize;
  final double padH;
  final double padV;

  const _FilterChip({required this.label, this.icon, required this.fontSize,
    required this.padH, required this.padV});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPrimary, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize + 2, color: Colors.black87),
            const SizedBox(width: 4),
          ],
          Text(label,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Rental Booking Card
// ─────────────────────────────────────────────
class _RentalCard extends StatelessWidget {
  final RentalBooking booking;
  final double screenW, screenH;
  final bool isSmall, isMedium;

  const _RentalCard({required this.booking, required this.screenW,
    required this.screenH, required this.isSmall, required this.isMedium});

  @override
  Widget build(BuildContext context) {
    final double cardPad    = isSmall ? 6  : (isMedium ? 8  : 10);
    final double cardRadius = isSmall ? 10 : (isMedium ? 12 : 14);
    final double nameFS     = isSmall ? 11 : (isMedium ? 12 : 13);
    final double infoFS     = isSmall ? 9  : (isMedium ? 10 : 11);
    final double btnFS      = isSmall ? 13 : (isMedium ? 14 : 15);
    final double btnPadV    = isSmall ? 9  : (isMedium ? 9  : 13);
    final double btnPadH    = isSmall ? 12 : (isMedium ? 12 : 26);
    final double imgW       = screenW * (isSmall ? 0.20 : (isMedium ? 0.22 : 0.24));
    final double imgH       = screenH * (isSmall ? 0.055 : (isMedium ? 0.06 : 0.065));
    final double gap        = isSmall ? 2.0 : 3.0;

    return Container(
      decoration: BoxDecoration(
        color: kCardBg, borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: kBorder),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      padding: EdgeInsets.all(cardPad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(booking.imagePath, width: imgW, height: imgH, fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Container(width: imgW, height: imgH,
                  decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.directions_car, color: Colors.grey, size: imgH * 0.55)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(booking.carName,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: nameFS, color: Colors.black87)),
                SizedBox(height: gap),
                Row(children: [
                  Icon(Icons.local_gas_station_outlined, size: infoFS + 1, color: Colors.black54),
                  const SizedBox(width: 3),
                  Text(booking.fuelType, style: TextStyle(fontSize: infoFS, color: Colors.black54)),
                  const SizedBox(width: 8),
                  Icon(Icons.settings_outlined, size: infoFS + 1, color: Colors.black54),
                  const SizedBox(width: 3),
                  Text(booking.transmission, style: TextStyle(fontSize: infoFS, color: Colors.black54)),
                ]),
                SizedBox(height: gap),
                Text('${booking.kmsIncluded} kms included, ${booking.withFuel ? "With fuel" : "Without fuel"}',
                    style: TextStyle(fontSize: infoFS, color: Colors.black54)),
                SizedBox(height: gap),
                Text('Extra Kms @ ₹${booking.extraKmRate.toInt()}/Km',
                    style: TextStyle(fontSize: infoFS, color: Colors.black54)),
                SizedBox(height: gap + 2),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary, elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: btnPadH, vertical: btnPadV),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                    ),
                    child: Text('View Details',
                        style: TextStyle(color: Colors.white, fontSize: btnFS, fontWeight: FontWeight.w600)),
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

// ─────────────────────────────────────────────
// Service Booking Card
// ─────────────────────────────────────────────
class _ServiceCard extends StatelessWidget {
  final ServiceBooking booking;
  final double screenW, screenH;
  final bool isSmall, isMedium;

  const _ServiceCard({required this.booking, required this.screenW,
    required this.screenH, required this.isSmall, required this.isMedium});

  Color get _statusColor {
    switch (booking.status) {
      case BookingStatus.completed: return kCompleted;
      case BookingStatus.pending:   return kPending;
      case BookingStatus.cancelled: return kCancelled;
      case BookingStatus.confirmed: return kPrimary;
    }
  }

  String get _statusLabel {
    switch (booking.status) {
      case BookingStatus.completed: return 'Completed';
      case BookingStatus.pending:   return 'Pending';
      case BookingStatus.cancelled: return 'Cancelled';
      case BookingStatus.confirmed: return 'Confirmed';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double cardPad    = isSmall ? 8  : (isMedium ? 10 : 12);
    final double cardRadius = isSmall ? 10 : (isMedium ? 12 : 14);
    final double nameFS     = isSmall ? 11 : (isMedium ? 12 : 13);
    final double infoFS     = isSmall ? 10 : (isMedium ? 11 : 12);
    final double btnFS      = isSmall ? 9  : (isMedium ? 10 : 11);
    final double btnPadV    = isSmall ? 5  : (isMedium ? 6  : 7);
    final double btnPadH    = isSmall ? 10 : (isMedium ? 12 : 14);
    final double imgW       = screenW * (isSmall ? 0.20 : (isMedium ? 0.22 : 0.24));
    final double imgH       = screenH * (isSmall ? 0.07 : (isMedium ? 0.075 : 0.08));
    final double gap        = isSmall ? 2.0 : 3.0;

    return Container(
      decoration: BoxDecoration(
        color: kCardBg, borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: kBorder),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      padding: EdgeInsets.all(cardPad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: imgW + 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(booking.imagePath, width: imgW, height: imgH, fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Container(width: imgW, height: imgH,
                        decoration: BoxDecoration(color: const Color(0xFFF0F0F0), borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.directions_car, color: Colors.grey, size: imgH * 0.55)),
                  ),
                ),
                SizedBox(height: gap + 3),
                Text(booking.carName,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: nameFS, color: Colors.black87)),
                SizedBox(height: gap),
                Text(booking.serviceType,
                    style: TextStyle(fontSize: infoFS - 1, color: Colors.black54)),
                SizedBox(height: gap),
                Text('Pickup: ${booking.pickup ? "Yes" : "No"}',
                    style: TextStyle(fontSize: infoFS - 1, color: Colors.black54)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Service Date: ${booking.serviceDate}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: infoFS, color: Colors.black87)),
                SizedBox(height: gap),
                Text('Workshop: ${booking.workshop}',
                    style: TextStyle(fontSize: infoFS, color: Colors.black54)),
                SizedBox(height: gap),
                Text('Booking ID: ${booking.bookingId}',
                    style: TextStyle(fontSize: infoFS, color: Colors.black54)),
                SizedBox(height: gap),
                Text('Status : $_statusLabel',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: infoFS, color: _statusColor)),
                SizedBox(height: gap + 3),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary, elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: btnPadH, vertical: btnPadV),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                  ),
                  child: Text('View Details',
                      style: TextStyle(color: Colors.white, fontSize: btnFS, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
