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
  bool _isCheckForm = false;

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
          content: Center(
            child: Text(
              'Error al guardar la entidad',
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
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
            leftIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            rightIcon: IconButton(
              icon: Icon(Icons.check,
                  color: _isCheckForm
                      ? Theme.of(context).colorScheme.onSecondary
                      : Theme.of(context).hintColor),
              onPressed:
                  _isCheckForm ? () => _showSaveDialog(context, entity) : null,
            ),
          ),
          const SizedBox(height: 12),
          Menu(
            selectedIndex: _selectedType,
            onItemTapped: _onItemTapped,
            icons: const [
              Icons.person_outlined,
              Icons.business_center_outlined,
            ],
            colored: true,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: PageView(
              controller: _pageFormController,
              onPageChanged: (index) => _onItemTapped(index),
              children: [
                FormEntity(
                  type: _selectedType,
                  onChanged: (payloadEntity, payloadEvent, check) {
                    setState(() {
                      entity = payloadEntity;
                      event = payloadEvent;
                      _isCheckForm = check;
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
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            Strings.confirm,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          content: Text(
            Strings.queEnt,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      Strings.cancel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary),
                    child: Text(
                      Strings.save,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
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
