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
import 'package:reminder/widgets/custom_filter.dart';
import 'package:reminder/widgets/filter_button.dart';

class EntityScreen extends StatefulWidget {
  const EntityScreen({super.key});

  @override
  State<EntityScreen> createState() => _EntityScreenState();
}

class _EntityScreenState extends State<EntityScreen> {
  List<District> districts = [];
  List<Town> towns = [];
  String selectedDistrict = "";
  List<String> filtersTown = [];
  List<Entity> entities = [];

  @override
  void initState() {
    super.initState();

    _loadEntities();
    _loadDistrics();
  }

  void _loadTowns(String districtId) async {
    final fetchTowns = await getTowns(districtId);
    if (mounted) {
      setState(() {
        towns = fetchTowns;
      });
    }
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
      });
    }
  }

  void _loadDistrics() async {
    final fetchedDistricts = await getDistricts();

    setState(() {
      districts = fetchedDistricts;
    });
  }

  void _onTownFilterDialog() {
    showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return CustomFilter(
          title: "Centros poblados",
          filters: towns
              .map((e) => FilterOption(id: e.id.toString(), name: e.name))
              .toList(),
          selectedFilters: filtersTown,
          isMultiSelect: true,
        );
      },
    ).then(
      (result) {
        if (result != null) {
          setState(() {
            filtersTown = result;
          });
        }
        _loadEntities();
      },
    );
  }

  void _onDistritctFilterDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return CustomFilter(
          title: "Distritos",
          filters: districts
              .map((e) => FilterOption(id: e.id.toString(), name: e.name))
              .toList(),
          selectedFilters: [selectedDistrict],
        );
      },
    ).then((result) {
      if (result != null) {
        setState(() {
          selectedDistrict = result;
        });
        _loadTowns(selectedDistrict);
        _loadEntities();
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
                  label: Strings.district,
                  isActive: selectedDistrict.isNotEmpty,
                  onPressed: _onDistritctFilterDialog,
                ),
                const SizedBox(width: 12),
                FilterButton(
                  label: Strings.town,
                  isActive: filtersTown.isNotEmpty,
                  onPressed: _onTownFilterDialog,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
