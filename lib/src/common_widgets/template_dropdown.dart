import 'package:flutter/material.dart';

class DropDownTemplate extends StatefulWidget {
  const DropDownTemplate({
    super.key,
    required this.list,
    required this.dropdownValue,
    required this.controller,
  });
  final List<String> list;
  final String dropdownValue;
  final TextEditingController? controller;

  void initialstate() {}
  @override
  State<DropDownTemplate> createState() => _DropDownTemplateState();
}

class _DropDownTemplateState extends State<DropDownTemplate> {
  String? _currentItem;

  @override
  void initState() {
    super.initState();
    _currentItem = widget.dropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 10,
            color: Color(0x19000000),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          icon: const Icon(Icons.expand_circle_down_outlined),
          // controller: widget.controller,
          value: _currentItem,
          // textStyle: const TextStyle(color: Colors.white),
          // inputDecorationTheme: const InputDecorationTheme(
          //   iconColor: Colors.white,
          //   fillColor: Colors.white,
          // ),
          onChanged: (selectedItem) {
            // This is called when the user selects an item.
            setState(
              () {
                widget.controller?.text = selectedItem!;
                _currentItem = selectedItem!;
              },
            );
          },
          items: widget.list
              .map<DropdownMenuItem<String>>(
                (String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      // color: Colors.white,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
