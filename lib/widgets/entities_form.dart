import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:reminder/api/district.dart';
import 'package:reminder/api/town.dart';
import 'package:reminder/core/district.dart';
import 'package:reminder/core/entity.dart';
import 'package:reminder/core/event.dart';
import 'package:reminder/core/town.dart';
import 'package:reminder/resources/strings.dart';
import 'package:reminder/widgets/filter_button.dart';
import 'package:uuid/uuid.dart';

class FormEntity extends StatefulWidget {
  final int type;
  final Function(Entity, Event, bool) onChanged;
  final Entity? entityToEdit;

  const FormEntity({
    super.key,
    required this.type,
    required this.onChanged,
    this.entityToEdit,
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

    if (widget.entityToEdit != null) {
      _nameController.text = widget.entityToEdit!.name;
      _phoneController.text = widget.entityToEdit!.phone!;
      _adressController.text = widget.entityToEdit!.address;
      _dateSelect = widget.entityToEdit!.date;
      selectedDistrict = widget.entityToEdit!.district!.id;

      _loadTowns(selectedDistrict);

      if (widget.entityToEdit!.town != null) {
        selectedTown = widget.entityToEdit!.town!.id.toString();
      }
    }
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

  DateTime adjustedEventDate(DateTime originalDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime adjustedDate =
        DateTime(today.year, originalDate.month, originalDate.day);

    if (adjustedDate.isBefore(today)) {
      adjustedDate =
          DateTime(today.year + 1, originalDate.month, originalDate.day);
    }

    return adjustedDate;
  }

  void _onSave() {
    bool checkForm = false;
    late String uuid = "";
    Town? town;

    if (selectedTown.isNotEmpty) {
      town = Town(id: int.parse(selectedTown));
    } else {
      town = null;
    }

    if (widget.entityToEdit != null) {
      uuid = widget.entityToEdit!.id!;
    } else {
      uuid = Uuid().v4();
    }

    DateTime adjustedDate = adjustedEventDate(_dateSelect ?? DateTime.now());

    Entity entity = Entity(
      id: uuid,
      type: widget.type.toString(),
      name: _nameController.text,
      phone: _phoneController.text,
      address: _adressController.text,
      district: District(id: selectedDistrict),
      town: town,
      date: _dateSelect ?? DateTime.now(),
    );

    Event event = Event(
      type: widget.type.toString(),
      date: adjustedDate,
      entity: entity,
    );

    if (entity.name.isNotEmpty &&
        entity.address.isNotEmpty &&
        entity.district!.id.isNotEmpty) {
      checkForm = true;
    } else {
      checkForm = false;
    }
    widget.onChanged(entity, event, checkForm);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(0.0),
          shrinkWrap: true,
          children: [
            TextFormField(
              onChanged: (value) {
                _onSave();
              },
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    15.0,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: widget.type == 0 ? Strings.name : 'Razon social',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                filled: true,
                fillColor: colorScheme.secondary,
                suffixIcon: Icon(
                  widget.type == 0 ? Icons.person : Icons.business,
                  color: colorScheme.onSecondary.withAlpha(150),
                ),
              ),
              style: TextStyle(color: colorScheme.onSecondary),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertName;
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) {
                _onSave();
              },
              controller: _phoneController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                hintText: Strings.phone,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                filled: true,
                fillColor: colorScheme.secondary,
                suffixIcon: Icon(
                  Icons.phone_android,
                  color: colorScheme.onSecondary.withAlpha(150),
                ),
              ),
              keyboardType: TextInputType.phone,
              style: TextStyle(color: colorScheme.onSecondary),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertPhone;
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) {
                _onSave();
              },
              controller: _adressController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                hintText: Strings.address,
                filled: true,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                fillColor: colorScheme.secondary,
                suffixIcon: Icon(
                  Icons.location_on_outlined,
                  color: colorScheme.onSecondary.withAlpha(150),
                ),
              ),
              style: TextStyle(color: colorScheme.onSecondary),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return Strings.advertAdress;
                }
                return null;
              },
            ),
            SizedBox(height: 12.0),
            FilterButton(
              onChangedSelected: () => _onSave(),
              onSelected: (selected) {
                setState(() {
                  selectedDistrict = selected.first;
                  _loadTowns(selected.first);
                  selectedTown = "";
                });
              },
              filters: districts,
              label: Strings.district,
              initialSelected:
                  selectedDistrict.isNotEmpty ? [selectedDistrict] : [],
            ),
            SizedBox(height: 8.0),
            FilterButton(
              onChangedSelected: () => _onSave(),
              onSelected: (selected) {
                setState(() {
                  selectedTown = selected.first;
                });
              },
              filters: towns,
              label: Strings.town,
              initialSelected: selectedTown.isNotEmpty ? [selectedTown] : [],
            ),
            SizedBox(height: 12.0),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 16.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                hintText: Strings.date,
                filled: true,
                fillColor: colorScheme.secondary,
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: colorScheme.onSecondary.withAlpha(150),
                ),
              ),
              readOnly: true,
              style: TextStyle(color: colorScheme.onSecondary),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2050),
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
