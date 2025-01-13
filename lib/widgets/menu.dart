import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const Menu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Color.fromARGB(93, 17, 17, 17), width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildMenuItem(Icons.home_outlined, 0),
            _buildMenuItem(Icons.person_outline, 1),
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
            color: selectedIndex == index
                ? const Color.fromARGB(239, 239, 239, 239)
                : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: Color.fromARGB(93, 17, 17, 17))),
    );
  }
}
