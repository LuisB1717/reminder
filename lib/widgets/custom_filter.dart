import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';

class FilterOption {
  final String name;
  final String id;

  FilterOption({
    required this.name,
    required this.id,
  });
}

class CustomFilter extends StatefulWidget {
  final List<FilterOption> filters;
  final bool isMultiSelect;
  final String title;

  final List<String>? selectedFilters;

  const CustomFilter({
    super.key,
    required this.filters,
    this.isMultiSelect = false,
    this.selectedFilters,
    required this.title,
  });

  @override
  _CustomFilterState createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  List<String> selectedFilters = [];

  @override
  void initState() {
    super.initState();
    selectedFilters = widget.selectedFilters ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: (widget.isMultiSelect && widget.filters.isEmpty)
            ? Text("Este distrito no cuenta con centros poblados.")
            : ListBody(
                children: widget.filters.map(
                  (filter) {
                    if (widget.isMultiSelect) {
                      return CheckboxListTile(
                        title: Text(filter.name),
                        value: selectedFilters.contains(filter.id.toString()),
                        onChanged: (bool? value) {
                          setState(
                            () {
                              if (value == true) {
                                selectedFilters.add(filter.id.toString());
                              } else {
                                selectedFilters.remove(filter.id.toString());
                              }
                            },
                          );
                        },
                      );
                    }
                    return RadioListTile(
                      title: Text(filter.name),
                      value: filter.id,
                      groupValue:
                          selectedFilters.isEmpty ? null : selectedFilters[0],
                      onChanged: (String? value) {
                        setState(() {
                          selectedFilters = [value!];
                        });
                        Navigator.of(context).pop(value);
                      },
                    );
                  },
                ).toList(),
              ),
      ),
      actions: <Widget>[
        TextButton(
          child: widget.filters.isEmpty
              ? Text(
                  'Cerrar',
                  style: TextStyle(color: AppColors.font),
                )
              : Text('Limpiar'),
          onPressed: () {
            setState(() {
              selectedFilters = [];
            });
            Navigator.of(context).pop(selectedFilters);
          },
        ),
        if (widget.isMultiSelect && widget.filters.isNotEmpty)
          TextButton(
            child: Text('Aplicar'),
            onPressed: () {
              Navigator.of(context).pop(selectedFilters);
            },
          ),
      ],
    );
  }
}
