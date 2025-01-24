import 'package:flutter/material.dart';
import 'package:reminder/resources/colors.dart';
import 'package:reminder/widgets/custom_filter.dart';

class FilterButton extends StatefulWidget {
  final String label;

  final List filters;
  final void Function(List<String>) onSelected;
  final bool isMutipleSelect;

  const FilterButton({
    super.key,
    required this.label,
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
              filters: options,
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
        backgroundColor: selectedFilters.isNotEmpty
            ? AppColors.cardColor
            : AppColors.background,
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
            Text(districtOption.first.name),
          Icon(
            Icons.arrow_drop_down,
            size: 20,
          )
        ],
      ),
    );
  }
}
