import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final navHeight = width * (70 / 360);

    return Container(
      height: navHeight,
      decoration: const BoxDecoration(
        color: Color(0xFF2E7D32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            index: 0,
            icon: Mdi.home_outline,
            activeIcon: Mdi.home,
            label: "Home",
            width: width,
            isHome: true,
          ),
          _buildNavItem(
            index: 1,
            icon: Mdi.sprout_outline,
            activeIcon: Mdi.sprout,
            label: "My Crop",
            width: width,
          ),
          _buildNavItem(
            index: 2,
            icon: Mdi.water_outline,
            activeIcon: Mdi.water,
            label: "Irrigation",
            width: width,
          ),
          _buildNavItem(
            index: 3,
            icon: Mdi.tractor,
            activeIcon: Mdi.tractor,
            label: "Equipment",
            width: width,
          ),
          _buildNavItem(
            index: 4,
            icon: Mdi.layers_outline,
            activeIcon: Mdi.layers,
            label: "My Land",
            width: width,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String activeIcon,
    required String label,
    required double width,
    bool isHome = false,
  }) {
    bool isActive = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isHome && isActive)
              Container(
                padding: EdgeInsets.all(width * (4 / 360)),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Iconify(
                  activeIcon,
                  size: width * (24 / 360),
                  color: const Color(0xFF2E7D32),
                ),
              )
            else
              Iconify(
                isActive ? activeIcon : icon,
                size: width * (24 / 360),
                color: isActive ? Colors.white : Colors.white60,
              ),
            SizedBox(height: width * (4 / 360)),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white60,
                fontSize: width * (10 / 360),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
