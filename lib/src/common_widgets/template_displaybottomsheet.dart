import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/features/controllers/radiobutton_controller.dart';
import 'package:flutter_firebaseapp/src/models/user.dart';

class DisplayButtomSheetComboboxTemplate extends StatelessWidget {
  final List<String> statuslist;
  final String? selectedvalue;
  final String userEmail;

  const DisplayButtomSheetComboboxTemplate({
    super.key,
    required this.statuslist,
    required this.selectedvalue,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    // String? selectedvalue_ = selectedvalue;
    return GestureDetector(
      onTap: () {
        displayBottomSheetComboboxTemplate(
          context,
          statuslist,
          selectedvalue,
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
      backgroundColor: Colors.white.withOpacity(0.9),
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
        child: ListView(
          children: [
            RadioButtonController(
              statuslist: statuslist,
              selectedvalue: selectedvalue,
              getselectedvalue: (getedvalue) {
                selectedvalue = getedvalue;
                // print(selectedvalue);
              },
            ),
            ButtonTemplate(
              buttonText: 'Submit Form',
              onPressed: () {
                User.updateUserStatus(
                  profileEmail: userEmail,
                  profileStatus: selectedvalue = selectedvalue ?? 'Candidate',
                );
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
