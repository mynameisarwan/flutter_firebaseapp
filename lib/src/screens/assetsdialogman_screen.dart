import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_dialogalert.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:flutter_firebaseapp/src/screens/asset_screen.dart';
import 'package:flutter_firebaseapp/src/screens/assettransaction_screen.dart';

final formKey = GlobalKey<FormState>();

Future<void> assetsDialogManScreen(
  BuildContext context,
  TextEditingController controller,
  String userEmail,
  Function delassetlist,
) {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, setState) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.black,
          title: const Text(
            'Asset',
            style: TextStyle(color: Colors.amber),
          ),
          content: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                textFieldTemplFormWithNotifTap(
                  controller,
                  'Input Assets',
                  Icons.data_saver_off,
                  TextInputType.none,
                  verification,
                  true,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => AssetScreen(
                          assetKey: controller.text,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                        iconColor: MaterialStateProperty.resolveWith(
                          (states) {
                            return states.contains(MaterialState.pressed)
                                ? Colors.green
                                : Colors.white;
                          },
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            return states.contains(MaterialState.pressed)
                                ? Colors.white
                                : Colors.green;
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssetTransactionScreen(
                                assetkey: controller.text,
                                userEmail: userEmail),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.shopping_basket_outlined,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const CircleBorder(),
                        ),
                        iconColor: MaterialStateProperty.resolveWith(
                          (states) {
                            return states.contains(MaterialState.pressed)
                                ? Colors.red
                                : Colors.white;
                          },
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                            return states.contains(MaterialState.pressed)
                                ? Colors.white
                                : Colors.red;
                          },
                        ),
                      ),
                      onPressed: () {
                        dialogConfBuilder(
                          context,
                          () {
                            delassetlist(
                              Asset(
                                assetType: controller.text,
                                createdDate: DateTime.now(),
                              ),
                            );
                            // Navigator.of(context, rootNavigator: true).pop();
                            var count = 0;
                            Navigator.of(context)
                                .popUntil((route) => count++ >= 2);
                          },
                        );
                        // delassetlist(
                        //   Asset(
                        //     assetType: controller.text,
                        //     createdDate: DateTime.now(),
                        //   ),
                        // );
                        // Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Icon(
                        Icons.delete_outline,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    ),
  );
}
