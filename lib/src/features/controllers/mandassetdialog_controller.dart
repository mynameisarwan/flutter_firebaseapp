import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:flutter_firebaseapp/src/screens/assettransaction_screen.dart';
// import 'package:flutter_firebaseapp/src/screens/navigation_screen.dart';

class ManAssetDialgoController extends StatelessWidget {
  final String asset;
  final String userEmail;
  final Function delassetlist;
  const ManAssetDialgoController({
    super.key,
    required this.asset,
    required this.userEmail,
    required this.delassetlist,
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
                        true,
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (states) {
                                  return states.contains(MaterialState.pressed)
                                      ? Colors.white
                                      : Colors.red;
                                },
                              ),
                            ),
                            onPressed: () {
                              if (context.mounted) {
                                delassetlist(Asset(
                                  assetType: controller.text,
                                  createdDate: DateTime.now(),
                                ));
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => NavigationScreen(
                                //       userEmail: userEmail,
                                //     ),
                                //   ),
                                // );
                              }
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
      },
    );
  }
}
