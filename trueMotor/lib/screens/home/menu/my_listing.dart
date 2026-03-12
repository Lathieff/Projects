import 'package:flutter/material.dart';
import 'package:truemotor/screens/used/car_details.dart';

// ─────────────────────────────────────────────
// Data Model
// ─────────────────────────────────────────────
enum ListingStatus { active, pending, sold }

class CarListing {
  final String name;
  final String fuelType;
  final String transmission;
  final int seats;
  final String listingId;
  final double price;
  final ListingStatus status;
  final String imagePath;

  const CarListing({
    required this.name,
    required this.fuelType,
    required this.transmission,
    required this.seats,
    required this.listingId,
    required this.price,
    required this.status,
    required this.imagePath,
  });
}

// ─────────────────────────────────────────────
// Sample Data (Active + Pending + Sold)
// ─────────────────────────────────────────────
final List<CarListing> _demoListings = [
  // ── Active ──
  const CarListing(
    name: 'Maruthi Suzuki Swift',
    fuelType: 'Petrol',
    transmission: 'Manual',
    seats: 5,
    listingId: '#TM-S1234',
    price: 550000,
    status: ListingStatus.active,
    imagePath: 'assets/home_swift.png',
  ),
  const CarListing(
    name: 'Maruthi Suzuki Swift',
    fuelType: 'Petrol',
    transmission: 'Manual',
    seats: 5,
    listingId: '#TM-S1235',
    price: 550000,
    status: ListingStatus.active,
    imagePath: 'assets/home_swift.png',
  ),
  const CarListing(
    name: 'Maruthi Suzuki Swift',
    fuelType: 'Petrol',
    transmission: 'Manual',
    seats: 5,
    listingId: '#TM-S1236',
    price: 550000,
    status: ListingStatus.active,
    imagePath: 'assets/home_swift.png',
  ),
];

// ─────────────────────────────────────────────
// Theme Colors
// ─────────────────────────────────────────────
const Color kPrimary       = Color(0xFF1A6B5A);
const Color kActiveGreen   = Color(0xFF4CAF50);
const Color kBorder        = Color(0xFFD0E4DF);
const Color kCardBg        = Colors.white;
const Color kEditBorder    = Color(0xFF742B88); // ← purple border for Edit Listing

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────
class MyListingScreen extends StatefulWidget {
  const MyListingScreen({super.key});

  @override
  State<MyListingScreen> createState() => _MyListingScreenState();
}

class _MyListingScreenState extends State<MyListingScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Active Listing', 'Pending', 'Sold Vehicle'];

  List<CarListing> get _filtered {
    switch (_selectedTab) {
      case 0:
        return _demoListings
            .where((c) => c.status == ListingStatus.active)
            .toList();
      default:
        return _demoListings;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;

    final bool isSmall  = screenW < 360;
    final bool isMedium = screenW >= 360 && screenW < 480;

    final double hPad       = isSmall ? 12  : (isMedium ? 16  : 24);
    final double vPad       = isSmall ? 10  : (isMedium ? 14  : 18);
    final double titleFS    = isSmall ? 17  : (isMedium ? 20  : 24);
    final double tabFS      = isSmall ? 10  : (isMedium ? 12  : 14);
    final double nameFS     = isSmall ? 12  : (isMedium ? 14  : 16);
    final double priceFS    = isSmall ? 11  : (isMedium ? 12  : 14);
    final double iconSz     = isSmall ? 10  : (isMedium ? 11  : 13);
    final double btnPadV    = isSmall ? 6   : (isMedium ? 9   : 12);
    final double btnFS      = isSmall ? 10  : (isMedium ? 11  : 13);
    final double badgeFS    = isSmall ? 9   : (isMedium ? 10  : 12);
    final double tabPadV    = isSmall ? 10  : (isMedium ? 12  : 14);
    final double cardPad    = isSmall ? 10  : (isMedium ? 12  : 16);
    final double cardRadius = isSmall ? 12  : (isMedium ? 14  : 18);
    final double imgGap     = isSmall ? 8   : (isMedium ? 10  : 14);

    final double cardImageW = screenW * (isSmall ? 0.24 : (isMedium ? 0.26 : 0.27));
    final double cardImageH = screenH * (isSmall ? 0.09 : (isMedium ? 0.10 : 0.11));

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: kPrimary),
        title: Text(
          'My Listing',
          style: TextStyle(
            color: kPrimary,
            fontWeight: FontWeight.w700,
            fontSize: titleFS,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Title Row + Date Picker ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Listing',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: titleFS,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      builder: (ctx, child) => Theme(
                        data: Theme.of(ctx).copyWith(
                          colorScheme:
                          const ColorScheme.light(primary: kPrimary),
                        ),
                        child: child!,
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,
                          color: kPrimary,
                          size: isSmall ? 18 : 20),
                      const SizedBox(width: 4),
                      Text(
                        'Pick Date',
                        style: TextStyle(
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: priceFS,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Tab Bar ──
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final bool isActive = i == _selectedTab;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: i < _tabs.length - 1 ? 8 : 0),
                    child: isActive
                        ? ElevatedButton(
                      onPressed: () =>
                          setState(() => _selectedTab = i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimary,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: kPrimary.withOpacity(0.35),
                        padding:
                        EdgeInsets.symmetric(vertical: tabPadV),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _tabs[i],
                        style: TextStyle(
                          fontSize: tabFS,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    )
                        : OutlinedButton(
                      onPressed: () =>
                          setState(() => _selectedTab = i),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xFFCCCCCC), width: 1.2),
                        padding:
                        EdgeInsets.symmetric(vertical: tabPadV),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        _tabs[i],
                        style: TextStyle(
                          fontSize: tabFS,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: kBorder),
          const SizedBox(height: 8),

          // ── Listing Cards ──
          Expanded(
            child: _filtered.isEmpty
                ? const Center(
              child: Text(
                'No listings found.',
                style: TextStyle(color: Colors.grey),
              ),
            )
                : ListView.separated(
              padding: EdgeInsets.symmetric(
                  horizontal: hPad, vertical: 8),
              itemCount: _filtered.length,
              separatorBuilder: (_, _) =>
              const SizedBox(height: 12),
              itemBuilder: (_, index) => _ListingCard(
                listing: _filtered[index],
                cardImageW: cardImageW,
                cardImageH: cardImageH,
                nameFS: nameFS,
                priceFS: priceFS,
                iconSz: iconSz,
                btnPadV: btnPadV,
                btnFS: btnFS,
                badgeFS: badgeFS,
                cardPad: cardPad,
                cardRadius: cardRadius,
                imgGap: imgGap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Listing Card
// ─────────────────────────────────────────────
class _ListingCard extends StatelessWidget {
  final CarListing listing;
  final double cardImageW, cardImageH;
  final double nameFS, priceFS, iconSz;
  final double btnPadV, btnFS;
  final double badgeFS, cardPad, cardRadius, imgGap;

  const _ListingCard({
    required this.listing,
    required this.cardImageW,
    required this.cardImageH,
    required this.nameFS,
    required this.priceFS,
    required this.iconSz,
    required this.btnPadV,
    required this.btnFS,
    required this.badgeFS,
    required this.cardPad,
    required this.cardRadius,
    required this.imgGap,
  });

  String get _formattedPrice {
    final s     = listing.price.toInt().toString();
    if (s.length <= 3) return '₹$s';
    final last3 = s.substring(s.length - 3);
    final rest  = s.substring(0, s.length - 3);
    final fmt   = rest.replaceAllMapped(
        RegExp(r'(\d)(?=(\d{2})+(?!\d))'), (m) => '${m[0]},');
    return '₹$fmt,$last3';
  }

  Color get _statusColor {
    switch (listing.status) {
      case ListingStatus.active:  return kActiveGreen;
      case ListingStatus.pending: return Colors.orange;
      case ListingStatus.sold:    return Colors.red;
    }
  }

  String get _statusLabel {
    switch (listing.status) {
      case ListingStatus.active:  return 'Active';
      case ListingStatus.pending: return 'Pending';
      case ListingStatus.sold:    return 'Sold';
    }
  }

  // ── Edit Listing button — purple border 0.66px ──
  Widget _editListingBtn(VoidCallback onTap) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: kEditBorder, width: 0.66), // ← #742B88, 0.66px
      padding: EdgeInsets.symmetric(vertical: btnPadV),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(
      'Edit Listing',
      style: TextStyle(
        color: kEditBorder,           // label color matches border
        fontSize: btnFS,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _outlineBtn(String label, VoidCallback onTap) => OutlinedButton(
    onPressed: onTap,
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: kPrimary),
      padding: EdgeInsets.symmetric(vertical: btnPadV),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(label,
        style: TextStyle(
            color: kPrimary,
            fontSize: btnFS,
            fontWeight: FontWeight.w600)),
  );

  Widget _filledBtn(String label, VoidCallback onTap) => ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimary,
      padding: EdgeInsets.symmetric(vertical: btnPadV),
      elevation: 0,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    child: Text(label,
        style: TextStyle(
            color: Colors.white,
            fontSize: btnFS,
            fontWeight: FontWeight.w600)),
  );

  Widget _buildButtons(BuildContext context) {
    switch (listing.status) {
      case ListingStatus.active:
        return Row(children: [
          Expanded(child: _editListingBtn(() {})),   // ← purple bordered button
          const SizedBox(width: 8),
          Expanded(child: _filledBtn('Mark as Sold', () {})),
        ]);

      case ListingStatus.pending:
        return Row(children: [
          Expanded(
            child: _outlineBtn(
              'View Details',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: _filledBtn('Cancel', () {})),
        ]);

      case ListingStatus.sold:
        return Row(children: [
          Expanded(
            child: _outlineBtn(
              'View Details',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CarDetailsScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: _filledBtn('Relist', () {})),
        ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(color: kBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(cardPad),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // ── Car Image ──
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              listing.imagePath,
              width: cardImageW,
              height: cardImageH,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => Container(
                width: cardImageW,
                height: cardImageH,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.directions_car,
                    color: Colors.grey, size: 30),
              ),
            ),
          ),

          SizedBox(width: imgGap),

          // ── Info Section ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  listing.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: nameFS,
                      color: Colors.black87),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),

                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _SpecChip(
                        icon: Icons.local_gas_station_outlined,
                        label: listing.fuelType,
                        fontSize: iconSz),
                    _SpecChip(
                        icon: Icons.settings_outlined,
                        label: listing.transmission,
                        fontSize: iconSz),
                    _SpecChip(
                        icon: Icons.event_seat_outlined,
                        label: '${listing.seats} Seats',
                        fontSize: iconSz),
                  ],
                ),
                const SizedBox(height: 5),

                Text(
                  'Listing ID: [${listing.listingId}]',
                  style: TextStyle(
                      fontSize: priceFS - 1, color: Colors.black54),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'Price: $_formattedPrice',
                      style: TextStyle(
                          fontSize: priceFS,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                color: _statusColor,
                                shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _statusLabel,
                            style: TextStyle(
                                color: _statusColor,
                                fontWeight: FontWeight.w600,
                                fontSize: badgeFS),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                _buildButtons(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Spec Chip
// ─────────────────────────────────────────────
class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final double fontSize;

  const _SpecChip(
      {required this.icon, required this.label, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: fontSize + 2, color: Colors.black54),
        const SizedBox(width: 3),
        Text(label,
            style: TextStyle(fontSize: fontSize, color: Colors.black54)),
      ],
    );
  }
}
