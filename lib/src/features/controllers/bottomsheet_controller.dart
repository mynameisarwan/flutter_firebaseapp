import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetController extends GetxController {
  final BuildContext context;
  final List statuslist;
  final String selectedvalue;
  final Function(String?)? onchage;
  BottomSheetController({
    required this.context,
    required this.statuslist,
    required this.selectedvalue,
    required this.onchage,
  });
  final Rx<String> newValue = ''.obs;

  Future displayBottomSheetTemplate() {
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
        child: Column(
          children: [
            for (var status in statuslist) ...{
              RadioListTile<String>(
                title: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: status,
                groupValue: selectedvalue,
                onChanged: onchage,
              ),
              const SizedBox(
                height: 10,
              ),
            }
          ],
        ),
      ),
    );
  }
}
