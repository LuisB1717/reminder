import 'package:flutter/material.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/api/district.dart';
import 'package:reminder/api/town.dart';
import 'package:reminder/core/district.dart';
import 'package:reminder/core/town.dart';
import 'package:reminder/widgets/custom_filter.dart';
import 'package:reminder/widgets/filter_button.dart';

class FormEntity extends StatefulWidget {
  final int type;
  final Function(Entity) onChanged;

  const FormEntity({
    super.key,
    required this.type,
    required this.onChanged,
  });

  @override
  _FormEntityState createState() => _FormEntityState();
}

class _FormEntityState extends State<FormEntity> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  List<District> districts = [];
  List<Town> towns = [];
  String selectedDistrict = "";
  List<String> filtersTown = [];
  DateTime? _dateSelect;

  @override
  void initState() {
    super.initState();

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

  void _loadDistrics() async {
    final fetchedDistricts = await getDistricts();

    setState(() {
      districts = fetchedDistricts;
    });
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
      }
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
        _loadTowns(selectedDistrict);
      },
    );
  }

  void _onSave() {
    Entity entity = Entity(
      id: '',
      name: _nameController.text,
      phone: _phoneController.text,
      address: _adressController.text,
      district: selectedDistrict,
      town: 0,
      date: _dateSelect ?? DateTime.now(),
    );
    widget.onChanged(entity);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              onChanged: (value) {
                _onSave();
              },
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: widget.type == 0 ? Strings.name : 'Razon social',
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(
                  widget.type == 0 ? Icons.person : Icons.business,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertName;
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                _onSave();
              },
              controller: _phoneController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: Strings.phone,
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.phone_android),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertPhone;
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              onChanged: (value) {
                _onSave();
              },
              controller: _adressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: Strings.address,
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertAdress;
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            FilterButton(
              label: Strings.district,
              isActive: selectedDistrict.isNotEmpty,
              onPressed: _onDistritctFilterDialog,
            ),
            SizedBox(height: 10),
            FilterButton(
              label: Strings.town,
              isActive: filtersTown.isNotEmpty,
              onPressed: _onTownFilterDialog,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: Strings.date,
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.calendar_month),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dateSelect = pickedDate;
                    _onSave();
                  });
                }
              },
              controller: TextEditingController(
                text: _dateSelect != null
                    ? _dateSelect!.toLocal().toString().split(' ')[0]
                    : '',
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
