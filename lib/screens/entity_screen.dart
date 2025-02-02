import 'package:flutter/material.dart';
import 'package:reminder/api/district.dart';
import 'package:reminder/api/entity.dart';
import 'package:reminder/api/event.dart';
import 'package:reminder/api/town.dart';
import 'package:reminder/core/district.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/core/town.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/screens/entity_form_screen.dart';
import 'package:reminder/widgets/clear_filter.dart';
import 'package:reminder/widgets/entity_card.dart';
import 'package:reminder/widgets/filter_button.dart';
import 'package:reminder/widgets/search_field.dart';

class EntityScreen extends StatefulWidget {
  const EntityScreen({super.key});

  @override
  State<EntityScreen> createState() => _EntityScreenState();
}

class _EntityScreenState extends State<EntityScreen> {
  TextEditingController searchController = TextEditingController();
  List<District> districts = [];
  List<Town> towns = [];
  String selectedDistrict = "";
  List<String> filtersTown = [];
  List<Entity> entities = [];
  List<Entity> filteredEntities = [];
  int totalEntities = 0;

  @override
  void initState() {
    super.initState();

    _loadEntities();
    _loadDistrics();
    _loadEntitiesCount();
  }

  void _loadEntitiesCount() async {
    final count = await getCountEntities();

    setState(() {
      totalEntities = count;
    });
  }

  void _loadTowns(String districtId) async {
    final fetchTowns = await getTowns(districtId);

    setState(() {
      towns = fetchTowns;
    });
  }

  void _loadEntities() async {
    final fetchedEntities = await getEntities(
      districtId: selectedDistrict.isNotEmpty ? selectedDistrict : null,
      townIds: filtersTown.isNotEmpty
          ? filtersTown.map((e) => int.parse(e)).toList()
          : null,
    );

    if (mounted) {
      setState(() {
        entities = fetchedEntities;
        filteredEntities = fetchedEntities;
      });
    }
  }

  void _loadDistrics() async {
    final fetchedDistricts = await getDistricts();

    setState(() {
      districts = fetchedDistricts;
    });
  }

  void _onSearchChanged(String value) {
    setState(() {
      if (value.isNotEmpty) {
        filteredEntities = entities
            .where((entity) =>
                entity.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      } else {
        filteredEntities = entities;
      }
    });
  }

  void _onDelete(Entity entity) async {
    try {
      await deleteEvent(entity.id!);
      await deleteEntity(entity);
      setState(() {
        filteredEntities.remove(entity);
        totalEntities--;
      });
    } catch (e) {
      if (!mounted) return;
    }
  }

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
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 24,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EntityFormScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                Strings.entities,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Row(
              children: [
                ClearFilter(
                  onClear: () => {
                    setState(() {
                      selectedDistrict = "";
                      filtersTown = [];
                      _loadEntities();
                      _loadTowns(selectedDistrict);
                    })
                  },
                  isActive:
                      selectedDistrict.isNotEmpty || filtersTown.isNotEmpty
                          ? true
                          : false,
                ),
                const SizedBox(width: 8.0),
                FilterButton(
                  onSelected: (selected) {
                    setState(() {
                      selectedDistrict = selected.first;
                      _loadTowns(selected.first);
                      filtersTown = [];
                      _loadEntities();
                    });
                  },
                  filters: districts,
                  label: Strings.district,
                  initialSelected:
                      selectedDistrict.isNotEmpty ? [selectedDistrict] : [],
                ),
                const SizedBox(width: 8.0),
                FilterButton(
                  onSelected: (selected) {
                    setState(() {
                      filtersTown = selected;
                      _loadEntities();
                    });
                  },
                  filters: towns,
                  label: Strings.town,
                  isMutipleSelect: true,
                  onClear: () {
                    setState(() {
                      filtersTown = [];
                    });
                    _loadEntities();
                  },
                  initialSelected: filtersTown.isNotEmpty ? filtersTown : [],
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SearchField(
            controller: searchController,
            onChanged: _onSearchChanged,
          ),
          const SizedBox(height: 15),
          Text(
            totalEntities > 0
                ? "Se están mostrando ${filteredEntities.length} de $totalEntities entidades"
                : "",
            style: TextStyle(color: Theme.of(context).colorScheme.surface),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: filteredEntities.isEmpty
                ? Center(
                    child: Text(
                    "No se encontraron entidades.",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.surface),
                  ))
                : ListView.builder(
                    itemCount: filteredEntities.length,
                    itemBuilder: (context, index) {
                      final entity = filteredEntities[index];
                      return EntityCard(
                        entity: entity,
                        onDelete: () {
                          showDialogDeleteEntity(
                            () => _onDelete(entity),
                            context,
                            entity,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

void showDialogDeleteEntity(
    VoidCallback onPressed, BuildContext context, Entity entity) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text(
        "Eliminar entidad",
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "¿Desea eliminar la entidad ${entity.name}?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
          fontSize: 16,
        ),
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    Strings.cancel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    Strings.delete,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () => {
                  onPressed(),
                  Navigator.pop(context),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${entity.name} fue eliminado exitosamente',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                          )),
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  )
                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}
