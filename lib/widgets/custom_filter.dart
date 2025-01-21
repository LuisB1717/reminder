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
  final String? selectedFilter;
  final List<String>? selectedFilters;

  const CustomFilter({
    super.key,
    required this.filters,
    this.selectedFilter = '',
    this.isMultiSelect = false,
    this.selectedFilters,
  });

  @override
  _CustomFilterState createState() => _CustomFilterState();
}

class _CustomFilterState extends State<CustomFilter> {
  List<String> selectedFilters = [];
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = widget.selectedFilter ?? "";
    selectedFilters = widget.selectedFilters ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.isMultiSelect
          ? const Text('Centros poblados')
          : const Text('Distritos'),
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
                      groupValue: selectedFilter,
                      onChanged: (String? value) {
                        setState(() {
                          selectedFilter = value;
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
              if (widget.isMultiSelect) {
                selectedFilters = [];
              } else {
                selectedFilter = "";
              }
            });
            widget.isMultiSelect
                ? Navigator.of(context).pop(selectedFilters)
                : Navigator.of(context).pop(selectedFilter);
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
