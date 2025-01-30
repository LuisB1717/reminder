import 'package:flutter/material.dart';

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
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(25),
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          icons.length,
          (index) => _buildMenuItem(icons[index], index, context),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, int index, context) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? Theme.of(context).colorScheme.onSecondary
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon,
            size: 24,
            color: selectedIndex == index
                ? Theme.of(context).colorScheme.secondary.withAlpha(150)
                : Theme.of(context).colorScheme.onSecondary),
      ),
    );
  }
}
