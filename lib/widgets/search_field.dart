import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.circular(15.0),
        color: Theme.of(context).colorScheme.secondary,
      ),
      child: TextField(
        style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Buscar entidades',
          hintStyle: TextStyle(color: Theme.of(context).hintColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          prefixIcon:
              Icon(Icons.search, color: Theme.of(context).hintColor, size: 20),
        ),
      ),
    );
  }
}
