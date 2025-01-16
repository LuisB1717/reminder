import 'package:flutter/material.dart';

class FormEntity extends StatefulWidget {
  const FormEntity({super.key});

  @override
  _FormEntityState createState() => _FormEntityState();
}

class _FormEntityState extends State<FormEntity> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  String? _distrito;
  String? _caserio;
  DateTime? _fechaSeleccionada;

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
              controller: _nombreController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: 'Nombre',
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.person_2),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: 'Teléfono',
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.phone_android),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un teléfono';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _direccionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: 'Dirección',
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una dirección';
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
                hintText: 'Seleccionar distrito',
                filled: true,
                fillColor: const Color(0xFFEFEFEF),
              ),
              items: ['Distrito 1', 'Distrito 2', 'Distrito 3']
                  .map((distrito) => DropdownMenuItem(
                        value: distrito,
                        child: Text(
                          distrito,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _distrito = value;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: 'Seleccionar caserío',
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
                  _caserio = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
                hintText: 'Fecha',
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
                    _fechaSeleccionada = pickedDate;
                  });
                }
              },
              controller: TextEditingController(
                text: _fechaSeleccionada != null
                    ? _fechaSeleccionada!.toLocal().toString().split(' ')[0]
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
