import 'package:flutter/material.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';

class MyProfileBusinessScreen extends StatefulWidget {
  const MyProfileBusinessScreen({super.key});

  @override
  State<MyProfileBusinessScreen> createState() =>
      _MyProfileBusinessScreenState();
}

class _MyProfileBusinessScreenState extends State<MyProfileBusinessScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isBusiness = true;
  bool isConfirmed = false;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final panCtrl = TextEditingController();
  final gstCtrl = TextEditingController();

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    mobileCtrl.dispose();
    panCtrl.dispose();
    gstCtrl.dispose();
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
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              // ---------------- APP BAR ----------------
              Container(
                height: h(0.09),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: w(0.04)),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E6FF2), Color(0xFF22C55E)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: w(0.03)),
                    Text(
                      "My Profile",
                      style: TextStyle(
                        fontSize: sp(0.045),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------- BODY ----------------
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    w(0.06),
                    h(0.02),
                    w(0.06),
                    bottomInset + h(0.03),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------------- RADIO ----------------
                        Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: isBusiness,
                              onChanged: (_) =>
                                  setState(() => isBusiness = false),
                            ),
                            const Text("Personal"),
                            SizedBox(width: w(0.08)),
                            Radio<bool>(
                              value: true,
                              groupValue: isBusiness,
                              onChanged: (_) =>
                                  setState(() => isBusiness = true),
                            ),
                            const Text(
                              "Business",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),

                        SizedBox(height: h(0.02)),

                        Text(
                          "Company Information",
                          style: TextStyle(
                            fontSize: sp(0.04),
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: h(0.02)),

                        _label("Full Name"),
                        _input(nameCtrl, "Enter your full name"),

                        _label("Email Address"),
                        _input(
                          emailCtrl,
                          "Enter email address",
                          keyboard: TextInputType.emailAddress,
                        ),

                        _label("Mobile Number"),
                        _input(
                          mobileCtrl,
                          "Enter Mobile Number",
                          keyboard: TextInputType.number,
                          max: 10,
                        ),

                        _label("PAN Number"),
                        _inputWithButton(
                          controller: panCtrl,
                          hint: "Enter PAN Number",
                          buttonText: "Verify PAN",
                        ),

                        _label("GST Number"),
                        _inputWithButton(
                          controller: gstCtrl,
                          hint: "Enter GST Number",
                          buttonText: "Verify GST",
                        ),

                        SizedBox(height: h(0.03)),

                        // ---------------- CHECKBOX ----------------
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: isConfirmed,
                              onChanged: (v) =>
                                  setState(() => isConfirmed = v!),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  "I confirm that the provided Name, PAN & Aadhaar details are correct.",
                                  style: TextStyle(fontSize: sp(0.032)),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: h(0.04)),

                        // ---------------- SAVE BUTTON ----------------
                        SizedBox(
                          width: double.infinity,
                          height: h(0.065),
                          child: ElevatedButton(
                            onPressed: isConfirmed
                                ? () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DashboardScreen(),
                                        ),
                                      );
                                    }
                                  }
                                : null,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E6FF2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Save & Proceed",
                              style: TextStyle(
                                fontSize: sp(0.04),
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
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _input(
    TextEditingController ctrl,
    String hint, {
    TextInputType keyboard = TextInputType.text,
    int? max,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboard,
        maxLength: max,
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          helperText: " ", // ⭐ IMPORTANT FIX
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }

  Widget _inputWithButton({
    required TextEditingController controller,
    required String hint,
    required String buttonText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          helperText: " ", // ⭐ IMPORTANT FIX
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: Text(buttonText, style: const TextStyle(fontSize: 12)),
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }
}
