import 'package:flutter/material.dart';

class ClearFilter extends StatelessWidget {
  final Function onClear;
  final Color color;

  const ClearFilter({
    super.key,
    required this.onClear,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClear(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Icon(
          Icons.clear_all_outlined,
          color: color,
        ),
      ),
    );
  }
}
