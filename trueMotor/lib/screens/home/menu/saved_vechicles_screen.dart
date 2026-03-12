import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  SavedVehiclesScreen
// ─────────────────────────────────────────────
class SavedVehiclesScreen extends StatefulWidget {
  const SavedVehiclesScreen({super.key});

  @override
  State<SavedVehiclesScreen> createState() => _SavedVehiclesScreenState();
}

class _SavedVehiclesScreenState extends State<SavedVehiclesScreen> {
  static const _green  = Color(0xFF2E7D52);
  static const _blue   = Color(0xFF1A237E);
  static const _purple = Color(0xFF7B3FA0);

  // Sample vehicle data
  final List<Map<String, String>> _vehicles = List.generate(3, (_) => {
    'name':     'Maruti Suzuki Swift VXI 2021',
    'km':       '25,000 km',
    'fuel':     'Petrol',
    'trans':    'Manual',
    'price':    '₹9.2 Lakh',
    'emi':      '₹13,470/mo',
    'location': 'Coimbatore',
    'image':    'assets/menu_swift.png',
  });

  @override
  Widget build(BuildContext context) {
    final mq       = MediaQuery.of(context);
    final double w = mq.size.width;
    final double h = mq.size.height;

    final double wp = w / 390;
    final double hp = h / 844;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Vehicles'),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── AppBar ──────────────────────────────────────
            Container(
              width:   w,
              height:  56 * hp,
              color:   const Color(0xFFFBF8F8),
              padding: EdgeInsets.symmetric(horizontal: 16 * wp),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: _green,
                      size:  24 * wp,
                    ),
                  ),
                  SizedBox(width: 12 * wp),
                  Text(
                    'Saved Vehicles',
                    style: TextStyle(
                      color:      _green,
                      fontSize:   20 * wp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // ── Vehicle List ────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * wp,
                  vertical:   20 * hp,
                ),
                itemCount:     _vehicles.length,
                separatorBuilder: (_, _) => SizedBox(height: 16 * hp),
                itemBuilder: (context, i) {
                  final v = _vehicles[i];
                  return _VehicleCard(
                    name:     v['name']!,
                    km:       v['km']!,
                    fuel:     v['fuel']!,
                    trans:    v['trans']!,
                    price:    v['price']!,
                    emi:      v['emi']!,
                    location: v['location']!,
                    image:    v['image']!,
                    wp:       wp,
                    hp:       hp,
                    onFavTap: () {
                      setState(() => _vehicles.removeAt(i));
                    },
                    onViewTap: () {/* navigate to seller details */},
                  );
                },
              ),
            ),
          ],
        ),
      );
  }
}

// ─────────────────────────────────────────────
//  _VehicleCard
// ─────────────────────────────────────────────
class _VehicleCard extends StatelessWidget {
  final String name;
  final String km;
  final String fuel;
  final String trans;
  final String price;
  final String emi;
  final String location;
  final String image;
  final double wp;
  final double hp;
  final VoidCallback onFavTap;
  final VoidCallback onViewTap;

  static const _blue   = Color(0xFF1A237E);
  static const _purple = Color(0xFF7B3FA0);

  const _VehicleCard({
    required this.name,
    required this.km,
    required this.fuel,
    required this.trans,
    required this.price,
    required this.emi,
    required this.location,
    required this.image,
    required this.wp,
    required this.hp,
    required this.onFavTap,
    required this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:        Colors.white,
        borderRadius: BorderRadius.circular(12 * wp),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset:     const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Top Row: image + details ──────────────────────
          Padding(
            padding: EdgeInsets.only(
              top:   1 * hp,
              left:  0,
              right: 12 * wp,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // ── Car image with blue corner shape ─────────
                SizedBox(
                  width:  140 * wp,
                  height: 110 * hp,
                  child: Stack(
                    children: [
                      // ── Blue circle (top-left overflow) ──────────
                      Positioned(
                        left: -(wp * 400 * 0.26),
                        top:  -(wp * 400 * 0.22),
                        child: Container(
                          width:  wp * 420 * 0.38,
                          height: wp * 390 * 0.38,
                          decoration: const BoxDecoration(
                            color: Color(0xFF040084),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Car image
                      Positioned(
                        bottom: 0,
                        left:   0,
                        right:  0,
                        child: Image.asset(
                          image,
                          height: 90 * hp,
                          fit:    BoxFit.contain,
                          errorBuilder: (_, _, _) => Container(
                            height: 90 * hp,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.directions_car,
                              size:  60 * wp,
                              color: const Color(0xFFCCCCCC),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8 * wp),

                // ── Details ───────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Name + Heart
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: TextStyle(
                                fontSize:   13 * wp,
                                fontWeight: FontWeight.w700,
                                color:      _blue,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onFavTap,
                            child: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size:  20 * wp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4 * hp),

                      // km | Fuel | Manual
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12 * wp,
                            color:    const Color(0xFF1A1A1A),
                          ),
                          children: [
                            TextSpan(text: '$km | $fuel | '),
                            TextSpan(
                              text: trans,
                              style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4 * hp),

                      // Price
                      Text(
                        price,
                        style: TextStyle(
                          fontSize:   18 * wp,
                          fontWeight: FontWeight.w800,
                          color:      Color(0xFF040084),
                        ),
                      ),
                      SizedBox(height: 4 * hp),

                      // EMI + Location
                      Row(
                        children: [
                          Text(
                            'EMI  $emi',
                            style: TextStyle(
                              fontSize: 11 * wp,
                              color:    Color(0xFF040084),
                            ),
                          ),
                          SizedBox(width: 6 * wp),
                          // pin icon
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size:  16 * wp,
                          ),
                          SizedBox(width: 2 * wp),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 11 * wp,
                              color:    const Color(0xFF444444),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 8 * hp),

          // ── Dashed Divider ────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12 * wp),
            child: LayoutBuilder(
              builder: (context, constraints) {
                const dashW  = 6.0;
                const dashH  = 1.5;
                const gap    = 4.0;
                final count  = (constraints.maxWidth / (dashW + gap)).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(count, (_) => Container(
                    width:  dashW,
                    height: dashH,
                    color:  const Color(0xFFAAAAAA),
                  )),
                );
              },
            ),
          ),

          // ── View Seller Details ───────────────────────────
          GestureDetector(
            onTap: onViewTap,
            child: Container(
              width:  double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12 * hp),
              alignment: Alignment.center,
              child: Text(
                'View Seller Details',
                style: TextStyle(
                  fontSize:   14 * wp,
                  fontWeight: FontWeight.w600,
                  color:      _purple,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

