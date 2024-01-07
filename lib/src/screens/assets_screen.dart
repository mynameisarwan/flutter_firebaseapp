import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:flutter_firebaseapp/src/screens/assetsdialogadd_screen.dart';
import 'package:flutter_firebaseapp/src/screens/assetsdialogman_screen.dart';

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
        automaticallyImplyLeading: false,
        title: Text(
          'Assets $userEmail',
          style: const TextStyle(color: Colors.amber),
        ),
      ),
      body: ListView(
        children: [
          for (var asset in assets) ...[
            Card(
              color: Colors.black,
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
                    Text(
                      asset.assetType!,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                      ),
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
