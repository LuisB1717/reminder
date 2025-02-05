import 'package:flutter/material.dart';
import 'package:reminder/widgets/custom_filter.dart';

class FilterButton extends StatefulWidget {
  final String label;
  final List filters;
  final void Function(List<String>) onSelected;
  final bool isMutipleSelect;
  final Function? onClear;
  final List<String> initialSelected;
  final Function()? onChangedSelected;

  const FilterButton(
      {super.key,
      required this.label,
      required this.filters,
      required this.onSelected,
      this.isMutipleSelect = false,
      this.onClear,
      this.initialSelected = const [],
      this.onChangedSelected});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  List<String> selectedFilters = [];

  @override
  void didUpdateWidget(covariant FilterButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSelected != widget.initialSelected) {
      setState(() {
        selectedFilters = widget.initialSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = widget.filters
        .map((e) => FilterOption(id: e.id.toString(), name: e.name))
        .toList();
    final districtOption = options.where((e) => e.id == selectedFilters.first);
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomFilter(
              onClear: () {
                setState(() {
                  selectedFilters = [];
                });
                widget.onClear!();
              },
              onChanged: (id, value) {
                setState(() {
                  if (value == true) {
                    selectedFilters.add(id);
                  } else if (value == false) {
                    selectedFilters.remove(id);
                  } else if (value == null) {
                    selectedFilters = [id];
                  }

                  widget.onSelected(selectedFilters);
                  if (widget.onChangedSelected != null) {
                    widget.onChangedSelected!();
                  }
                });
              },
              title: widget.label,
              filters: options,
              selectedFilters: selectedFilters,
              isMultiSelect: widget.isMutipleSelect,
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: selectedFilters.isNotEmpty
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        foregroundColor: selectedFilters.isNotEmpty
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSecondary,
        iconColor: selectedFilters.isNotEmpty
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSecondary,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedFilters.isEmpty)
            Text(widget.label)
          else if (selectedFilters.length > 1)
            Text('${widget.label} (${selectedFilters.length})')
          else if (districtOption.isNotEmpty)
            Text(districtOption.first.name)
          else
            Text(widget.label),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
          )
        ],
      ),
    );
  }
}
