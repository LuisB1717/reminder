import 'package:flutter/material.dart';
import 'package:reminder/api/entity.dart';
import 'package:reminder/api/event.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/widgets/bar.dart';
import 'package:reminder/widgets/entities_form.dart';
import 'package:reminder/widgets/menu.dart';

class EntityFormScreen extends StatefulWidget {
  const EntityFormScreen({super.key});

  @override
  State<EntityFormScreen> createState() => _EntityFormScreenState();
}

class _EntityFormScreenState extends State<EntityFormScreen> {
  late Entity entity;
  late Event event;
  int _selectedType = 0;
  late PageController _pageFormController;

  @override
  void initState() {
    super.initState();
    _pageFormController = PageController();
  }

  @override
  void dispose() {
    _pageFormController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedType = index;
    });
    _pageFormController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSave() async {
    try {
      await createEntity(entity);
      await createEvent(event);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar la entidad: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Bar(
            title: Strings.addEntity,
            centered: true,
            leftIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            rightIcon: IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => _showSaveDialog(
                context,
                entity,
              ),
            ),
          ),
          Menu(
            selectedIndex: _selectedType,
            onItemTapped: _onItemTapped,
            icons: const [
              Icons.person_outlined,
              Icons.business_center_outlined,
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: PageView(
              controller: _pageFormController,
              onPageChanged: (index) => _onItemTapped(index),
              children: [
                FormEntity(
                  type: _selectedType,
                  onChanged: (entity, event) {
                    setState(() {
                      entity = entity;
                      event = event;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context, Entity entity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Strings.confirm, textAlign: TextAlign.center),
          content: const Text(Strings.queEnt, textAlign: TextAlign.center),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text(Strings.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text(Strings.save),
                    onPressed: () {
                      _onSave();
                      Navigator.pop(context);
                      Navigator.pop(context);
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
