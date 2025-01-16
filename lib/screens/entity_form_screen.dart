import 'package:flutter/material.dart';
import 'package:reminder/pages/entities_page.dart';
import 'package:reminder/resources/strings.dart';

class EntityFormScreen extends StatelessWidget {
  const EntityFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                Strings.addEntity,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.check,
                ),
                onPressed: () {
                  _showSaveDialog(context);
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            EntitiesFormPage(),
          ],
        ));
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar', textAlign: TextAlign.center),
          content: const Text('¿Desea agregar esta entidad?',
              textAlign: TextAlign.center),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Guardar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
