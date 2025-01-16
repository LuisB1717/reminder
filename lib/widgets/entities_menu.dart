import 'package:flutter/material.dart';

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
            color: Color.fromARGB(93, 17, 17, 17),
            iconSize: 20,
            onPressed: () {},
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.business_center_outlined),
            color: Color.fromARGB(93, 17, 17, 17),
            iconSize: 20,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
