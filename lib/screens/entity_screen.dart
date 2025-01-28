import 'package:flutter/material.dart';
import 'package:reminder/api/district.dart';
import 'package:reminder/api/entity.dart';
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

    setState(() {
      entities = fetchedEntities;
      filteredEntities = fetchedEntities;
    });
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
                    MaterialPageRoute(builder: (context) => EntityFormScreen()),
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
                  color: selectedDistrict.isNotEmpty || filtersTown.isNotEmpty
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSecondary,
                ),
                const SizedBox(width: 8.0),
                FilterButton(
                  onSelected: (selected) {
                    setState(() {
                      selectedDistrict = selected.first;
                      _loadTowns(selected.first);
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
            "Se están mostrando ${filteredEntities.length} de ${totalEntities.toString()} entidades",
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: filteredEntities.isEmpty
                ? const Center(child: Text("No se encontraron entidades."))
                : ListView.builder(
                    itemCount: filteredEntities.length,
                    itemBuilder: (context, index) {
                      final entity = filteredEntities[index];
                      return EntityCard(entity: entity);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
