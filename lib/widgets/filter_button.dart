import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: AppColors.border),
        ),
        backgroundColor: isActive ? AppColors.cardColor : AppColors.background,
        foregroundColor: AppColors.font,
        iconColor: AppColors.font,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
          )
        ],
      ),
    );
  }
}
