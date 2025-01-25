import 'package:flutter/material.dart';
import 'package:reminder/api/district.dart';
import 'package:reminder/api/entity.dart';
import 'package:reminder/api/town.dart';
import 'package:reminder/core/district.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/core/town.dart';
import 'package:reminder/resources/colors.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/screens/entity_form_screen.dart';
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

  @override
  void initState() {
    super.initState();

    _loadEntities();
    _loadDistrics();
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
                color: AppColors.cardColor,
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
          child: Text(
            Strings.entities,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const SizedBox(width: 12),
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
                  onClear: () {
                    setState(() {
                      selectedDistrict = "";
                    });
                    _loadEntities();
                  },
                ),
                const SizedBox(width: 12),
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
                ),
              ],
            ),
          ),
          SearchField(
            controller: searchController,
            onChanged: _onSearchChanged,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: filteredEntities.isEmpty
                ? const Center(child: Text("No se encontraron entidades."))
                : ListView.builder(
                    itemCount: filteredEntities.length,
                    itemBuilder: (context, index) {
                      final entity = filteredEntities[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(entity.name),
                          subtitle: Text(entity.address),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
