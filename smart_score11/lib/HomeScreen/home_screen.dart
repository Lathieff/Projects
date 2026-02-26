import 'package:flutter/material.dart';
import '../HomeScreen/profile_screen.dart';
import '/app_image.dart';
import '../../../widgets/custom_bottom_nav.dart';
import '../HomeScreen/notification_alert_screen.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onAddMoneySuccess(String amount) {
    final double addedAmount = double.parse(amount);

    setState(() {
      walletBalance += addedAmount; // ✅ UPDATE BALANCE
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("₹$amount added successfully"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showAddMoneySheet(BuildContext context) {
    final TextEditingController amountCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Money",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount",
                  prefixIcon: const Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickAmount(amountCtrl, 500),
                  _quickAmount(amountCtrl, 1000),
                  _quickAmount(amountCtrl, 2000),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final amount = amountCtrl.text.trim();

                    if (amount.isEmpty || double.tryParse(amount) == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter valid amount")),
                      );
                      return;
                    }

                    Navigator.pop(context); // ✅ close bottom sheet

                    // ✅ CALL SUCCESS METHOD
                    _onAddMoneySuccess(amount);
                  },
                  child: const Text("Proceed to Pay"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double walletBalance = 0;

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>().locale.languageCode;
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    final double cardHeight = size.width.clamp(320.0, 420.0) * 0.45;

            // 🔹 Local language resolver (NO app_strings.dart)
    String t(String key) {
      switch (lang) {
        case 'ta':
          return _ta[key] ?? key;
        case 'hi':
          return _hi[key] ?? key;
        default:
          return _en[key] ?? key;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h(0.95)),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: w(0.06)),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },

                  child: CircleAvatar(
                    radius: w(0.045),
                    backgroundImage: AssetImage(AppImage.profile),
                  ),
                ),
                SizedBox(width: w(0.03)),
                Image.asset(AppImage.company_logo, height: h(0.035)),
                const Spacer(),
                _circleIcon(Icons.search, w),
                SizedBox(width: w(0.03)),
                InkWell(
                  borderRadius: BorderRadius.circular(w(0.08)),
                  onTap: () {
                    // 👉 Your action here
                    // Example:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NotificationAlertScreen(),
                      ),
                    );
                  },
                  child: _circleIcon(Icons.notifications_none, w),
                ),
              ],
            ),
          ),
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          w(0.04),
          w(0.04),
          w(0.04),
          padding.bottom + h(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t("welcome"),
              style: TextStyle(
                fontSize: sp(0.050),
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(33, 72, 243, 1),
              ),
            ),
            SizedBox(height: h(0.005)),
            Text(t("agent_id"), style: TextStyle(fontSize: sp(0.04))),

            SizedBox(height: h(0.02)),

            // ================= BALANCE CARD =================
            Container(
              height: cardHeight,
              width: double.infinity,
              padding: EdgeInsets.all(w(0.020)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(w(0.04)),
                image: DecorationImage(
                  image: AssetImage(AppImage.vector),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        t("my_balance"),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: sp(0.032),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w(0.03),
                          vertical: h(0.004),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w(0.08)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.speed,
                              size: sp(0.035),
                              color: Colors.blue,
                            ),
                            SizedBox(width: w(0.01)),
                            Text(
                              t("smart_score"),
                              style: TextStyle(
                                fontSize: sp(0.025),
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h(0.02)),

                  Text(
                    "₹ ${walletBalance.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sp(0.065),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: h(0.01)),

                  Text(
                    t("Used Credit : 1234\nAvailable Credit : 423"),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: sp(0.03),
                      height: 1.4,
                    ),
                  ),

                  const Spacer(),

                  // ✅ ADD MONEY BUTTON (TAP EFFECT)
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(w(0.03)),
                      onTap: () {
                        _showAddMoneySheet(context);
                      },

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: w(0.045),
                          vertical: h(0.01),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(w(0.03)),
                        ),
                        child: Text(
                          "Add Money",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: sp(0.032),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: h(0.025)),

            // ================= DASHBOARD =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t("dashboard"),
                  style: TextStyle(
                    fontSize: sp(0.06),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      // TODO: handle selected date
                      print("Selected date: $picked");
                    }
                  },
                ),
              ],
            ),

            SizedBox(height: h(0.02)),

            // ================= ENQUIRY CARD =================
            Container(
              padding: EdgeInsets.all(w(0.04)),
              decoration: BoxDecoration(
                color: const Color(0xFF004D4D),
                borderRadius: BorderRadius.circular(w(0.04)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t("enquiry"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: h(0.02)),
                  Row(
                    children: [
                      _todayCard(w, h),
                      SizedBox(width: w(0.03)),
                      Expanded(
                        child: Column(
                          children: [
                            _smallCard("This Week", "122", "+60"),
                            SizedBox(height: h(0.015)),
                            _smallCard("This Month", "632", "+120"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: h(0.03)),

            // ================= MONTHLY ENQUIRY =================
            Text(
              t("monthly_enquiry"),
              style: TextStyle(fontSize: sp(0.06), fontWeight: FontWeight.bold),
            ),
            SizedBox(height: h(0.015)),
            Container(
              height: h(0.25),
              padding: EdgeInsets.all(w(0.04)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w(0.04)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bar("Jan", 80, h),
                  _bar("Feb", 120, h),
                  _bar("Mar", 100, h),
                  _bar("Apr", 160, h),
                  _bar("May", 140, h),
                  _bar("Jun", 90, h),
                ],
              ),
            ),

            SizedBox(height: h(0.03)),

            // ================= RECENT CREDITS =================
            Text(
              t("recent_credit"),
              style: TextStyle(
                fontSize: sp(0.060),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E2A5A),
              ),
            ),
            SizedBox(height: h(0.02)),
            _recentCreditCard(w, h),
            SizedBox(height: h(0.02)),
            _recentCreditCard(w, h),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 0),
    );
  }

  // ================= HELPERS =================

  Widget _circleIcon(IconData icon, double Function(double) w) {
    return Container(
      height: w(0.11),
      width: w(0.11),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFEAF2FF),
      ),
      child: Icon(icon, color: Colors.blue),
    );
  }

  Widget _todayCard(double Function(double) w, double Function(double) h) {
    return Container(
      width: w(0.38),
      height: h(0.16),
      padding: EdgeInsets.all(w(0.035)),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F7B8),
        borderRadius: BorderRadius.circular(w(0.035)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------- LEFT CONTENT --------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon (clipboard style placeholder)
                Container(
                  height: w(0.12),
                  width: w(0.12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    AppIcons.home_calander, // 👈 your image path constant
                    width: 28,
                    height: 28,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: h(0.015)),

                const Text(
                  "today",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E2A5A),
                  ),
                ),
              ],
            ),
          ),

          // -------- RIGHT CONTENT --------
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // ✅ ADD TOP SPACING HERE
              SizedBox(height: h(0.02)),

              // Count Circle
              Container(
                width: w(0.14),
                height: w(0.14),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "24",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2DB3),
                  ),
                ),
              ),

              SizedBox(height: h(0.02)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _smallCard(String title, String value, String inc) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F7B8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title)],
          ),
          _countCircle(value),
        ],
      ),
    );
  }

  Widget _countCircle(String value) {
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _bar(String label, double value, double Function(double) h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 14,
          height: h(value / 1000),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _recentCreditCard(
    double Function(double) w,
    double Function(double) h,
  ) {
    return Container(
      padding: EdgeInsets.all(w(0.04)),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FB),
        borderRadius: BorderRadius.circular(w(0.04)),
        border: Border.all(color: const Color(0xFFE0E6F1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: w(0.035),
                vertical: h(0.008),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFDFFFEA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.check_circle, size: 18, color: Colors.green),
                  SizedBox(width: 6),
                  Text(
                    "Verified",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: h(0.015)),
          _infoRow(Icons.person_outline, "Harish"),
          _infoRow(Icons.mail_outline, "harish123@gmail.com"),
          _infoRow(Icons.phone_android, "9876543210"),
          _infoRow(Icons.badge_outlined, "Type : Individual"),
          _infoRow(Icons.credit_score, "Credit Score : 720"),
          SizedBox(height: h(0.02)),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () => _showIndividualPopup(context),
              child:  Text(
              ("view_full_detail"),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E2A5A),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF1E2A5A)),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1E2A5A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ================= POPUP =================
  void _showIndividualPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Individual Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Complete information for selected individual",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0A58CA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  children: [
                    Text(
                      "Current Credit Score",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "700",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Good\n< -1 points",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _detail("Name", "Harish"),
              _detail("Email", "harish123@gmail.com"),
              _detail("Mobile No", "9876543210"),
              _detail("Address", "Coimbatore"),
              _detail("User Type", "Individual"),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _quickAmount(TextEditingController ctrl, int amount) {
  return OutlinedButton(
    onPressed: () => ctrl.text = amount.toString(),
    child: Text("₹$amount"),
  );
}
/* ================= HOME SCREEN LANGUAGE MAPS ================= */

// ---------- ENGLISH ----------
const Map<String, String> _en = {
  "welcome": "Welcome Smart",
  "agent_id": "Agent ID - S11522",

  "my_balance": "My Balance",
  "smart_score": "SMART SCORE",
  "used_credit": "Used Credit",
  "available_credit": "Available Credit",
  "add_money": "Add Money",

  "dashboard": "Dashboard",
  "enquiry": "Enquiry",
  "today": "Today",
  "this_week": "This Week",
  "this_month": "This Month",

  "monthly_enquiry": "Monthly Enquiry Volume",
  "recent_credit": "Recently Check Credits",

  "verified": "Verified",
  "view_full_detail": "View Full Detail >>",

  "individual_details": "Individual Details",
  "complete_info": "Complete information for selected individual",
  "current_credit_score": "Current Credit Score",
  "good": "Good",
  "close": "Close",

  "name": "Name",
  "email": "Email",
  "mobile": "Mobile No",
  "address": "Address",
  "user_type": "User Type",
  "individual": "Individual",
  "credit_score": "Credit Score",
};

// ---------- TAMIL ----------
const Map<String, String> _ta = {
  "welcome": "ஸ்மார்டுக்கு வரவேற்கிறோம்",
  "agent_id": "முகவர் ஐடி - S11522",

  "my_balance": "என் இருப்பு",
  "smart_score": "ஸ்மார்ட் ஸ்கோர்",
  "used_credit": "பயன்படுத்திய கடன்",
  "available_credit": "கிடைக்கும் கடன்",
  "add_money": "பணம் சேர்க்க",

  "dashboard": "டாஷ்போர்டு",
  "enquiry": "விசாரணை",
  "today": "இன்று",
  "this_week": "இந்த வாரம்",
  "this_month": "இந்த மாதம்",

  "monthly_enquiry": "மாதாந்திர விசாரணை அளவு",
  "recent_credit": "சமீபத்தில் சரிபார்க்கப்பட்ட கடன்கள்",

  "verified": "சரிபார்க்கப்பட்டது",
  "view_full_detail": "முழு விவரங்களை காண்க >>",

  "individual_details": "தனிநபர் விவரங்கள்",
  "complete_info": "தேர்ந்தெடுக்கப்பட்ட நபரின் முழு விவரங்கள்",
  "current_credit_score": "தற்போதைய கடன் மதிப்பெண்",
  "good": "நன்று",
  "close": "மூடு",

  "name": "பெயர்",
  "email": "மின்னஞ்சல்",
  "mobile": "மொபைல் எண்",
  "address": "முகவரி",
  "user_type": "பயனர் வகை",
  "individual": "தனிநபர்",
  "credit_score": "கடன் மதிப்பெண்",
};

// ---------- HINDI ----------
const Map<String, String> _hi = {
  "welcome": "स्मार्ट में आपका स्वागत है",
  "agent_id": "एजेंट आईडी - S11522",

  "my_balance": "मेरा बैलेंस",
  "smart_score": "स्मार्ट स्कोर",
  "used_credit": "उपयोग किया गया क्रेडिट",
  "available_credit": "उपलब्ध क्रेडिट",
  "add_money": "पैसे जोड़ें",

  "dashboard": "डैशबोर्ड",
  "enquiry": "जांच",
  "today": "आज",
  "this_week": "इस सप्ताह",
  "this_month": "इस महीने",

  "monthly_enquiry": "मासिक जांच मात्रा",
  "recent_credit": "हाल ही में जांचे गए क्रेडिट",

  "verified": "सत्यापित",
  "view_full_detail": "पूरा विवरण देखें >>",

  "individual_details": "व्यक्ति विवरण",
  "complete_info": "चयनित व्यक्ति की पूरी जानकारी",
  "current_credit_score": "वर्तमान क्रेडिट स्कोर",
  "good": "अच्छा",
  "close": "बंद करें",

  "name": "नाम",
  "email": "ईमेल",
  "mobile": "मोबाइल नंबर",
  "address": "पता",
  "user_type": "उपयोगकर्ता प्रकार",
  "individual": "व्यक्तिगत",
  "credit_score": "क्रेडिट स्कोर",
};
