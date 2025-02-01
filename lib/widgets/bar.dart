import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  const Bar({
    super.key,
    required this.title,
    this.leftIcon,
    this.rightIcon,
  });

  final String title;
  final Widget? leftIcon;
  final dynamic rightIcon;

  static const double regular = 16.0;
  static const double extra = 20.0;
  static const double medium = 12.0;
  static const double none = 0.0;
  static const double tiny = 4.0;
  static const double largeFont = 18.0;
  static const double top = 60.0;

  Widget content(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          margin: const EdgeInsets.only(left: tiny),
          child: Text(
            title,
            style: TextStyle(
              fontSize: largeFont,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: extra),
        ),
      ],
    );
  }

  Widget get actions {
    if (rightIcon is List) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (final item in rightIcon)
            Container(
              margin: const EdgeInsets.only(left: regular),
              child: item,
            ),
        ],
      );
    }
    return rightIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: tiny,
        right: tiny,
        top: top,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: medium,
        vertical: tiny,
      ),
      child: Row(
        children: [
          if (leftIcon != null)
            Container(
              margin: const EdgeInsets.only(right: regular),
              child: leftIcon,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(none),
              child: content(context),
            ),
          ),
          if (rightIcon != null) Container(child: actions),
        ],
      ),
    );
  }
}
