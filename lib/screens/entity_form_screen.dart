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
  final Entity? entityEdit;
  final String title;
  const EntityFormScreen({
    super.key,
    required this.title,
    this.entityEdit,
  });

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

    if (widget.entityEdit != null) {
      _selectedType = int.parse(widget.entityEdit!.type);
    }
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

  void _onEdit() async {
    try {
      await updateEntity(entity);
      await updateEvent(entity.id!, event.date, event.type!);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Error al editar la entidad',
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
            title: widget.title,
            leftIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            rightIcon: IconButton(
                icon: Icon(Icons.check,
                    color: _isCheckForm
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).hintColor),
                onPressed: () {
                  if (!_isCheckForm) return;

                  if (widget.entityEdit == null) {
                    _showSaveDialog(context, entity);
                  } else {
                    _showSaveDialog(context, entity, isNew: false);
                  }
                }),
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
                  entityToEdit: widget.entityEdit,
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

  void _showSaveDialog(
    BuildContext context,
    Entity entity, {
    bool isNew = true,
  }) {
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
            isNew ? Strings.queEnt : Strings.editEntity,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 16,
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: Text(
                      Strings.cancel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
                      isNew ? Strings.save : Strings.edit,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      isNew ? _onSave() : _onEdit();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              isNew ? Strings.successSave : Strings.successEdit,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              )),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
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
