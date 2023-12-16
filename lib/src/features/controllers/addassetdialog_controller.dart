import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:flutter_firebaseapp/src/screens/navigation_screen.dart';

class AddAssetDialogController extends StatefulWidget {
  final String? userEmail;
  const AddAssetDialogController({
    super.key,
    required this.userEmail,
  });

  @override
  State<AddAssetDialogController> createState() =>
      _AddAssetDialogControllerState();
}

class _AddAssetDialogControllerState extends State<AddAssetDialogController> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  String errMsg = '';
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
          builder: (context) => StatefulBuilder(builder: (context, setstate) {
            return AlertDialog(
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
                      controller,
                      'Input Assets',
                      Icons.data_saver_off,
                      TextInputType.text,
                      verification,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    textFormTemplate(errMsg, true, 14, Colors.amber),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.amber),
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
                              await Asset.addAssetCollection(
                                assetType: controller.text,
                                userEmail: widget.userEmail!,
                              );
                              if (context.mounted) {
                                // const AssetsScreen();
                                // Navigator.of(context, rootNavigator: true)
                                //     .pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationScreen(
                                      userEmail: widget.userEmail!,
                                    ),
                                  ),
                                );
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
      },
    );
  }
}
