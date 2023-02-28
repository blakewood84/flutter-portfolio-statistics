import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:portfolio_statistics/extensions/format_key.dart';
import 'package:portfolio_statistics/home/state/portfolio_cubit.dart';

class AssetDropdown extends StatelessWidget {
  const AssetDropdown({Key? key}) : super(key: key);

  static final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filterMenu = context.read<PortfolioCubit>().state.filterMenu;
    final selectedFilter = context.watch<PortfolioCubit>().state.selectedFilter;

    return SizedBox(
      width: 100,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
          isExpanded: true,
          value: selectedFilter,
          items: filterMenu!.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Center(
                  child: Text(
                    e.formatKey,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          buttonStyleData: const ButtonStyleData(
            height: 40,
            width: 200,
          ),
          dropdownStyleData: const DropdownStyleData(
            maxHeight: 200,
            width: 100,
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: _textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: _textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value.toString().toLowerCase().contains(
                    searchValue.toLowerCase(),
                  );
            },
          ),
          onMenuStateChange: (isOpen) {
            if (!isOpen) _textEditingController.clear();
          },
          onChanged: (value) {
            if (value != null && value.isNotEmpty) {
              context.read<PortfolioCubit>().handleFilterChange(value);
            }
          },
        ),
      ),
    );
  }
}
