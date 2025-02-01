import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final bool withBackground;
  final bool colored;
  final List<IconData> icons;

  const Menu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.withBackground = false,
    this.colored = false,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 14),
      height: 70,
      decoration: withBackground == false
          ? null
          : BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withAlpha(180),
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
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? colored == true
                  ? colorScheme.primary
                  : colorScheme.onSecondary
              : null,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 24,
          color: selectedIndex == index
              ? colorScheme.secondary
              : colorScheme.onSecondary,
        ),
      ),
    );
  }
}
