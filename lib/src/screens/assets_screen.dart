import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:flutter_firebaseapp/src/screens/assetsdialogadd_screen.dart';
import 'package:flutter_firebaseapp/src/screens/assetsdialogman_screen.dart';
import 'package:intl/intl.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  String? userEmail;
  String errMsg = '';
  List<Asset> assets = [];

  TextEditingController controller = TextEditingController();

  getAssets() {
    return Asset.readAssets_();
  }

  addassetlist(Asset asset) async {
    setState(() {
      assets.add(asset);
      assets.sort(
        (a, b) => a.assetType!.compareTo(b.assetType!),
      );
    });
    await Asset.addAssetCollection(
      assetType: asset.assetType!,
      userEmail: userEmail!,
    );
  }

  delassetlist(Asset asset) async {
    setState(
      () {
        assets.removeWhere((x) => x.assetType! == asset.assetType);
        assets.sort(
          (a, b) => a.assetType!.compareTo(b.assetType!),
        );
      },
    );
    await Asset.deleteDocById(asset.assetType!);
  }

  @override
  void initState() {
    //ambil seassionnya
    getReference().then(
      (data) {
        setState(
          () {
            userEmail = data['userEmail'];
          },
        );
      },
    );
//ambil database assetnya
    getAssets().then(
      (data) {
        setState(
          () {
            assets = data;
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: const Text(
          'Assets List',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      ),
      body: ListView(
        children: [
          for (var asset in assets) ...[
            Card(
              color: Colors.black,
              elevation: 5,
              shadowColor: Colors.black,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                  ),
                ),
                title: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textFormTemplate(
                          asset.assetType!,
                          true,
                          16,
                          Colors.amber,
                        ),
                        textFormTemplate(
                          'harga jual : ${NumberFormat.simpleCurrency(locale: 'id_ID').format(asset.sellingPrice!.toInt())}',
                          false,
                          14,
                          Colors.white54,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        assetsDialogManScreen(
                          context,
                          controller =
                              TextEditingController(text: asset.assetType),
                          userEmail!,
                          delassetlist,
                        );
                      },
                      icon: const Icon(
                        Icons.menu_outlined,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.amber,
        ),
        onPressed: () {
          assetsDialogAddScreen(
            context,
            addassetlist,
          );
        },
      ),
    );
  }
}
