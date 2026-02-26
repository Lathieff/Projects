import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class EquipmentBookingPage extends StatefulWidget {
  const EquipmentBookingPage({super.key});

  @override
  State<EquipmentBookingPage> createState() => _EquipmentBookingPageState();
}

class _EquipmentBookingPageState extends State<EquipmentBookingPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _selectedDuration;

  final List<String> _durations = [
    "2 Hours",
    "4 Hours",
    "6 Hours",
    "8 Hours",
    "Full Day"
  ];

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  void _showSuccessPopup() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/gif/equipment_booked.gif",
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              "Booking successful",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );

    // Automatically navigate back after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context); // Close bottom sheet
        Navigator.pop(context); // Go back to the previous screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    // Base design width for ratios
    double r(double val) => (val / 360) * width;

    // Get image from arguments
    final String imageUrl =
        ModalRoute.of(context)?.settings.arguments as String? ??
            "assets/equip/vechile_1.png";

    return Container(
      decoration: const BoxDecoration(
        gradient: AppBackground.mainGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: const Color(0xFF2E7D32), size: r(24)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Equipment Booking",
            style: TextStyle(
              color: const Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: r(20),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(r(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Equipment Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(r(20)),
                  child: Image.asset(
                    imageUrl,
                    height: r(200),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: r(24)),

                // Booking Date
                _buildLabel("Booking Date", r),
                SizedBox(height: r(8)),
                _buildTextField(
                  controller: _dateController,
                  hintText: "dd-mm-yyyy",
                  suffixIcon: Icons.calendar_today_outlined,
                  r: r,
                ),
                SizedBox(height: r(20)),

                // Start Time
                _buildLabel("Start Time", r),
                SizedBox(height: r(8)),
                _buildTextField(
                  controller: _timeController,
                  hintText: "Enter Time",
                  r: r,
                ),
                SizedBox(height: r(20)),

                // Duration
                _buildLabel("Duration(Hours)", r),
                SizedBox(height: r(8)),
                _buildDropdown(r),
                SizedBox(height: r(32)),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showSuccessPopup();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E7D32),
                          padding: EdgeInsets.symmetric(vertical: r(12)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(r(8))),
                        ),
                        child: Text(
                          "Confirm booking",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: r(14),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: r(16)),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2E7D32)),
                          padding: EdgeInsets.symmetric(vertical: r(12)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(r(8))),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: const Color(0xFF2E7D32),
                            fontWeight: FontWeight.bold,
                            fontSize: r(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text, double Function(double) r) {
    return Text(
      text,
      style: TextStyle(
        fontSize: r(14),
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    IconData? suffixIcon,
    required double Function(double) r,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(r(8)),
        border:
            Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.grey.withValues(alpha: 0.7), fontSize: r(14)),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: const Color(0xFF2E7D32), size: r(20))
              : null,
          contentPadding:
              EdgeInsets.symmetric(horizontal: r(16), vertical: r(12)),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdown(double Function(double) r) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r(16)),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(r(8)),
        border: Border.all(color: const Color(0xFF2E7D32).withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDuration,
          hint: Text("Enter Hours",
              style: TextStyle(
                  color: Colors.grey.withValues(alpha: 0.7), fontSize: r(14))),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down,
              color: const Color(0xFF2E7D32), size: r(24)),
          items: _durations.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: TextStyle(fontSize: r(14))),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedDuration = newValue;
            });
          },
        ),
      ),
    );
  }
}
