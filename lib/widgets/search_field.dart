import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  const SearchField({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.border,
        ),
        borderRadius: BorderRadius.circular(17.0),
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Buscar entidades',
          hintStyle: TextStyle(color: AppColors.border),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
          prefixIcon: Icon(Icons.search, color: AppColors.iconButton, size: 20),
        ),
      ),
    );
  }
}
