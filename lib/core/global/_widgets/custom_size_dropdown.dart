import 'package:flutter/material.dart';

import 'data/list_item.dart';

class CustomSizeDropdown extends StatefulWidget {
  CustomSizeDropdown({Key? key, this.onSelectItem}) : super(key: key);

  final Function(ListItem item)? onSelectItem;

  @override
  _CustomSizeDropdownState createState() => _CustomSizeDropdownState();
}

class _CustomSizeDropdownState extends State<CustomSizeDropdown> {
  List<ListItem> _dropdownItems = [
    ListItem(0, "Compact"),
    ListItem(1, "MidSize"),
    ListItem(2, "Sedan"),
    ListItem(3, "SmallSUV"),
    ListItem(3, "SUV"),
    ListItem(3, "SmallTruck"),
    ListItem(3, "FullSizeTruck"),
  ];

  List<DropdownMenuItem<ListItem>>? _dropdownMenuItems;
  ListItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems![0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = [];
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<ListItem>(
          value: _selectedItem,
          items: _dropdownMenuItems,
          onChanged: (value) {
            setState(() {
              _selectedItem = value;

              if (widget.onSelectItem != null) {
                widget.onSelectItem!(value!);
              }
            });
          }),
    );
  }
}
