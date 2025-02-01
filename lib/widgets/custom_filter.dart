import 'package:flutter/material.dart';

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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        color: Theme.of(context).colorScheme.secondary.withAlpha(220),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            const SizedBox(height: 20),
            widget.filters.isEmpty
                ? Text(
                    "Este distrito no cuenta con centros poblados.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  )
                : Flexible(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: widget.filters.map((filter) {
                          if (widget.isMultiSelect) {
                            return CheckboxListTile(
                              title: Text(
                                filter.name,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              value: widget.selectedFilters.contains(filter.id),
                              onChanged: (bool? value) {
                                widget.onChanged(filter.id, value!);
                                setState(() {});
                              },
                            );
                          }
                          return RadioListTile(
                            title: Text(
                              filter.name,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                            ),
                            value: filter.id,
                            groupValue: widget.selectedFilters.isEmpty
                                ? null
                                : widget.selectedFilters.first,
                            onChanged: (String? value) {
                              if (value == null) return;
                              widget.onChanged(filter.id, null);
                              Navigator.of(context).pop([]);
                              setState(() {});
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(
                    widget.filters.isEmpty && widget.isMultiSelect
                        ? 'Aceptar'
                        : 'Confirmar',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
