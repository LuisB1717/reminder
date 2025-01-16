import 'package:flutter/material.dart';
import 'package:reminder/widgets/entities_form.dart';
import 'package:reminder/widgets/entities_menu.dart';

class EntitiesFormPage extends StatelessWidget {
  const EntitiesFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EntitiesMenu(),
        FormEntity(),
      ],
    );
  }
}
