import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';
import '/app_image.dart';

class ProfileBasicDetailsScreen extends StatefulWidget {
  const ProfileBasicDetailsScreen({super.key});

  @override
  State<ProfileBasicDetailsScreen> createState() =>
      _ProfileBasicDetailsScreenState();
}

class _ProfileBasicDetailsScreenState
    extends State<ProfileBasicDetailsScreen> {
  String name = "Harish";
  String email = "hariharansgs@app.in";
  String mobile = "+91 98765 43210";
  String address = "Coimbatore";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final langCode =
        context.watch<LanguageProvider>().locale.languageCode;

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    /// ✅ TRANSLATION FUNCTION (CORRECT)
    String t(String key) {
      switch (langCode) {
        case 'ta':
          return _ta[key] ?? _en[key] ?? key;
        case 'hi':
          return _hi[key] ?? _en[key] ?? key;
        default:
          return _en[key] ?? key;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E6FF2),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: sp(0.055)),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: h(0.12),
              decoration: const BoxDecoration(
                color: Color(0xFF2E6FF2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),

            Transform.translate(
              offset: Offset(0, -h(0.06)),
              child: Column(
                children: [
                  Container(
                    height: h(0.14),
                    width: h(0.14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 0.1),
                      image: const DecorationImage(
                        image: AssetImage(AppImage.profile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: h(0.015)),

                  /// NAME + KYC
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: sp(0.045),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: w(0.02)),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w(0.025),
                          vertical: h(0.005),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF089125),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                size: 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              t("kyc_verified"),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.008)),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        t("location"),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.03)),

                  /// BASIC DETAILS CARD
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: w(0.05)),
                    padding: EdgeInsets.all(w(0.045)),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F2F2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              t("basic_details"),
                              style: TextStyle(
                                fontSize: sp(0.04),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            InkWell(
                              onTap: () => _showEditDialog(context, t),
                              child: Row(
                                children: [
                                  Icon(Icons.edit_outlined,
                                      size: sp(0.05),
                                      color: Colors.black54),
                                  SizedBox(width: w(0.01)),
                                  Text(
                                    t("edit"),
                                    style: TextStyle(
                                      fontSize: sp(0.03),
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: h(0.02)),

                        _detailRow(t("name"), name, sp),
                        _detailRow(t("mail_id"), email, sp),
                        _detailRow(t("mobile_number"), mobile, sp),
                        _detailRow(t("address"), address, sp),
                      ],
                    ),
                  ),

                  SizedBox(height: h(0.06)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// EDIT DIALOG
  void _showEditDialog(
      BuildContext context, String Function(String) t) {
    final nameCtrl = TextEditingController(text: name);
    final emailCtrl = TextEditingController(text: email);
    final addressCtrl = TextEditingController(text: address);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t("edit_basic_details")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _editField(t("name"), nameCtrl),
            _editField(t("mail_id"), emailCtrl),
            _editField(t("address"), addressCtrl),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t("cancel")),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                name = nameCtrl.text;
                email = emailCtrl.text;
                address = addressCtrl.text;
              });
              Navigator.pop(context);
            },
            child: Text(t("save")),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
      String label, String value, double Function(double) sp) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                fontSize: sp(0.03),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(fontSize: sp(0.032)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

/* ================= LANGUAGE MAPS ================= */

const Map<String, String> _en = {
  "basic_details": "Basic Details",
  "edit": "Edit",
  "name": "Name",
  "mail_id": "Mail Id",
  "mobile_number": "Mobile Number",
  "address": "Address",
  "edit_basic_details": "Edit Basic Details",
  "cancel": "Cancel",
  "save": "Save",
  "kyc_verified": "KYC Verified",
  "location": "Chennai, Tamilnadu.",
};

const Map<String, String> _ta = {
  "basic_details": "அடிப்படை விவரங்கள்",
  "edit": "திருத்து",
  "name": "பெயர்",
  "mail_id": "மின்னஞ்சல்",
  "mobile_number": "மொபைல் எண்",
  "address": "முகவரி",
  "edit_basic_details": "அடிப்படை விவரங்களை திருத்து",
  "cancel": "ரத்து",
  "save": "சேமிக்க",
  "kyc_verified": "KYC உறுதி செய்யப்பட்டது",
  "location": "சென்னை, தமிழ்நாடு.",
};

const Map<String, String> _hi = {
  "basic_details": "मूल विवरण",
  "edit": "संपादित करें",
  "name": "नाम",
  "mail_id": "ईमेल",
  "mobile_number": "मोबाइल नंबर",
  "address": "पता",
  "edit_basic_details": "मूल विवरण संपादित करें",
  "cancel": "रद्द करें",
  "save": "सहेजें",
  "kyc_verified": "KYC सत्यापित",
  "location": "चेन्नई, तमिलनाडु।",
};
