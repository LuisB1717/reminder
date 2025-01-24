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
  final List<String> selectedFilters;
  final void Function(String, bool?) onChanged;
  final Function() onClear;

  const CustomFilter({
    super.key,
    required this.filters,
    this.isMultiSelect = false,
    required this.selectedFilters,
    required this.title,
    required this.onChanged,
    required this.onClear,
  });

  @override
  CustomFilterState createState() => CustomFilterState();
}

class CustomFilterState extends State<CustomFilter> {
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
                        value: widget.selectedFilters.contains(filter.id),
                        onChanged: (bool? value) {
                          widget.onChanged(filter.id, value!);
                          setState(() {});
                        },
                      );
                    }
                    return RadioListTile(
                      title: Text(filter.name),
                      value: filter.id,
                      groupValue: widget.selectedFilters.isEmpty
                          ? null
                          : widget.selectedFilters.first,
                      onChanged: (String? value) {
                        if (value == null) return;
                        widget.onChanged(filter.id, null);
                        Navigator.of(context).pop([value]);
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
            widget.onClear();
            Navigator.of(context).pop();
          },
        ),
        if (widget.isMultiSelect && widget.filters.isNotEmpty)
          TextButton(
            child: Text('Aplicar'),
            onPressed: () {
              Navigator.of(context).pop(widget.selectedFilters);
            },
          ),
      ],
    );
  }
}
