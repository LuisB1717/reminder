import 'package:flutter/material.dart';

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
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Color.fromARGB(239, 239, 239, 239),
              shape: BoxShape.circle,
            ),
            child: IconButton(
                iconSize: 24, onPressed: () {}, icon: Icon(Icons.add)),
          ),
        ],
        title: Text('Entidades'),
      ),
      body: Center(
        child: Text('Entidades'),
      ),
    );
  }
}
