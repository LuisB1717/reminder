import 'package:flutter/material.dart';

class ClearFilter extends StatelessWidget {
  final Function onClear;
  final bool isActive;

  const ClearFilter({
    super.key,
    required this.onClear,
    required this.isActive,
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
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
