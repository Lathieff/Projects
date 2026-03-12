import 'package:flutter/material.dart';
import 'package:truemotor/screens/rental/collection_card.dart';

class RentalBookingPage extends StatefulWidget {
  const RentalBookingPage({super.key});

  @override
  State<RentalBookingPage> createState() => _RentalBookingPageState();
}

class _RentalBookingPageState extends State<RentalBookingPage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _returnController = TextEditingController();

  String _selectedLocation = 'Coimbatore';
  String _appliedQuery = 'Creta';
  bool _showCollection = false;
  bool _animateEditTransition = false;

  @override
  void dispose() {
    _searchController.dispose();
    _pickupController.dispose();
    _returnController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );
    if (selected == null) return;
    final day = selected.day.toString().padLeft(2, '0');
    final month = selected.month.toString().padLeft(2, '0');
    final year = selected.year.toString();
    controller.text = '$day/$month/$year';
  }

  Future<void> _selectLocation() async {
    final items = ['Coimbatore', 'Chennai', 'Bangalore', 'Hyderabad'];
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: items
              .map(
                (city) => ListTile(
                  title: Text(city),
                  onTap: () => Navigator.pop(context, city),
                ),
              )
              .toList(),
        ),
      ),
    );
    if (result == null) return;
    setState(() => _selectedLocation = result);
  }

  void _showResults() {
    setState(() {
      _appliedQuery = _searchController.text.trim().isEmpty ? 'Creta' : _searchController.text.trim();
      _animateEditTransition = false;
      _showCollection = true;
    });
  }

  void _showBookingForm() {
    setState(() {
      _animateEditTransition = true;
      _showCollection = false;
    });
  }

  Future<void> _openCollectionCard(String image, String name, String price) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => CollectionCardPage(
          carName: name,
          pricePerDay: price,
          carImage: image,
          pickupDate: _pickupController.text.isEmpty ? 'dd/mm/yyyy' : _pickupController.text,
          returnDate: _returnController.text.isEmpty ? 'dd/mm/yyyy' : _returnController.text,
          location: _selectedLocation,
        ),
      ),
    );
    if (result == true) {
      _showBookingForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    final transitionDuration = _animateEditTransition ? const Duration(milliseconds: 420) : Duration.zero;

    final cars = [
      ('assets/creta.png', 'Hyundai Creta', '\u20B91400/day'),
      ('assets/innova.png', 'Toyota Innova Crysta', '\u20B91400/day'),
      ('assets/creta.png', 'Hyundai Creta', '\u20B91400/day'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: const Color(0xFF0A6363), size: w * 0.06),
        ),
        title: Text(
          'Rental',
          style: TextStyle(
            color: const Color(0xFF0A6363),
            fontSize: w * 0.05,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: transitionDuration,
              curve: Curves.easeInOutCubic,
              height: _showCollection ? 0 : h * 0.20,
              child: ClipRect(
                child: AnimatedSlide(
                  duration: transitionDuration,
                  curve: Curves.easeInOutCubic,
                  offset: _showCollection ? const Offset(0, -1.25) : Offset.zero,
                  child: AnimatedOpacity(
                    duration: transitionDuration,
                    opacity: _showCollection ? 0 : 1,
                    child: Image.asset(
                      'assets/rental_banner.png',
                      width: w,
                      height: h * 0.20,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.012),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.012),
                  Text(
                    'Rental Vehicle By Truemotors',
                    style: TextStyle(fontSize: w * 0.044, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: h * 0.008),
                  AnimatedSize(
                    duration: transitionDuration,
                    curve: Curves.easeInOut,
                    child: AnimatedSwitcher(
                      duration: transitionDuration,
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        final slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(animation);
                        return FadeTransition(opacity: animation, child: SlideTransition(position: slide, child: child));
                      },
                      child: _showCollection
                          ? Column(
                              key: const ValueKey('collection_top'),
                              children: [
                                _collectionTopCard(w, h),
                                SizedBox(height: h * 0.01),
                                Row(
                                  children: [
                                    _chip(w, Icons.filter_list, 'Filter'),
                                    SizedBox(width: w * 0.02),
                                    _chip(w, Icons.sort, 'Bad by Type'),
                                    SizedBox(width: w * 0.02),
                                    _chip(w, Icons.local_gas_station_outlined, 'Fuel Type'),
                                  ],
                                ),
                                SizedBox(height: h * 0.01),
                                Text('03 Car Available in your Location',
                                    style: TextStyle(fontSize: w * 0.034, fontWeight: FontWeight.w600)),
                                SizedBox(height: h * 0.008),
                                ...cars.map((car) => Padding(
                                      padding: EdgeInsets.only(bottom: h * 0.012),
                                      child: _rentalCard(w, h, car.$1, car.$2, car.$3),
                                    )),
                                SizedBox(height: h * 0.004),
                              ],
                            )
                          : Container(
                              key: const ValueKey('booking_top'),
                              width: double.infinity,
                              padding: EdgeInsets.all(w * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(w * 0.025),
                                border: Border.all(color: const Color(0xFFCDCDCD)),
                              ),
                              child: Column(
                                children: [
                                  _inputField(
                                    width: w,
                                    controller: _searchController,
                                    hint: 'Search Car Name or Brand',
                                    prefix: Icons.search,
                                  ),
                                  SizedBox(height: h * 0.008),
                                  _inputField(
                                    width: w,
                                    controller: _pickupController,
                                    hint: 'dd/mm/yyyy',
                                    label: 'Pickup Date',
                                    suffix: Icons.calendar_month_outlined,
                                    onTap: () => _pickDate(_pickupController),
                                    readOnly: true,
                                  ),
                                  SizedBox(height: h * 0.008),
                                  _inputField(
                                    width: w,
                                    controller: _returnController,
                                    hint: 'dd/mm/yyyy',
                                    label: 'Return Date',
                                    suffix: Icons.calendar_month_outlined,
                                    onTap: () => _pickDate(_returnController),
                                    readOnly: true,
                                  ),
                                  SizedBox(height: h * 0.008),
                                  InkWell(
                                    onTap: _selectLocation,
                                    child: Container(
                                      height: h * 0.05,
                                      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(w * 0.018),
                                        border: Border.all(color: const Color(0xFF8A8A8A)),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            _selectedLocation,
                                            style: TextStyle(fontSize: w * 0.033, color: Colors.black87),
                                          ),
                                          const Spacer(),
                                          Icon(Icons.chevron_right, color: const Color(0xFF0A6363), size: w * 0.06),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.014),
                                  SizedBox(
                                    width: w * 0.45,
                                    height: h * 0.048,
                                    child: ElevatedButton(
                                      onPressed: _showResults,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF006D73),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(w * 0.02),
                                        ),
                                      ),
                                      child: Text(
                                        'Search',
                                        style: TextStyle(
                                          fontSize: w * 0.037,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: h * 0.012),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.012),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2494D),
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Well-Maintained Car',
                                style: TextStyle(color: Colors.white, fontSize: w * 0.045, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: h * 0.004),
                              Text(
                                'Every car is inspected &\nmaintained to perfection.\nEnjoy a worry-free ride.',
                                style: TextStyle(color: Colors.white, fontSize: w * 0.031),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.car_repair, color: Colors.white, size: w * 0.12),
                      ],
                    ),
                  ),
                  SizedBox(height: h * 0.014),
                  Text('How Its Work', style: TextStyle(fontSize: w * 0.042, fontWeight: FontWeight.w700)),
                  SizedBox(height: h * 0.006),
                  ...[
                    'Step By Step To Rent a vehicle on Platform',
                    '1. Choose Vehicle: Browse available cars & bikes.',
                    '2. Select Duration: Pick your rental period.',
                    '3. Book & Pay: Confirm your booking securely.',
                    '4. Pickup/Delivery: Get your vehicle at your doorstep or pick it up at our hub.',
                  ].map(
                    (line) => Padding(
                      padding: EdgeInsets.only(bottom: h * 0.004),
                      child: Text(line, style: TextStyle(fontSize: w * 0.035, color: Colors.black87)),
                    ),
                  ),
                  SizedBox(height: h * 0.008),
                  Center(
                    child: Text(
                      'Explore Our Collection Cars',
                      style: TextStyle(fontSize: w * 0.044, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: h * 0.008),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(w * 0.03),
                      border: Border.all(color: const Color(0xFFDDDDDD)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.03)),
                          child: Image.asset(
                            'assets/grand_nios.png',
                            width: double.infinity,
                            height: h * 0.20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(w * 0.03),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Hyundai Grand\ni10 Nios sportz',
                                      style: TextStyle(fontSize: w * 0.034, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    '\u20B91400/day',
                                    style: TextStyle(
                                      color: const Color(0xFF053AA7),
                                      fontSize: w * 0.034,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.005),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: w * 0.036, color: const Color(0xFF005F65)),
                                  Text(
                                    _selectedLocation,
                                    style: TextStyle(
                                      color: const Color(0xFF005F65),
                                      fontSize: w * 0.031,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text('4.5/5', style: TextStyle(fontSize: w * 0.031, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _collectionTopCard(double w, double h) {
    return Container(
      width: double.infinity,
      height: h * 0.18,
      padding: EdgeInsets.all(w * 0.025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.02),
        border: Border.all(color: const Color(0xFFD4D4D4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Car Name : ${_appliedQuery.isEmpty ? 'Creta' : _appliedQuery}',
                  style: TextStyle(fontSize: w * 0.04, fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: _showBookingForm,
                child: Row(
                  children: [
                    Icon(Icons.edit, color: const Color(0xFF0A6363), size: w * 0.045),
                    SizedBox(width: w * 0.01),
                    Text('Edit', style: TextStyle(fontSize: w * 0.042, color: const Color(0xFF0A6363))),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.006),
          Row(
            children: [
              Expanded(
                child: _detailLabel(
                  'Pickup Date & Time\n${_pickupController.text.isEmpty ? 'dd/mm/yyyy' : _pickupController.text}  06:00 AM',
                  w,
                ),
              ),
              Expanded(
                child: _detailLabel(
                  'Return Date & Time\n${_returnController.text.isEmpty ? 'dd/mm/yyyy' : _returnController.text}  09:00 PM',
                  w,
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.004),
          Row(
            children: [
              Expanded(child: _detailLabel('Location\n$_selectedLocation', w)),
              Expanded(child: _detailLabel('No. Driver\nXTR569', w)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailLabel(String text, double w) {
    return Text(text, style: TextStyle(fontSize: w * 0.038, color: Colors.black87, height: 1.35));
  }

  Widget _chip(double w, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: w * 0.012),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.02),
        border: Border.all(color: const Color(0xFFD6D6D6)),
      ),
      child: Row(
        children: [
          Icon(icon, size: w * 0.042, color: const Color(0xFF555555)),
          SizedBox(width: w * 0.06),
          Text(label, style: TextStyle(fontSize: w * 0.026, color: const Color(0xFF333333))),
        ],
      ),
    );
  }

  Widget _rentalCard(double w, double h, String image, String name, String price) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w * 0.03),
        border: Border.all(color: const Color(0xFFDDDDDD)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.03)),
            child: Image.asset(image, width: double.infinity, height: h * 0.20, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(name, style: TextStyle(fontSize: w * 0.034, fontWeight: FontWeight.w600))),
                    Text(price,
                        style: TextStyle(color: const Color(0xFF053AA7), fontSize: w * 0.034, fontWeight: FontWeight.w700)),
                  ],
                ),
                SizedBox(height: h * 0.004),
                Row(
                  children: [
                    Icon(Icons.star, color: const Color(0xFFF6C026), size: w * 0.035),
                    SizedBox(width: w * 0.008),
                    Text('4.5/5', style: TextStyle(fontSize: w * 0.03)),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.006),
                      decoration: BoxDecoration(
                        color: const Color(0xFF006D73),
                        borderRadius: BorderRadius.circular(w * 0.01),
                      ),
                      child: InkWell(
                        onTap: () => _openCollectionCard(image, name, price),
                        child: Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white, fontSize: w * 0.028, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.004),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: w * 0.036, color: const Color(0xFF005F65)),
                    Text(_selectedLocation,
                        style: TextStyle(color: const Color(0xFF005F65), fontSize: w * 0.031, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required double width,
    required TextEditingController controller,
    required String hint,
    IconData? prefix,
    IconData? suffix,
    String? label,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      height: width * 0.130,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(fontSize: width * 0.033),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: width * 0.025, color: const Color(0xFF0A6363)),
          hintText: hint,
          hintStyle: TextStyle(fontSize: width * 0.03, color: Colors.grey),
          prefixIcon: prefix == null ? null : Icon(prefix, size: width * 0.045, color: Colors.grey),
          suffixIcon: suffix == null
              ? null
              : IconButton(
                  onPressed: onTap,
                  icon: Icon(suffix, size: width * 0.05, color: const Color(0xFF0A6363)),
                ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: width * 0.023),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.018),
            borderSide: const BorderSide(color: Color(0xFF8A8A8A)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.018),
            borderSide: const BorderSide(color: Color(0xFF8A8A8A)),
          ),
        ),
      ),
    );
  }
}
