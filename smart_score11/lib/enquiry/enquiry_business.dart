import 'package:flutter/material.dart';
import 'enquiry_personal.dart';
import 'enquiry_cibil.dart';

import 'package:smart_score/widgets/custom_bottom_nav.dart';

import 'package:flutter/services.dart';

class EnquiryBusiness extends StatefulWidget {
  const EnquiryBusiness({super.key});

  @override
  State<EnquiryBusiness> createState() => _EnquiryBusinessState();
}

class _EnquiryBusinessState extends State<EnquiryBusiness> {
  bool _agreed = false;
  bool _isCreditScoreDropdownOpen = false;
  bool _isEnquiryCategoryDropdownOpen = false;
  bool _isPanVerified = false;
  bool _isGstVerified = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  String? _selectedCreditScoreProvider;
  String? _selectedCategory;

  final List<String> _creditScoreProviders = [
    'Experian',
    'CRIF',
    'Transunion',
    'Equifax',
  ];

  final List<String> _enquiryCategories = [
    'Home Loan',
    'Personal Loan',
    'Credit Card',
    'Business Loan',
    'Vehicle Loan',
  ];

  @override
  void initState() {
    super.initState();
    // Add listeners to update button state
    _nameController.addListener(() => setState(() {}));
    _mobileController.addListener(() => setState(() {}));
    _panController.addListener(() => setState(() {}));
    _gstController.addListener(() => setState(() {}));
    _addressController.addListener(() => setState(() {}));
    _cityController.addListener(() => setState(() {}));
    _stateController.addListener(() => setState(() {}));
    _pincodeController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.of(context).size.width / 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70 * scale,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: Text(
          'Enquiry',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 20 * scale,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF5395FD), Color(0xFF00AA5B)],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0 * scale),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Radio Buttons
              Row(
                children: [
                  Radio<String>(
                    value: 'Business',
                    groupValue: 'Business', // Visually Selected
                    onChanged: (value) {
                      // Do nothing, already here
                    },
                    activeColor: const Color(0xFF003186),
                  ),
                  Text(
                    'Business',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * scale,
                    ),
                  ),
                  SizedBox(width: 20 * scale),
                  Radio<String>(
                    value: 'Personal',
                    groupValue: 'Business', // Visually Unselected
                    onChanged: (value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EnquiryPersonal(),
                        ),
                      );
                    },
                    activeColor: const Color(0xFF003186),
                  ),
                  Text(
                    'Personal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14 * scale,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10 * scale),

              // "Enquiry Form" Header
              Text(
                'Enquiry Form',
                style: TextStyle(
                  color: const Color(0xFF003186),
                  fontSize: 18 * scale,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                ),
              ),
              SizedBox(height: 10 * scale),

              // Form Fields
              _buildLabel('Full Name'),
              _buildTextField(
                hint: 'Enter Your Full Name',
                controller: _nameController,
              ),

              _buildLabel('Mobile Number'),
              _buildTextField(
                hint: 'Enter Your Mobile Number',
                keyboardType: TextInputType.phone,
                controller: _mobileController,
              ),

              _buildLabel('Credit Score Provider'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isCreditScoreDropdownOpen = !_isCreditScoreDropdownOpen;
                  });
                },
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF666666)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCreditScoreProvider ?? 'Select Credit Bureau',
                        style: TextStyle(
                          color: _selectedCreditScoreProvider == null
                              ? Colors.grey
                              : const Color(0xFF003186),
                          fontSize: 13,
                          fontWeight: _selectedCreditScoreProvider == null
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      Icon(
                        _isCreditScoreDropdownOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xFF666666),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isCreditScoreDropdownOpen) ...[
                const SizedBox(height: 5),
                ..._creditScoreProviders.map((option) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCreditScoreProvider = option;
                        _isCreditScoreDropdownOpen = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF003186)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: const TextStyle(
                              color: Color(0xFF003186),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down, // Or any icon you prefer
                            color: Color(0xFF003186),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],

              _buildLabel('Enquiry Category'),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isEnquiryCategoryDropdownOpen =
                        !_isEnquiryCategoryDropdownOpen;
                  });
                },
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF666666)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCategory ?? 'Select Enquiry Category',
                        style: TextStyle(
                          color: _selectedCategory == null
                              ? Colors.grey
                              : const Color(0xFF003186),
                          fontSize: 13,
                          fontWeight: _selectedCategory == null
                              ? FontWeight.normal
                              : FontWeight.bold,
                        ),
                      ),
                      Icon(
                        _isEnquiryCategoryDropdownOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: const Color(0xFF666666),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isEnquiryCategoryDropdownOpen) ...[
                const SizedBox(height: 5),
                ..._enquiryCategories.map((option) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = option;
                        _isEnquiryCategoryDropdownOpen = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFF003186)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            option,
                            style: const TextStyle(
                              color: Color(0xFF003186),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Color(0xFF003186),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],

              _buildLabel('PAN Number'),
              _buildTextField(
                hint: 'Enter PAN Number',
                suffixText: _isPanVerified ? 'Verified' : 'Verify',
                suffixColor: _isPanVerified ? Colors.blue : Colors.green,
                onSuffixTap: () {
                  if (_panController.text.isNotEmpty && !_isPanVerified) {
                    setState(() {
                      _isPanVerified = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('PAN Verified Successfully'),
                      ),
                    );
                  }
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                controller: _panController,
              ),

              // GST Field (Replaces Aadhaar/DOB)
              _buildLabel('GST No'),
              _buildTextField(
                hint: 'Enter GST Number',
                suffixText: _isGstVerified ? 'Verified' : 'Verify',
                suffixColor: _isGstVerified ? Colors.blue : Colors.green,
                onSuffixTap: () {
                  if (_gstController.text.isNotEmpty && !_isGstVerified) {
                    setState(() {
                      _isGstVerified = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('GST Verified Successfully'),
                      ),
                    );
                  }
                },
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                controller: _gstController,
              ),

              _buildLabel('Address'),
              _buildTextField(
                hint: 'Enter Address here',
                controller: _addressController,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildTextField(
                          hint: 'City',
                          controller: _cityController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        _buildTextField(
                          hint: 'State',
                          controller: _stateController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField(
                hint: 'Pincode',
                keyboardType: TextInputType.number,
                controller: _pincodeController,
              ),

              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed:
                      (_nameController.text.isEmpty ||
                          _mobileController.text.isEmpty ||
                          _selectedCreditScoreProvider == null ||
                          _panController.text.isEmpty ||
                          _gstController.text.isEmpty ||
                          _addressController.text.isEmpty ||
                          _cityController.text.isEmpty ||
                          _stateController.text.isEmpty ||
                          _pincodeController.text.isEmpty ||
                          !_isPanVerified ||
                          !_isGstVerified ||
                          !_agreed)
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EnquiryCibil(
                                applicationData: {
                                  'Name': _nameController.text,
                                  'Mobile': _mobileController.text,
                                  'ID_Type': 'GST',
                                  'ID_Number': _gstController.text,
                                  'PAN': _panController.text,
                                  'Address':
                                      '${_addressController.text}, ${_cityController.text}',
                                },
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        (_nameController.text.isEmpty ||
                            _mobileController.text.isEmpty ||
                            _selectedCreditScoreProvider == null ||
                            _panController.text.isEmpty ||
                            _gstController.text.isEmpty ||
                            _addressController.text.isEmpty ||
                            _cityController.text.isEmpty ||
                            _stateController.text.isEmpty ||
                            _pincodeController.text.isEmpty ||
                            !_isPanVerified ||
                            !_isGstVerified ||
                            !_agreed)
                        ? Colors.grey
                        : const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Checkbox and Agreement Text
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _agreed,
                      onChanged: (value) {
                        setState(() {
                          _agreed = value!;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'I agree, all information mentioned above is true and I authorize Credit Score to fetch my bureau data.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1, // Enquiry tab
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF5395FD), fontSize: 14),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    TextEditingController? controller,
    String? suffixText,
    Color? suffixColor,
    VoidCallback? onSuffixTap,
    IconData? suffixIcon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      height: 48,
      margin: const EdgeInsets.only(bottom: 5),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFF666666),
              width: 1.0,
            ), // Darker Grey
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Color(0xFF666666),
              width: 1.0,
            ), // Darker Grey
          ),
          suffixIcon: suffixText != null
              ? GestureDetector(
                  onTap: onSuffixTap,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      widthFactor: 1.0,
                      child: Text(
                        suffixText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: suffixColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              : (suffixIcon != null
                    ? Icon(suffixIcon, color: suffixColor)
                    : null),
        ),
      ),
    );
  }
}
