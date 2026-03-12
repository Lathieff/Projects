import 'package:flutter/material.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/sell/sell_upload.dart';

class SellCarScreen extends StatefulWidget {
  const SellCarScreen({super.key});

  @override
  State<SellCarScreen> createState() => _SellCarScreenState();
}

class _SellCarScreenState extends State<SellCarScreen> {
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedFuelType;
  String? _selectedTransmission;
  String? _selectedRegistrationYear;
  String? _selectedLocation;
  String? _selectedRTO;
  String? _selectedFeatureChecklist;

  bool _brandExpanded = false;
  bool _modelExpanded = false;
  bool _fuelExpanded = false;
  bool _transmissionExpanded = false;
  bool _regYearExpanded = false;
  bool _locationExpanded = false;
  bool _rtoExpanded = false;
  bool _featureExpanded = false;

  final TextEditingController _kmsDrivenController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _insuranceValidityController = TextEditingController();

  final List<String> _brands = [
    'Maruti Suzuki', 'Hyundai', 'Tata', 'Honda', 'Toyota', 'Ford', 'Kia'
  ];
  final List<String> _models = [
    'Swift', 'i20', 'Nexon', 'City', 'Innova', 'EcoSport', 'Seltos'
  ];
  final List<String> _fuelTypes = ['Petrol', 'Diesel', 'CNG', 'Electric'];
  final List<String> _transmissions = ['Manual', 'Automatic', 'AMT', 'CVT'];
  final List<String> _registrationYears = List.generate(
    15, (i) => (DateTime.now().year - i).toString(),
  );
  final List<String> _locations = [
    'Coimbatore', 'Chennai', 'Bangalore', 'Hyderabad', 'Mumbai'
  ];
  final List<String> _rtoList = [
    'TN 57 - Coimbatore', 'TN 01 - Chennai', 'KA 01 - Bangalore',
    'TS 09 - Hyderabad', 'MH 01 - Mumbai'
  ];
  final List<String> _featureChecklists = [
    'AC', 'Power Steering', 'Power Windows', 'ABS', 'Airbags',
    'Sunroof', 'Reverse Camera'
  ];

  void _closeAll() {
    _brandExpanded = false;
    _modelExpanded = false;
    _fuelExpanded = false;
    _transmissionExpanded = false;
    _regYearExpanded = false;
    _locationExpanded = false;
    _rtoExpanded = false;
    _featureExpanded = false;
  }

  @override
  void dispose() {
    _kmsDrivenController.dispose();
    _priceController.dispose();
    _insuranceValidityController.dispose();
    super.dispose();
  }

  Future<void> _pickInsuranceDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF005F65)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _insuranceValidityController.text =
        '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
            children: [

              // ✅ AppBar
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.015,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                      child: Icon(Icons.arrow_back,
                          size: screenWidth * 0.06, color: Colors.black),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Text(
                      'Sell car',
                      style: TextStyle(
                        fontSize: screenWidth * 0.052,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Fully Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ✅ Banner Card
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(screenWidth * 0.04),
                        height: screenHeight * 0.17,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D1B5E),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Image.asset(
                                'assets/swift_car.png',
                                width: screenWidth * 0.46,
                                height: screenHeight * 0.16,
                                fit: BoxFit.contain,
                                errorBuilder: (_, _, _) => Icon(
                                  Icons.directions_car,
                                  size: screenWidth * 0.2,
                                  color: Colors.white24,
                                ),
                              ),
                            ),
                            Positioned(
                              right: screenWidth * 0.04,
                              top: screenHeight * 0.015,
                              bottom: screenHeight * 0.015,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sell Your Car Instantly.',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.033,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text('Best price. Free inspection.',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.028,
                                          color: Colors.white70)),
                                  Text('Instant payment.',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.028,
                                          color: Colors.white70)),
                                  SizedBox(height: screenHeight * 0.01),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: const Color(0xFF0D1B5E),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.04,
                                        vertical: screenHeight * 0.006,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6)),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      'Get Free Quote',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.03,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ✅ Vehicle label
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sell Vehicle – TN 57 BB 1010',
                              style: TextStyle(
                                fontSize: screenWidth * 0.038,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.004),
                            Text(
                              'Add Or Edit Vehicle',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.034,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.015),

                      // ✅ Form Fields
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Select Brand',
                              value: _selectedBrand,
                              isExpanded: _brandExpanded,
                              items: _brands,
                              onToggle: () => setState(() {
                                bool prev = _brandExpanded;
                                _closeAll();
                                _brandExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedBrand = (_selectedBrand == val) ? null : val;
                                _brandExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Select Model',
                              value: _selectedModel,
                              isExpanded: _modelExpanded,
                              items: _models,
                              onToggle: () => setState(() {
                                bool prev = _modelExpanded;
                                _closeAll();
                                _modelExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedModel = (_selectedModel == val) ? null : val;
                                _modelExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Fuel Type',
                              value: _selectedFuelType,
                              isExpanded: _fuelExpanded,
                              items: _fuelTypes,
                              onToggle: () => setState(() {
                                bool prev = _fuelExpanded;
                                _closeAll();
                                _fuelExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedFuelType = (_selectedFuelType == val) ? null : val;
                                _fuelExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Transmission',
                              value: _selectedTransmission,
                              isExpanded: _transmissionExpanded,
                              items: _transmissions,
                              onToggle: () => setState(() {
                                bool prev = _transmissionExpanded;
                                _closeAll();
                                _transmissionExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedTransmission = (_selectedTransmission == val) ? null : val;
                                _transmissionExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Registration Year',
                              value: _selectedRegistrationYear,
                              isExpanded: _regYearExpanded,
                              items: _registrationYears,
                              onToggle: () => setState(() {
                                bool prev = _regYearExpanded;
                                _closeAll();
                                _regYearExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedRegistrationYear = (_selectedRegistrationYear == val) ? null : val;
                                _regYearExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildTextField(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              controller: _kmsDrivenController,
                              hint: 'Kms Driven',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Location',
                              value: _selectedLocation,
                              isExpanded: _locationExpanded,
                              items: _locations,
                              onToggle: () => setState(() {
                                bool prev = _locationExpanded;
                                _closeAll();
                                _locationExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedLocation = (_selectedLocation == val) ? null : val;
                                _locationExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Select RTO',
                              value: _selectedRTO,
                              isExpanded: _rtoExpanded,
                              items: _rtoList,
                              onToggle: () => setState(() {
                                bool prev = _rtoExpanded;
                                _closeAll();
                                _rtoExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedRTO = (_selectedRTO == val) ? null : val;
                                _rtoExpanded = false;
                              }),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildTextField(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              controller: _priceController,
                              hint: 'Price',
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            // Insurance Validity Date
                            GestureDetector(
                              onTap: _pickInsuranceDate,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.04,
                                  vertical: screenHeight * 0.016,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.grey.shade300),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _insuranceValidityController.text.isEmpty
                                          ? 'Insurance Validity Date'
                                          : _insuranceValidityController.text,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.037,
                                        color: _insuranceValidityController
                                            .text.isEmpty
                                            ? Colors.grey.shade500
                                            : Colors.black87,
                                      ),
                                    ),
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      size: screenWidth * 0.05,
                                      color: const Color(0xFF742B88),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.012),

                            _buildCustomDropdown(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                              hint: 'Feature Checklist',
                              value: _selectedFeatureChecklist,
                              isExpanded: _featureExpanded,
                              items: _featureChecklists,
                              onToggle: () => setState(() {
                                bool prev = _featureExpanded;
                                _closeAll();
                                _featureExpanded = !prev;
                              }),
                              onSelect: (val) => setState(() {
                                _selectedFeatureChecklist =
                                (_selectedFeatureChecklist == val)
                                    ? null
                                    : val;
                                _featureExpanded = false;
                              }),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // ✅ Save & Next — scroll-க்குள்ளே
                            SizedBox(
                              width: double.infinity,
                              height: screenHeight * 0.065,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      const SellCarimage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF005F65),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  'Save & Next',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.025),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildCustomDropdown({
    required double screenWidth,
    required double screenHeight,
    required String hint,
    required String? value,
    required bool isExpanded,
    required List<String> items,
    required VoidCallback onToggle,
    required ValueChanged<String> onSelect,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.016,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isExpanded ? hint : (value ?? hint),
                  style: TextStyle(
                    fontSize: screenWidth * 0.037,
                    color: (!isExpanded && value != null)
                        ? Colors.black87
                        : Colors.grey.shade500,
                    fontWeight: (!isExpanded && value != null)
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: const Color(0xFF742B88),
                  size: screenWidth * 0.055,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Column(
            children: items.map((item) {
              final bool isSelected = value == item;
              return GestureDetector(
                onTap: () => onSelect(item),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: screenHeight * 0.008),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.015,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: screenWidth * 0.037,
                      color: Colors.black87,
                      fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildTextField({
    required double screenWidth,
    required double screenHeight,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: screenWidth * 0.037),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenWidth * 0.037,
          color: Colors.grey.shade500,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.016,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF005F65), width: 1.5),
        ),
      ),
    );
  }
}
