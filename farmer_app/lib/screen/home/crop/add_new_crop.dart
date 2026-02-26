import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';

class AddNewCropPage extends StatefulWidget {
  const AddNewCropPage({super.key});

  @override
  State<AddNewCropPage> createState() => _AddNewCropPageState();
}

class _AddNewCropPageState extends State<AddNewCropPage> {
  final TextEditingController _seedCostController = TextEditingController();
  final TextEditingController _fertilizerCostController =
      TextEditingController();
  final TextEditingController _labourCostController = TextEditingController();
  double _totalInvestment = 0.0;

  @override
  void initState() {
    super.initState();
    _seedCostController.addListener(_calculateTotal);
    _fertilizerCostController.addListener(_calculateTotal);
    _labourCostController.addListener(_calculateTotal);
  }

  void _calculateTotal() {
    final seed = double.tryParse(_seedCostController.text) ?? 0.0;
    final fertilizer = double.tryParse(_fertilizerCostController.text) ?? 0.0;
    final labour = double.tryParse(_labourCostController.text) ?? 0.0;
    setState(() {
      _totalInvestment = seed + fertilizer + labour;
    });
  }

  @override
  void dispose() {
    _seedCostController.dispose();
    _fertilizerCostController.dispose();
    _labourCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Add Crop",
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Crop Name"),
              _buildDropdownField(
                  "Enter Crop Name", ["Tomato", "Cotton", "Wheat"]),
              const SizedBox(height: 16),
              _buildLabel("Variety"),
              _buildTextField("Enter Crop Variety"),
              const SizedBox(height: 16),
              _buildLabel("Soil"),
              _buildTextField("Enter Soil Type"),
              const SizedBox(height: 16),
              _buildLabel("Field"),
              _buildDropdownField(
                  "Enter Field", ["Field A", "Field B", "Field C"]),
              const SizedBox(height: 16),
              _buildLabel("Acres"),
              _buildTextField("Enter Crop Acres"),
              const SizedBox(height: 16),
              _buildLabel("Sowing Date"),
              _buildTextField("dd-mm-yyyy",
                  suffixIcon: Icons.calendar_today_outlined),
              const SizedBox(height: 16),
              _buildLabel("Seed Cost"),
              _buildTextField("Enter Seed Cost",
                  controller: _seedCostController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildLabel("Fertilizer Cost"),
              _buildTextField("Enter Fertilizer Cost",
                  controller: _fertilizerCostController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 16),
              _buildLabel("Labour Cost"),
              _buildTextField("Enter Labour Cost",
                  controller: _labourCostController,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              // Total Investment Container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Investment",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      _totalInvestment.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _showSuccessDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/gif/double_tick.gif",
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.check_circle,
                        size: 100, color: Colors.green);
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Crop added",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
              const Text(
                "Successfully",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
        );
      },
    );

    // Auto-close after 3 seconds and go back to add_crop.dart
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final navigator = Navigator.of(context);
        navigator.pop(); // Close bottom sheet
        navigator.pop(); // Go back to AddCropPage
      }
    });
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint,
      {TextEditingController? controller,
      TextInputType? keyboardType,
      IconData? suffixIcon}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.green.shade400, size: 20)
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField(String hint, List<String> items) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(hint,
              style: const TextStyle(color: Colors.grey, fontSize: 13)),
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
        ),
      ),
    );
  }
}
