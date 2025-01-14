import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';
import 'package:reminder/resources/strings.dart';

class EntityScreen extends StatefulWidget {
  const EntityScreen({super.key});

  @override
  State<EntityScreen> createState() => _EntityScreenState();
}

class _EntityScreenState extends State<EntityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 24,
                onPressed: () {},
                icon: Icon(Icons.add),
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Strings.entities,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Text('Entidades'),
      ),
    );
  }
}
