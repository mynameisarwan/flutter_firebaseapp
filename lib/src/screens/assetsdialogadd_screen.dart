import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController controller = TextEditingController();
String errMsg = '';

Future<void> assetsDialogAddScreen(
  BuildContext context,
  Function addassetlist,
) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(10),
        backgroundColor: Colors.black,
        title: const Text(
          'Asstest',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              textFieldTemplFormWithNotif(
                controller,
                'Input Assets',
                Icons.data_saver_off,
                TextInputType.text,
                verification,
                false,
              ),
              const SizedBox(
                height: 12,
              ),
              textFormTemplate(
                errMsg,
                true,
                14,
                Colors.amber,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Colors.amber,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool? exist = await Asset.isExists(controller.text);
                      if (exist == true) {
                        setstate(
                          () {
                            errMsg = 'Assets is Exists';
                          },
                        );
                      } else {
                        if (context.mounted) {
                          addassetlist(
                            Asset(
                              assetType: controller.text,
                              createdDate: DateTime.now(),
                            ),
                          );
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      }
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
      );
    }),
  );
}
