import 'package:flutter/material.dart';
import 'package:farmer_app/theme/bg.dart';
import 'package:farmer_app/widgets/custom_bottom_nav.dart';
import 'irrigation_motor.dart';
import 'irrigation_schedule.dart';
import 'irrigation_history.dart';

class IrrigationPage extends StatefulWidget {
  const IrrigationPage({super.key});

  @override
  State<IrrigationPage> createState() => _IrrigationPageState();
}

class _IrrigationPageState extends State<IrrigationPage> {
  int _selectedIndex = 0;

  final List<String> _tabs = ["Add Motors", "Schedule", "History"];

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const AddMotorsView();
      case 1:
        return const IrrigationScheduleView();
      case 2:
        return const IrrigationHistoryView();
      default:
        return const AddMotorsView();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context); // Goes back to Home
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppBackground.mainGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2E7D32)),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              _selectedIndex == 1
                  ? "Irrigation Schedule"
                  : (_selectedIndex == 2 ? "Irrigation History" : "Irrigation"),
              style: const TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Custom Tab Bar
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      bool isSelected = _selectedIndex == index;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedIndex = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2E7D32)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              _tabs[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                // Sub View
                Expanded(child: _buildBody()),
              ],
            ),
          ),
          bottomNavigationBar: _selectedIndex == 0
              ? CustomBottomNavBar(
                  currentIndex: 2,
                  onTap: (index) {
                    if (index == 0) {
                      Navigator.pushReplacementNamed(context, "/home");
                    } else if (index == 1) {
                      Navigator.pushReplacementNamed(context, "/add_crop");
                    } else if (index == 3) {
                      Navigator.pushReplacementNamed(context, "/equipment");
                    } else if (index == 4) {
                      Navigator.pushReplacementNamed(context, "/my_land");
                    }
                  },
                )
              : null,
        ),
      ),
    );
  }
}
