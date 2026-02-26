import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/language_provider.dart';
import '../../../widgets/custom_bottom_nav.dart';
import '/app_image.dart';

class TransactionScreen extends StatefulWidget {
  final bool fromProfile;

  const TransactionScreen({
    super.key,
    this.fromProfile = false, // default = arrow hide
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  // ================= TRANSLATOR =================
  String _t(BuildContext context, String key) {
    final lang = context.watch<LanguageProvider>().locale.languageCode;
    switch (lang) {
      case 'ta':
        return _txnTa[key] ?? _txnEn[key] ?? key;
      case 'hi':
        return _txnHi[key] ?? _txnEn[key] ?? key;
      default:
        return _txnEn[key] ?? key;
    }
  }

  void _onAddMoneySuccess(String amount) {
    final double addedAmount = double.parse(amount);

    setState(() {
      walletBalance += addedAmount; // ✅ UPDATE BALANCE
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("₹${_t(context, "add_money")}"),
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
              Text(
                _t(context, "add_money_title"),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: amountCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: _t(context, "enter_amount"),
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
                  child: Text(_t(context, "proceed_pay")),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double walletBalance = 0;
  int selectedFilter = 0;
  DateTime? selectedDate; // ✅ only logic state

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    double h(double v) => size.height * v;
    double w(double v) => size.width * v;
    double sp(double v) => size.width * v;

    final double cardHeight = size.width.clamp(320.0, 420.0) * 0.45;

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        centerTitle: true,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          _t(context, "transaction"),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2E6FF2), Color(0xFF2BB673)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
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
          padding.bottom + h(0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        _t(context, "my_balance"),
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
                              _t(context, "SMART SCORE"),
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
                    "Used Credit : 1234\nAvailable Credit : 423",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: sp(0.03),
                      height: 1.4,
                    ),
                  ),

                  const Spacer(),

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
                          _t(context, "Add Money"),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.032,
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

            // ================= FILTER =================
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _filterChip(_t(context, "all"), 0, sp, w, h),
                  _filterChip(_t(context, "today"), 1, sp, w, h),
                  _filterChip(_t(context, "this_week"), 2, sp, w, h),
                  _filterChip(_t(context, "this_month"), 3, sp, w, h),
                  SizedBox(width: w(0.04)),
                ],
              ),
            ),

            SizedBox(height: h(0.025)),

            // ================= COUNTS =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    _t(context, "credit_txn"),
                    maxLines: 1, // ✅ prevent overflow
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: (MediaQuery.of(context).size.width * 0.04)
                          .clamp(14.0, 18.0),
                      color: Colors.black,
                    ),
                  ),
                ),

                // ✅ ONLY FUNCTIONAL CHANGE (NO UI CHANGE)
                InkWell(
                  onTap: _openCalendar,
                  child: Container(
                    height: sp(0.11),
                    width: sp(0.11),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAF2FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.calendar_month,
                      color: Colors.blue,
                      size: sp(0.055),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: h(0.015)),

            Row(
              children: [
                _countCard("16", "Today", sp, w),
                _weekCard("122", "This Week", sp, w),
              ],
            ),

            SizedBox(height: h(0.015)),

            _monthCard("253", "This Month", sp, w),

            SizedBox(height: h(0.03)),

            Text(
              "Recent Transactions",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: sp(0.04)),
            ),

            SizedBox(height: h(0.015)),

            _transactionItem(sp, w),
            _transactionItem(sp, w),
            _transactionItem(sp, w),
          ],
        ),
      ),

      bottomNavigationBar: const CustomBottomNav(currentIndex: 3),
    );
  }

  // ================= CALENDAR FUNCTION =================
  Future<void> _openCalendar() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // ================= HELPERS (UNCHANGED) =================

  Widget _filterChip(
    String text,
    int index,
    double Function(double) sp,
    double Function(double) w,
    double Function(double) h,
  ) {
    final isActive = selectedFilter == index;

    return Padding(
      padding: EdgeInsets.only(right: w(0.02)),
      child: InkWell(
        borderRadius: BorderRadius.circular(w(0.08)),
        onTap: () => setState(() => selectedFilter = index),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: w(0.045),
            vertical: h(0.010),
          ),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF004D40) : Colors.white,
            borderRadius: BorderRadius.circular(w(0.08)),
            border: Border.all(color: const Color(0xFF004D40), width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (index == 0) ...[
                Icon(
                  Icons.filter_list,
                  size: sp(0.035),
                  color: isActive ? Colors.white : const Color(0xFF004D40),
                ),
                SizedBox(width: w(0.015)),
              ],
              Text(
                text,
                style: TextStyle(
                  fontSize: sp(0.032),
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.white : const Color(0xFF004D40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _countCard(
    String count,
    String label,
    double Function(double) sp,
    double Function(double) w,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: w(0.02)),
        padding: EdgeInsets.symmetric(vertical: w(0.05)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w(0.035)),
          gradient: const LinearGradient(
            colors: [Color(0xFFF5F5F5), Color(0xFFD4D6FF)],
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: sp(0.055),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label, style: TextStyle(fontSize: sp(0.03))),
          ],
        ),
      ),
    );
  }

  Widget _weekCard(
    String count,
    String label,
    double Function(double) sp,
    double Function(double) w,
  ) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: w(0.02)),
        padding: EdgeInsets.symmetric(vertical: w(0.05)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w(0.035)),
          gradient: const LinearGradient(
            colors: [Color(0xFFF5F5F5), Color(0xFFD4FEFF)],
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: sp(0.055),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label, style: TextStyle(fontSize: sp(0.03))),
          ],
        ),
      ),
    );
  }

  Widget _monthCard(
    String count,
    String label,
    double Function(double) sp,
    double Function(double) w,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: w(0.05)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w(0.035)),
        gradient: const LinearGradient(
          colors: [Color(0xFFF5F5F5), Color(0xFFF4D4FF)],
        ),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(fontSize: sp(0.055), fontWeight: FontWeight.bold),
          ),
          Text(label, style: TextStyle(fontSize: sp(0.03))),
        ],
      ),
    );
  }

  Widget _transactionItem(
    double Function(double) sp,
    double Function(double) w,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: w(0.03)),
      padding: EdgeInsets.all(w(0.035)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(w(0.035)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 9,
            offset: const Offset(0, 6),
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
                "Credit Score Token",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: sp(0.035),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: w(0.03),
                  vertical: w(0.01),
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(149, 242, 157, 1),
                  borderRadius: BorderRadius.circular(w(0.035)),
                ),
                child: Text("Completed", style: TextStyle(fontSize: sp(0.025))),
              ),
            ],
          ),
          SizedBox(height: w(0.015)),
          Text("Date : 11/21/2025", style: TextStyle(fontSize: sp(0.03))),
          Text(
            "Transaction ID : PAY_20251208_001",
            style: TextStyle(fontSize: sp(0.03)),
          ),
          Text("Amount : 2500", style: TextStyle(fontSize: sp(0.03))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Payment Mode : UPI", style: TextStyle(fontSize: sp(0.03))),
              Text(
                "Credit Hit : -25",
                style: TextStyle(fontSize: sp(0.03), color: Colors.blue),
              ),
            ],
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

const Map<String, String> _txnEn = {
  "transaction": "Transaction",
  "my_balance": "My Balance",
  "add_money": "Add Money",
  "add_money_title": "Add Money",
  "enter_amount": "Enter amount",
  "proceed_pay": "Proceed to Pay",
  "amount_added": "added successfully",
  "invalid_amount": "Enter valid amount",
  "used_credit": "Used Credit",
  "available_credit": "Available Credit",
  "all": "All",
  "today": "Today",
  "this_week": "This Week",
  "this_month": "This Month",
  "credit_txn": "Credit Checks Transactions",
  "recent_txn": "Recent Transactions",
  "date": "Date",
  "transaction_id": "Transaction ID",
  "amount": "Amount",
  "payment_mode": "Payment Mode",
  "credit_hit": "Credit Hit",
  "SMART SCORE": "SMART SCORE",
};

const Map<String, String> _txnTa = {
  "transaction": "பரிவர்த்தனை",
  "my_balance": "என் இருப்பு",
  "add_money": "பணம் சேர்க்கவும்",
  "add_money_title": "பணம் சேர்க்கவும்",
  "enter_amount": "தொகையை உள்ளிடவும்",
  "proceed_pay": "கட்டணத்திற்கு தொடரவும்",
  "amount_added": "வெற்றிகரமாக சேர்க்கப்பட்டது",
  "invalid_amount": "சரியான தொகையை உள்ளிடவும்",
  "used_credit": "பயன்படுத்திய கிரெடிட்",
  "available_credit": "கிடைக்கும் கிரெடிட்",
  "all": "அனைத்தும்",
  "today": "இன்று",
  "this_week": "இந்த வாரம்",
  "this_month": "இந்த மாதம்",
  "credit_txn": "கிரெடிட் சரிபார்ப்பு பரிவர்த்தனைகள்",
  "recent_txn": "சமீபத்திய பரிவர்த்தனைகள்",
  "date": "தேதி",
  "transaction_id": "பரிவர்த்தனை ஐடி",
  "amount": "தொகை",
  "payment_mode": "கட்டண முறை",
  "credit_hit": "கிரெடிட் குறைவு",
  "SMART SCORE": "ஸ்மார்ட் ஸ்கோர்",
};

const Map<String, String> _txnHi = {
  "transaction": "लेनदेन",
  "my_balance": "मेरा बैलेंस",
  "add_money": "पैसे जोड़ें",
  "add_money_title": "पैसे जोड़ें",
  "enter_amount": "राशि दर्ज करें",
  "proceed_pay": "भुगतान जारी रखें",
  "amount_added": "सफलतापूर्वक जोड़ा गया",
  "invalid_amount": "मान्य राशि दर्ज करें",
  "used_credit": "उपयोग किया गया क्रेडिट",
  "available_credit": "उपलब्ध क्रेडिट",
  "all": "सभी",
  "today": "आज",
  "this_week": "इस सप्ताह",
  "this_month": "इस महीने",
  "credit_txn": "क्रेडिट जाँच लेनदेन",
  "recent_txn": "हाल की लेनदेन",
  "date": "तारीख",
  "transaction_id": "लेनदेन आईडी",
  "amount": "राशि",
  "payment_mode": "भुगतान माध्यम",
  "credit_hit": "क्रेडिट हिट",
  "SMART SCORE": "स्मार्ट स्कोर",
};
