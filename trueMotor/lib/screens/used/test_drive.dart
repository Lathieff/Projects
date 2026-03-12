import 'package:flutter/material.dart';

class TestDriveScreen extends StatefulWidget {
  const TestDriveScreen({super.key});

  @override
  State<TestDriveScreen> createState() => _TestDriveScreenState();
}

class _TestDriveScreenState extends State<TestDriveScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _timeSlotController = TextEditingController();

  String _selectedVehicle = 'Car';
  String _selectedLocation = 'Coimbatore';
  String? _preferredDate;
  bool _showSuccess = false;
  String _confirmedAtText = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _timeSlotController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _fullNameController.text.trim().isNotEmpty &&
        _contactController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _timeSlotController.text.trim().isNotEmpty &&
        (_preferredDate ?? '').trim().isNotEmpty &&
        _selectedVehicle.trim().isNotEmpty &&
        _selectedLocation.trim().isNotEmpty;
  }

  void _bookTestDrive() {
    if (!_isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
      return;
    }
    setState(() {
      _confirmedAtText = _formatNow();
      _showSuccess = true;
    });
  }

  String _formatNow() {
    final dt = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final day = dt.day.toString().padLeft(2, '0');
    final month = months[dt.month - 1];
    final year = dt.year;
    final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final min = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'pm' : 'am';
    return '$day $month-$year $hour12:$min $period';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      final dd = picked.day.toString().padLeft(2, '0');
      final mm = picked.month.toString().padLeft(2, '0');
      final yy = picked.year.toString();
      setState(() => _preferredDate = '$dd/$mm/$yy');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    if (_showSuccess) {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sw * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/gif/test_drive.gif',
                    width: sw * 0.35,
                    height: sw * 0.35,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(
                      Icons.check_circle,
                      color: const Color(0xFF3E71E8),
                      size: sw * 0.26,
                    ),
                  ),
                  SizedBox(height: sh * 0.03),
                  Text(
                    'Congratulations',
                    style: TextStyle(
                      fontSize: sw * 0.055,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: sh * 0.025),
                  Text(
                    'Your free test drive booking\nConfirmed on $_confirmedAtText',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: sw * 0.038,
                      color: const Color(0xFF2F2F2F),
                    ),
                  ),
                  SizedBox(height: sh * 0.06),
                  SizedBox(
                    width: sw * 0.45,
                    height: sh * 0.052,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF006B70),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: sw * 0.045,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0B664A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Schedule free Test Drive',
          style: TextStyle(
            color: Color(0xFF0B664A),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(sw * 0.03, sh * 0.01, sw * 0.03, sh * 0.02),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.03),
          decoration: BoxDecoration(
            color: const Color(0xFFECECEC),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _carCard(sw, sh),
              SizedBox(height: sh * 0.01),
              _input(sw, _fullNameController, 'Full Name'),
              SizedBox(height: sh * 0.009),
              _input(sw, _contactController, 'Contact Number'),
              SizedBox(height: sh * 0.009),
              _input(sw, _emailController, 'Email Address'),
              SizedBox(height: sh * 0.009),
              _dropdown(sw, 'Select Vehicle', _selectedVehicle, ['Car', 'Bike', 'Scooty'], (v) {
                setState(() => _selectedVehicle = v);
              }),
              SizedBox(height: sh * 0.009),
              _calendarField(sw, 'Preferred Date', _preferredDate ?? '', _pickDate),
              SizedBox(height: sh * 0.009),
              _dropdown(sw, 'Your location', _selectedLocation, ['Coimbatore', 'Chennai', 'Tiruppur'], (v) {
                setState(() => _selectedLocation = v);
              }),
              SizedBox(height: sh * 0.009),
              _input(sw, _timeSlotController, 'Preferred Time Slot'),
              SizedBox(height: sh * 0.012),
              SizedBox(
                width: double.infinity,
                height: sh * 0.055,
                child: ElevatedButton(
                  onPressed: _bookTestDrive,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006B70),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(
                    'Book Test Drive',
                    style: TextStyle(
                      fontSize: sw * 0.04,
                      color: Colors.white,
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

  Widget _carCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(sw * 0.02, sh * 0.008, sw * 0.02, sh * 0.005),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: sw * 0.25,
                height: sw * 0.18,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: sw * 0.08,
                        height: sw * 0.08,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0A3FA8),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                    ),
                    Center(child: Image.asset('assets/swift.png', fit: BoxFit.contain)),
                  ],
                ),
              ),
              SizedBox(width: sw * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Maruti Suzuki Swift VXI 2021',
                            style: TextStyle(
                              fontSize: sw * 0.033,
                              color: const Color(0xFF2101AF),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(Icons.favorite_border, color: const Color(0xFF8B429A), size: sw * 0.048),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: sw * 0.031, color: const Color(0xFF262626)),
                        children: const [
                          TextSpan(text: '25,000 km | Petrol | '),
                          TextSpan(text: 'Manual', style: TextStyle(color: Color(0xFF742B88))),
                        ],
                      ),
                    ),
                    SizedBox(height: sh * 0.001),
                    Text(
                      '₹ 9.2 Lakh',
                      style: TextStyle(
                        fontSize: sw * 0.055,
                        color: const Color(0xFF040084),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'EMI ₹13,470/mo',
                          style: TextStyle(fontSize: sw * 0.026, color: const Color(0xFF3F51B5)),
                        ),
                        const Spacer(),
                        const Icon(Icons.location_on, color: Colors.red, size: 13),
                        Text(
                          'Coimbatore',
                          style: TextStyle(fontSize: sw * 0.034, color: const Color(0xFF555555)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: sh * 0.005),
          const Divider(color: Color(0xFFC8C8C8), height: 1),
          SizedBox(height: sh * 0.004),
          Text(
            'View Seller Details',
            style: TextStyle(
              fontSize: sw * 0.038,
              color: const Color(0xFF8B429A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _input(double sw, TextEditingController controller, String hint) {
    return SizedBox(
      height: sw * 0.105,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: sw * 0.032, color: const Color(0xFF5B5B5B)),
          contentPadding: EdgeInsets.symmetric(horizontal: sw * 0.025, vertical: sw * 0.015),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFF8B429A)),
          ),
          filled: true,
          fillColor: const Color(0xFFECECEC),
        ),
      ),
    );
  }

  Widget _dropdown(
    double sw,
    String label,
    String value,
    List<String> options,
    ValueChanged<String> onChanged,
  ) {
    return Container(
      height: sw * 0.105,
      padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF9E9E9E)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, size: sw * 0.05, color: const Color(0xFF0B664A)),
          items: options
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: TextStyle(fontSize: sw * 0.031, color: const Color(0xFF1D1D1D)),
                    ),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          hint: Text(label),
        ),
      ),
    );
  }

  Widget _calendarField(double sw, String label, String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: sw * 0.105,
        padding: EdgeInsets.symmetric(horizontal: sw * 0.025),
        decoration: BoxDecoration(
          color: const Color(0xFFECECEC),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF9E9E9E)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value.isEmpty ? label : value,
                style: TextStyle(fontSize: sw * 0.032, color: const Color(0xFF5B5B5B)),
              ),
            ),
            Icon(Icons.calendar_month_outlined, size: sw * 0.048, color: const Color(0xFF0B664A)),
          ],
        ),
      ),
    );
  }
}
