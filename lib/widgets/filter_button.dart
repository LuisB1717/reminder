import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';
import 'package:reminder/widgets/custom_filter.dart';

class FilterButton extends StatefulWidget {
  final String label;
  final bool isActive;
  final List filters;
  final void Function(List<String>) onSelected;
  final bool isMutipleSelect;

  const FilterButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.filters,
    required this.onSelected,
    this.isMutipleSelect = false,
  });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
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
                });
              },
              title: "Distritos",
              filters: widget.filters
                  .map((e) => FilterOption(id: e.id.toString(), name: e.name))
                  .toList(),
              selectedFilters: selectedFilters,
              isMultiSelect: widget.isMutipleSelect,
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: AppColors.border),
        ),
        backgroundColor:
            widget.isActive ? AppColors.cardColor : AppColors.background,
        foregroundColor: AppColors.font,
        iconColor: AppColors.font,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (selectedFilters.isEmpty)
            Text(widget.label)
          else if (selectedFilters.length > 1)
            Text('${widget.label} (${selectedFilters.length})')
          else if (selectedFilters.length == 1)
            Text(selectedFilters.first),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
          )
        ],
      ),
    );
  }
}
