import 'package:flutter/material.dart';
import 'package:reminder/api/district.dart';
import 'package:reminder/api/town.dart';
import 'package:reminder/core/district.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/core/town.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/widgets/filter_button.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class FormEntity extends StatefulWidget {
  final int type;
  final Function(Entity, Event) onChanged;

  const FormEntity({
    super.key,
    required this.type,
    required this.onChanged,
  });

  @override
  FormEntityState createState() => FormEntityState();
}

class FormEntityState extends State<FormEntity> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  List<District> districts = [];
  List<Town> towns = [];
  String selectedDistrict = "";
  String selectedTown = "";
  DateTime? _dateSelect;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('es_PE', null);
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

  void _onSave() {
    final uuid = Uuid();

    Entity entity = Entity(
      id: uuid.v4(),
      type: widget.type.toString(),
      name: _nameController.text,
      phone: _phoneController.text,
      address: _adressController.text,
      district: selectedDistrict,
      town: selectedTown.isEmpty ? null : selectedTown,
      date: _dateSelect ?? DateTime.now(),
    );

    Event event = Event(
      type: widget.type.toString(),
      date: _dateSelect ?? DateTime.now(),
      entityId: entity.id,
    );

    widget.onChanged(entity, event);
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
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: widget.type == 0 ? Strings.name : 'Razon social',
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                suffixIcon: Icon(
                  widget.type == 0 ? Icons.person : Icons.business,
                ),
              ),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
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
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                hintText: Strings.phone,
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                suffixIcon: Icon(Icons.phone_android),
              ),
              keyboardType: TextInputType.phone,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
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
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                hintText: Strings.address,
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertAdress;
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            FilterButton(
              onSelected: (selected) {
                setState(() {
                  selectedDistrict = selected.first;
                  _loadTowns(selected.first);
                });
              },
              filters: districts,
              label: Strings.district,
              onClear: () {
                setState(
                  () {
                    selectedDistrict = "";
                  },
                );
              },
            ),
            SizedBox(height: 10),
            FilterButton(
              onSelected: (selected) {
                setState(() {
                  selectedTown = selected.first;
                });
              },
              filters: towns,
              label: Strings.town,
              onClear: () {
                setState(
                  () {
                    selectedTown = "";
                  },
                );
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                hintText: Strings.date,
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                suffixIcon: Icon(Icons.calendar_month),
              ),
              readOnly: true,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
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
                    ? DateFormat("d 'de' MMMM 'del' y", 'es_PE')
                        .format(_dateSelect!)
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
