import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';

class EntitiesMenu extends StatelessWidget {
  const EntitiesMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.person),
            color: AppColors.iconButton,
            iconSize: 20,
            onPressed: () {},
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.business_center_outlined),
            color: AppColors.iconButton,
            iconSize: 20,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
