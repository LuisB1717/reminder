import 'package:flutter/material.dart';
import 'package:reminder/resources/strings.dart';

class FormEntity extends StatefulWidget {
  const FormEntity({super.key});

  @override
  _FormEntityState createState() => _FormEntityState();
}

class _FormEntityState extends State<FormEntity> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adressController = TextEditingController();
  String? _district;
  String? _town;
  DateTime? _dateSelect;

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
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: Strings.name,
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.person_2),
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
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: Strings.selectDistrict,
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
              ),
              items: ['Distrito A', 'Distrito B', 'Distrito C']
                  .map((district) => DropdownMenuItem(
                        value: district,
                        child: Text(
                          district,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _district = value;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: Strings.selectTown,
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
              ),
              items: ['Caserío A', 'Caserío B', 'Caserío C']
                  .map(
                    (caserio) => DropdownMenuItem(
                      value: caserio,
                      child: Text(
                        caserio,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _town = value;
                });
              },
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
