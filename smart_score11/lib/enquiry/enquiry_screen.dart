import 'package:flutter/material.dart';
import '/enquiry/credit_score_screen.dart';
import '../../../widgets/custom_bottom_nav.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({super.key});

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  String enquiryType = 'Personal';
  bool isChecked = false;

  String? selectedBureau;
  String? selectedCategory;

  // ✅ CONTROLLERS (FIX)
  final TextEditingController dobController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController gstController = TextEditingController();

  DateTime? selectedDob;

  final List<String> creditBureaus = [
    'Experian',
    'CRIF',
    'TransUnion',
    'Equifax',
  ];

  final List<String> enquiryCategories = [
    'Home Loan',
    'Personal Loan',
    'Credit Card',
    'Business Loan',
    'Vehicle Loan',
  ];

  // 🔹 COMMON BORDER
  OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFF828080),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: _border(const Color(0xff1B2C61)),
      focusedBorder: _border(const Color(0xff1B2C61)),
      border: _border(const Color(0xff1B2C61)),
    );
  }

  // ================= DATE PICKER =================
  Future<void> _pickDob() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDob = picked;
        dobController.text =
            "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  // ================= SUBMIT =================
  void _submit() {
    if (selectedBureau == null ||
        selectedCategory == null ||
        dobController.text.isEmpty ||
        !isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreditScoreResultScreen()),
    );
  }

  @override
  void dispose() {
    dobController.dispose();
    panController.dispose();
    aadhaarController.dispose();
    gstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        leading: const SizedBox(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Enquiry',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Enquiry Form',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xff003186),
              ),
            ),

            _label('Full Name'),
            _textField('Enter Your Full Name'),

            _label('Mobile Number'),
            _textField(
              'Enter Your Mobile Number',
              keyboardType: TextInputType.phone,
            ),

            _label('Credit Score Provider'),
            _creditBureauDropdown(),

            _label('Enquiry Category'),
            _categoryDropdown(),

            _label('PAN Number'),
            _verifyField('Enter PAN Number', panController),

            if (enquiryType == 'Personal') ...[
              _label('Aadhaar Number'),
              _verifyField('Enter Aadhaar Number', aadhaarController),

              _label('Date of Birth'),
              _dateField(),
            ] else ...[
              _label('GST No'),
              _verifyField('Enter GST Number', gstController),
            ],

            _label('Address'),
            _textField('Enter Address here'),

            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _textField('City')),
                const SizedBox(width: 12),
                Expanded(child: _textField('State')),
              ],
            ),

            const SizedBox(height: 12),
            _textField('Pincode', keyboardType: TextInputType.number),

            const SizedBox(height: 24),

            // ✅ AGREEMENT CHECKBOX (BEFORE SUBMIT)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (v) => setState(() => isChecked = v!),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'I agree, all information mentioned above is true and I authorize Credit Score to fetch my bureau data.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ✅ SUBMIT BUTTON (LAST)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E6CFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }

  // ================= HELPERS =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xff2672F5),
        ),
      ),
    );
  }

  Widget _textField(
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      keyboardType: keyboardType,
      decoration: _inputDecoration(hint),
    );
  }

  Widget _verifyField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black, // ✅ THIS FIXES EVERYTHING
        fontWeight: FontWeight.w500,
      ),
      decoration: _inputDecoration('').copyWith(
        suffixIcon: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 12),
          child: const Text(
            'Verify',
            style: TextStyle(
              color: Color(0xff00AA5B),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateField() {
    return TextField(
      controller: dobController,
      readOnly: true,
      onTap: _pickDob,
      decoration: _inputDecoration(
        'Date of Birth',
      ).copyWith(suffixIcon: const Icon(Icons.calendar_today_outlined)),
    );
  }

  Widget _creditBureauDropdown() {
    return DropdownButtonFormField2<String>(
      value: selectedBureau,
      decoration: _inputDecoration('Select Credit Bureau'),
      items: creditBureaus
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  color: Color(0xff2672F5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (v) => setState(() => selectedBureau = v),
    );
  }

  Widget _categoryDropdown() {
    return DropdownButtonFormField2<String>(
      value: selectedCategory,
      decoration: _inputDecoration('Select Category'),
      items: enquiryCategories
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  color: Color(0xff2672F5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (v) => setState(() => selectedCategory = v),
    );
  }
}
