import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '/OnboardingScreen/company_branch_details_screen.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends State<CompanyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final TextEditingController companyNameCtrl = TextEditingController();
  final TextEditingController gstCtrl = TextEditingController();
  final TextEditingController regIdCtrl = TextEditingController();
  final TextEditingController certificateCtrl = TextEditingController();
  final TextEditingController startDateCtrl = TextEditingController();
  final TextEditingController regDateCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();

  File? certificateFile;

  @override
  void dispose() {
    companyNameCtrl.dispose();
    gstCtrl.dispose();
    regIdCtrl.dispose();
    certificateCtrl.dispose();
    startDateCtrl.dispose();
    regDateCtrl.dispose();
    emailCtrl.dispose();
    mobileCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFromGallery() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        certificateFile = File(file.path);
        certificateCtrl.text = file.name;
      });
    }
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      controller.text =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
    }
  }

  bool _isValidGST(String gst) {
    return RegExp(
      r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$',
    ).hasMatch(gst);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "Registration",
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF1DB954), Color(0xFF2E6FF2)],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          w(0.05),
          h(0.03),
          w(0.05),
          bottomInset + h(0.04),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Company Information",
                style: TextStyle(
                  fontSize: sp(0.045),
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: h(0.025)),

              _label("Company Name"),
              _input(companyNameCtrl, "Enter your Company name"),
              SizedBox(height: h(0.015)),

              _label("Company GSTIN"),
              _input(
                gstCtrl,
                "Enter GST Number",
                helperText: "e.g. 22AAAAA0000A1Z5",
                capitalization: TextCapitalization.characters,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Z]')),
                  LengthLimitingTextInputFormatter(15),
                ],
                validator: (v) {
                  if (v == null || v.isEmpty) return "GSTIN is required";
                  if (!_isValidGST(v.toUpperCase())) {}
                  return null;
                },
              ),
              SizedBox(height: h(0.015)),

              _label("Company Registration ID"),
              _input(regIdCtrl, "Enter Company Registration ID"),
              SizedBox(height: h(0.015)),

              _label("Registration Certificate"),
              _filePickerRow(
                certificateCtrl,
                "Upload Document",
                validator: (v) =>
                    v == null || v.isEmpty ? "Document required" : null,
                onTap: _pickFromGallery,
              ),
              SizedBox(height: h(0.015)),

              _label("Company Starting Date"),
              _dateField(startDateCtrl, () => _pickDate(startDateCtrl)),
              SizedBox(height: h(0.015)),

              _label("Registration Date"),
              _dateField(regDateCtrl, () => _pickDate(regDateCtrl)),
              SizedBox(height: h(0.015)),

              _label("Email ID"),
              _input(
                emailCtrl,
                "Enter Mail id",
                helperText: "e.g. name@domain.com",
                keyboard: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Email is required";
                  if (!_isValidEmail(v)) {
                    return "Example: name@domain.com";
                  }
                  return null;
                },
              ),
              SizedBox(height: h(0.015)),

              _label("Mobile Number"),
              _input(
                mobileCtrl,
                "Enter Mobile Number",
                helperText: "e.g. 9876543210",
                keyboard: TextInputType.number,
                formatters: [LengthLimitingTextInputFormatter(10)],
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return "Mobile Number is required";
                  }
                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(v)) {
                    return "Example: 9876543210";
                  }
                  return null;
                },
              ),

              SizedBox(height: h(0.04)),

              SizedBox(
                width: double.infinity,
                height: h(0.065),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CompanyBranchDetailsScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E6FF2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Save & Next",
                    style: TextStyle(
                      fontSize: sp(0.045),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  // ================= HELPERS =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _input(
    TextEditingController controller,
    String hint, {
    String? helperText,
    bool readOnly = false,
    TextInputType keyboard = TextInputType.text,
    List<TextInputFormatter>? formatters,
    TextCapitalization capitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboard,
      inputFormatters: formatters,
      textCapitalization: capitalization,
      validator: validator ?? (v) => v == null || v.isEmpty ? "Required" : null,
      decoration: InputDecoration(
        hintText: hint,
        helperText: helperText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _dateField(TextEditingController controller, VoidCallback onTap) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: (v) => v == null || v.isEmpty ? "Date required" : null,
      decoration: InputDecoration(
        suffixIcon: const Icon(
          Icons.calendar_today,
          size: 20,
          color: Color(0xFF2672F5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _filePickerRow(
    TextEditingController ctrl,
    String buttonText, {
    String? Function(String?)? validator,
    VoidCallback? onTap,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: ctrl,
                readOnly: true,
                decoration: const InputDecoration(border: InputBorder.none),
                validator: validator,
              ),
            ),
          ),
          SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E6FF2),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
