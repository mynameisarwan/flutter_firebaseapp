import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/enums/enum_datalookup.dart';

class RadioButtonTempl extends StatelessWidget {
  final String title;
  final UserGenderEnum value;
  final UserGenderEnum? userGenderEnum;
  final Function(UserGenderEnum?)? onChanged;

  const RadioButtonTempl({
    super.key,
    required this.title,
    required this.value,
    required this.userGenderEnum,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(10),
            right: Radius.circular(10),
          ),
        ),
        child: RadioListTile<UserGenderEnum>(
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            value: value,
            groupValue: userGenderEnum,
            // tileColor: Colors.white,
            // activeColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(
              (states) {
                return Colors.white;
              },
            ),
            onChanged: onChanged),
      ),
    );
  }
}
