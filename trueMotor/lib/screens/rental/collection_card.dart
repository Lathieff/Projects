import 'dart:async';
import 'package:flutter/material.dart';

class CollectionCardPage extends StatefulWidget {
  const CollectionCardPage({
    super.key,
    required this.carName,
    required this.pricePerDay,
    required this.carImage,
    required this.pickupDate,
    required this.returnDate,
    required this.location,
  });

  final String carName;
  final String pricePerDay;
  final String carImage;
  final String pickupDate;
  final String returnDate;
  final String location;

  @override
  State<CollectionCardPage> createState() => _CollectionCardPageState();
}

class _CollectionCardPageState extends State<CollectionCardPage> {
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;
  int _bannerIndex = 0;
  late final List<String> _banners;

  @override
  void initState() {
    super.initState();
    _banners = [
      widget.carImage,
      'assets/creta_2.png',
      'assets/creta_3.png',
    ];
    _bannerTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_bannerController.hasClients) return;
      final next = (_bannerIndex + 1) % _banners.length;
      _bannerController.animateToPage(
        next,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
      setState(() => _bannerIndex = next);
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: const Color(0xFF0A6363), size: w * 0.06),
        ),
        title: Text(
          'Rental',
          style: TextStyle(color: const Color(0xFF0A6363), fontSize: w * 0.05, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.012),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rental Vehicle By Truemotors', style: TextStyle(fontSize: w * 0.036, fontWeight: FontWeight.w600)),
              SizedBox(height: h * 0.008),
              ClipRRect(
                borderRadius: BorderRadius.circular(w * 0.02),
                child: SizedBox(
                  width: double.infinity,
                  height: h * 0.20,
                  child: PageView.builder(
                    controller: _bannerController,
                    onPageChanged: (i) => setState(() => _bannerIndex = i),
                    itemCount: _banners.length,
                    itemBuilder: (_, i) => Image.asset(_banners[i], fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: h * 0.006),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _banners.length,
                  (i) => Container(
                    margin: EdgeInsets.symmetric(horizontal: w * 0.006),
                    width: i == _bannerIndex ? w * 0.04 : w * 0.02,
                    height: w * 0.012,
                    decoration: BoxDecoration(
                      color: i == _bannerIndex ? const Color(0xFF0A6363) : const Color(0xFFB0B0B0),
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
              Row(
                children: [
                  Expanded(
                    child: Text(widget.carName, style: TextStyle(fontSize: w * 0.034, fontWeight: FontWeight.w600)),
                  ),
                  Icon(Icons.favorite_border, size: w * 0.05),
                  SizedBox(width: w * 0.02),
                  Icon(Icons.share_outlined, size: w * 0.05),
                ],
              ),
              SizedBox(height: h * 0.004),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: w * 0.036, color: const Color(0xFF005F65)),
                  Text(widget.location,
                      style: TextStyle(color: const Color(0xFF005F65), fontSize: w * 0.031, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Text(
                    widget.pricePerDay,
                    style: TextStyle(color: const Color(0xFF053AA7), fontSize: w * 0.034, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(width: w * 0.02),
                  Icon(Icons.star, color: const Color(0xFFF6C026), size: w * 0.035),
                  SizedBox(width: w * 0.006),
                  Text('4.5/5', style: TextStyle(fontSize: w * 0.03)),
                ],
              ),
              SizedBox(height: h * 0.01),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.02),
                  border: Border.all(color: const Color(0xFFD4D4D4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Features', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600)),
                    SizedBox(height: h * 0.006),
                    Wrap(
                      spacing: w * 0.03,
                      runSpacing: h * 0.004,
                      children: [
                        _feature(w, Icons.speed, '200'),
                        _feature(w, Icons.settings, 'Manual'),
                        _feature(w, Icons.airline_seat_recline_normal, '5 Seats'),
                        _feature(w, Icons.ac_unit, 'Cruise Control'),
                        _feature(w, Icons.usb, 'Android Auto'),
                        _feature(w, Icons.gps_fixed, 'GPS system'),
                        _feature(w, Icons.tv, 'Air Conditioning'),
                      ],
                    ),
                    SizedBox(height: h * 0.008),
                    Text('Description', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600)),
                    SizedBox(height: h * 0.004),
                    Text(
                      'Experience the perfect blend of style, space, and performance with the Hyundai Creta, ideal for city rides and weekend getaways.',
                      style: TextStyle(fontSize: w * 0.028, color: const Color(0xFF444444)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.02),
                  border: Border.all(color: const Color(0xFFD4D4D4)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(radius: w * 0.05, backgroundImage: const AssetImage('assets/jimmy.png')),
                    SizedBox(width: w * 0.02),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Owner Info', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              Icon(Icons.star, color: const Color(0xFFF6C026), size: w * 0.032),
                              SizedBox(width: w * 0.008),
                              Text('4.5/5  (180 Review)', style: TextStyle(fontSize: w * 0.026)),
                            ],
                          ),
                          Text('Joined 8 Month Ago', style: TextStyle(fontSize: w * 0.026, color: const Color(0xFF555555))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(w * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(w * 0.02),
                  border: Border.all(color: const Color(0xFFD4D4D4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Car Name : ${widget.carName}', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w500)),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context, true),
                          child: Row(
                            children: [
                              Icon(Icons.edit, color: const Color(0xFF0A6363), size: w * 0.04),
                              SizedBox(width: w * 0.01),
                              Text('Edit', style: TextStyle(fontSize: w * 0.028, color: const Color(0xFF0A6363))),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.006),
                    Row(
                      children: [
                        Expanded(child: _detail('Pickup Date & Time\n${widget.pickupDate}  06:00 AM', w)),
                        Expanded(child: _detail('Return Date & Time\n${widget.returnDate}  06:00 PM', w)),
                      ],
                    ),
                    SizedBox(height: h * 0.004),
                    Text('Location', style: TextStyle(fontSize: w * 0.03, fontWeight: FontWeight.w600)),
                    Text('123, Parker street, Rogers Road, Wanda,\nNowhere - XRT589',
                        style: TextStyle(fontSize: w * 0.026, color: const Color(0xFF333333), height: 1.35)),
                    SizedBox(height: h * 0.008),
                    _priceRow(w, 'Base Price', '\u20B92,150'),
                    _priceRow(w, 'Delivery & pickup charge', '\u20B9500'),
                    _priceRow(w, 'Refundable security deposit', '\u20B91,000'),
                    Divider(height: h * 0.02),
                    _priceRow(w, 'Total', '\u20B93,650', bold: true),
                  ],
                ),
              ),
              SizedBox(height: h * 0.014),
              SizedBox(
                width: double.infinity,
                height: h * 0.05,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006D73),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * 0.02)),
                  ),
                  child: Text('Proceed', style: TextStyle(fontSize: w * 0.034, fontWeight: FontWeight.w600, color: Colors.white)),
                ),
              ),
              SizedBox(height: h * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(double w, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: w * 0.03, color: const Color(0xFF444444)),
        SizedBox(width: w * 0.008),
        Text(text, style: TextStyle(fontSize: w * 0.026, color: const Color(0xFF333333))),
      ],
    );
  }

  Widget _detail(String text, double w) {
    return Text(text, style: TextStyle(fontSize: w * 0.026, color: Colors.black87, height: 1.35));
  }

  Widget _priceRow(double w, String left, String right, {bool bold = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: w * 0.012),
      child: Row(
        children: [
          Expanded(
            child: Text(left, style: TextStyle(fontSize: w * 0.028, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
          ),
          Text(right, style: TextStyle(fontSize: w * 0.028, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
