import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/radiobutton_controller.dart';

class DisplayButtomSheetComboboxTemplate extends StatefulWidget {
  final List<String> statuslist;
  final String? selectedvalue;
  const DisplayButtomSheetComboboxTemplate({
    super.key,
    required this.statuslist,
    required this.selectedvalue,
  });

  @override
  State<DisplayButtomSheetComboboxTemplate> createState() =>
      _DisplayButtomSheetComboboxTemplateState();
}

class _DisplayButtomSheetComboboxTemplateState
    extends State<DisplayButtomSheetComboboxTemplate> {
  @override
  Widget build(BuildContext context) {
    String? selectedvalue_ = widget.selectedvalue;
    return GestureDetector(
      onTap: () {
        displayBottomSheetComboboxTemplate(
          context,
          widget.statuslist,
          selectedvalue_,
        );
      },
      child: const Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.white,
      ),
    );
  }

  Future displayBottomSheetComboboxTemplate(
    BuildContext context,
    List<String> statuslist,
    String? selectedvalue,
  ) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.fromLTRB(
          5,
          50,
          5,
          5,
        ),
        child: RadioButtonController(
          statuslist: statuslist,
          selectedvalue: selectedvalue,
          onchage: (val) {
            setState(() {
              selectedvalue = val;
            });
          },
        ),
      ),
    );
  }
}
