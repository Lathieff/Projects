import 'package:flutter/material.dart';
import 'package:truemotor/screens/compare%20vechiles/compare_home.dart';
import 'package:truemotor/screens/home/home_screen.dart';
import 'package:truemotor/screens/sell/sell_home.dart';
import 'package:truemotor/screens/used/used_vechile.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    super.key,
    this.currentIndex = 0,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    final items = <_BottomItemData>[
      const _BottomItemData('Home', 'assets/icons/bottom/home_logo.png'),
      const _BottomItemData('Buy', 'assets/icons/bottom/buy_logo.png'),
      const _BottomItemData('Sell', 'assets/icons/bottom/sell_logo.png'),
      const _BottomItemData('Compare', 'assets/icons/bottom/compare_logo.png'),
    ];

    return Container(
      height: w * 0.185,
      color: const Color(0xFF006D73),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = currentIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => _handleTap(context, index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item.iconPath,
                    width: w * 0.055,
                    height: w * 0.056,
                    errorBuilder: (_, _, _) => Icon(
                      _fallbackIcon(index),
                      color: Colors.white,
                      size: w * 0.06,
                    ),
                  ),
                  SizedBox(height: w * 0.01),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.white70,
                      fontSize: w * 0.042,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: w * 0.01),
                  Container(
                    height: w * 0.008,
                    width: double.infinity,
                    color: isActive ? Colors.white : Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  IconData _fallbackIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_outlined;
      case 1:
        return Icons.shopping_cart_outlined;
      case 2:
        return Icons.sell_outlined;
      default:
        return Icons.compare_arrows_outlined;
    }
  }

  void _handleTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const UsedVehicleScreen()),
          (route) => false,
        );
        break;
      case 3:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const CompareVehicleScreen()),
          (route) => false,
        );
        break;
      case 2:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const SellHomeScreen()),
          (route) => false,
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This section will be available soon.')),
        );
        break;
    }
  }
}

class _BottomItemData {
  const _BottomItemData(this.label, this.iconPath);

  final String label;
  final String iconPath;
}