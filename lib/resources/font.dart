import 'package:flutter/widgets.dart';
import 'package:reminder/resources/colors.dart';

enum FontType { title, subtitle, description, adress, bar }

const _littleFont = 14.0;
const _regularFont = 16.0;
const _largeFont = 18.0;
const _extraFont = 20.0;

class Font extends StatelessWidget {
  const Font(
    this.content, [
    this.type,
    Key? key,
  ]) : super(key: key);

  final String content;
  final FontType? type;

  @override
  Widget build(BuildContext context) {
    final Map<FontType, TextStyle> styles = {
      FontType.title: TextStyle(
        color: AppColors.font,
        fontSize: _largeFont,
        fontWeight: FontWeight.bold,
      ),
      FontType.subtitle: TextStyle(
          color: AppColors.font,
          fontSize: _littleFont,
          fontWeight: FontWeight.w400),
      FontType.description: TextStyle(
        color: AppColors.font,
        fontSize: _regularFont,
      ),
      FontType.adress: TextStyle(
        color: AppColors.font,
        fontSize: _littleFont,
      ),
      FontType.bar: TextStyle(
        color: AppColors.font,
        fontSize: _extraFont,
        fontWeight: FontWeight.bold,
      ),
    };

    return Text(
      content,
      style: styles[type ?? FontType.description],
    );
  }
}
