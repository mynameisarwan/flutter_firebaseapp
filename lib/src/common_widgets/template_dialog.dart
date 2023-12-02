import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';

Future openDialog(
  BuildContext context,
  TextEditingController controller,
) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text(
          'Asstest',
          style: TextStyle(color: Colors.amber),
        ),
        content: textFieldTemplForm(
          controller,
          'Input the Asset',
          Icons.data_saver_off,
          TextInputType.text,
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.amber),
            ),
            onPressed: () {},
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
