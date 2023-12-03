// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';

class AlertDialogController extends StatefulWidget {
  final TextEditingController controller;
  final String? userEmail;
  const AlertDialogController({
    super.key,
    required this.controller,
    required this.userEmail,
  });

  @override
  State<AlertDialogController> createState() => _AlertDialogControllerState();
}

class _AlertDialogControllerState extends State<AlertDialogController> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: Colors.black,
      child: const Icon(
        Icons.add,
        color: Colors.amber,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            backgroundColor: Colors.black,
            title: const Text(
              'Asstest',
              style: TextStyle(color: Colors.amber),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  textFieldTemplFormWithNotif(
                    widget.controller,
                    'Input Assets',
                    Icons.data_saver_off,
                    TextInputType.text,
                    (value) {
                      var db = FirebaseFirestore.instance;
                      final asset = db.collection('Assets').doc(value);
                      asset.get().then(
                        (docsnapshot) {
                          if (docsnapshot.exists) {
                            return 'The Data Is Already Exist $docsnapshot';
                          }
                        },
                      );

                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Asset.addAssetCollection(
                            assetType: widget.controller.text,
                            userEmail: widget.userEmail!,
                          ).then((value) => print(value));
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Future openssetDialog(
  BuildContext context,
  TextEditingController controller,
  String userEmail,
) {
// String? getVerification(String? textboxvalue) {
//   var db = FirebaseFirestore.instance;
//   final asset = db.collection('Assets').doc(textboxvalue);
//   if (asset.path.isNotEmpty) {
//     return 'The Data Is Already Exist';
//   }
//   return '';
// }

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(10),
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
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
          ),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.amber),
            ),
            onPressed: () {
              Asset.addAssetCollection(
                assetType: controller.text,
                userEmail: userEmail,
              );
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
