import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';

class Menu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final bool hasBorder;
  final List<IconData> icons;

  const Menu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.hasBorder = false,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 14),
      height: 60,
      decoration: hasBorder == false
          ? null
          : BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          icons.length,
          (index) => _buildMenuItem(icons[index], index),
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
              selectedIndex == index ? AppColors.cardColor : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24, color: AppColors.iconButton),
      ),
    );
  }
}
