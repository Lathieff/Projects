import 'package:flutter/material.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';

class CompanyBranchDetailsScreen extends StatefulWidget {
  const CompanyBranchDetailsScreen({super.key});

  @override
  State<CompanyBranchDetailsScreen> createState() =>
      _CompanyBranchDetailsScreenState();
}

class _CompanyBranchDetailsScreenState
    extends State<CompanyBranchDetailsScreen> {
  bool hasBranch = true;
  bool isConfirmed = false;

  final TextEditingController branchNameCtrl = TextEditingController();
  final TextEditingController companyLogoCtrl = TextEditingController();
  final TextEditingController companyPhotoCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();
  final TextEditingController registerPersonCtrl = TextEditingController();
  final TextEditingController companyPhoto2Ctrl = TextEditingController();

  @override
  void dispose() {
    branchNameCtrl.dispose();
    companyLogoCtrl.dispose();
    companyPhotoCtrl.dispose();
    addressCtrl.dispose();
    registerPersonCtrl.dispose();
    companyPhoto2Ctrl.dispose();
    super.dispose();
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

      // ---------------- APP BAR ----------------
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
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF1DB954), Color(0xFF2E6FF2)],
            ),
          ),
        ),
      ),

      // ---------------- BODY ----------------
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            w(0.05),
            h(0.03),
            w(0.05),
            bottomInset + h(0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Do you have a branch",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),

              SizedBox(height: h(0.01)),

              Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: hasBranch,
                    activeColor: const Color(0xFF2E6FF2),
                    onChanged: (v) => setState(() => hasBranch = v!),
                  ),
                  const Text("Yes"),
                  SizedBox(width: w(0.05)),
                  Radio<bool>(
                    value: false,
                    groupValue: hasBranch,
                    activeColor: const Color(0xFF2E6FF2),
                    onChanged: (v) => setState(() => hasBranch = v!),
                  ),
                  const Text("No"),
                ],
              ),

              if (hasBranch) ...[
                SizedBox(height: h(0.008)),
                const Text(
                  "if yes means specify the name of branch",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: h(0.01)),
                _input(branchNameCtrl, "Name of branch"),
              ],

              _label("Company Logo"),
              _filePickerRow(companyLogoCtrl, "Choose File"),

              _label("Company Photo"),
              _filePickerRow(companyPhotoCtrl, "Choose File"),

              _label("Company Address"),
              _multilineInput(addressCtrl, "Enter Company Address"),

              _label("Company Register Person Name"),
              _input(registerPersonCtrl, "Enter Company Registration ID"),

              _label("Company Photo"),
              _filePickerRow(companyPhoto2Ctrl, "Choose File"),

              SizedBox(height: h(0.012)),

              // ---------------- CONFIRM CHECKBOX ----------------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isConfirmed,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: const Color(0xFF2E6FF2),
                    onChanged: (v) => setState(() => isConfirmed = v!),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "I confirm that the provided Name & Aadhaar details are correct.",
                        style: TextStyle(
                          fontSize: sp(0.032),
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: h(0.03)),

              // ---------------- SUBMIT BUTTON ----------------
              SizedBox(
                width: double.infinity,
                height: h(0.065),
                child: ElevatedButton(
                  onPressed: isConfirmed
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E6FF2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Submit",
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

  // ---------------- HELPERS ----------------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _input(TextEditingController ctrl, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(
          hintText: hint,
          helperText: " ", // ⭐ FIX
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _multilineInput(TextEditingController ctrl, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: hint,
          helperText: " ", // ⭐ FIX
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _filePickerRow(TextEditingController ctrl, String buttonText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: ctrl,
              readOnly: true,
              decoration: InputDecoration(
                helperText: " ", // ⭐ FIX
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E6FF2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
