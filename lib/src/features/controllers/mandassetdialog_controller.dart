import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';

class ManAssetDialgoController extends StatelessWidget {
  final String asset;
  const ManAssetDialgoController({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String errMsg = '';
    TextEditingController controller = TextEditingController(text: asset);

    return GestureDetector(
      child: const Icon(
        Icons.menu_outlined,
        color: Colors.amber,
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                contentPadding: const EdgeInsets.all(10),
                backgroundColor: Colors.black,
                title: const Text(
                  'Asstest',
                  style: TextStyle(color: Colors.amber),
                ),
                content: Form(
                  key: formKey,
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
                        height: 20,
                      ),
                      textFormTemplate(
                        errMsg,
                        true,
                        12,
                        Colors.white,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
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
                        onPressed: () async {
                          String msg =
                              await Asset.deleteDocById(controller.text);
                          if (msg.contains('Error')) {
                            setState(
                              () {
                                errMsg = msg;
                              },
                            );
                          } else {
                            setState(() {});
                            if (context.mounted) {
                              // const AssetsScreen();
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                          }
                        },
                        child: const Icon(
                          Icons.delete_outline,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
