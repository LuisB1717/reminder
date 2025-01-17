import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';

class EntitiesMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final BoxDecoration? decoration;

  const EntitiesMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 120,
        vertical: 12,
      ),
      child: Container(
        height: 60,
        decoration: decoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuItem(Icons.person_outline, 0),
            _buildMenuItem(Icons.business_outlined, 1),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color:
              selectedIndex == index ? AppColors.box : AppColors.transparency,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: AppColors.border,
        ),
      ),
    );
  }
}
