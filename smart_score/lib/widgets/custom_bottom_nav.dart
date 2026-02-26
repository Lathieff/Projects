import 'package:flutter/material.dart';
import 'package:smart_score/enquiry/enquiry_personal.dart';
import 'package:smart_score/Homescreen/dashboard_screen.dart';
import 'package:smart_score/Homescreen/report_screen.dart';
import 'package:smart_score/Homescreen/transaction.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNav({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF14B8A6);
    const inactiveColor = Color(0xFF9E9E9E);

    return SafeArea(
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _item(
              context,
              "assets/icon/homeicon.png",
              "Home",
              0,
              activeColor,
              inactiveColor,
              const DashboardScreen(),
            ),
            _item(
              context,
              "assets/icon/enquirey.png",
              "Enquiry",
              1,
              activeColor,
              inactiveColor,
              const EnquiryPersonal(),
            ),
            _item(
              context,
              "assets/icon/report.png",
              "Reports",
              2,
              activeColor,
              inactiveColor,
              const ReportScreen(),
            ),
            _item(
              context,
              "assets/icon/transaction.png",
              "Transaction",
              3,
              activeColor,
              inactiveColor,
              const TransactionScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    BuildContext context,
    String imagePath,
    String label,
    int index,
    Color active,
    Color inactive,
    Widget screen,
  ) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (currentIndex == index) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 26,
            height: 26,
            color: isActive ? active : inactive,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isActive ? active : inactive,
            ),
          ),
        ],
      ),
    );
  }
}
