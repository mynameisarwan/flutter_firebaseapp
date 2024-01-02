import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/addassetdialog_controller.dart';
import 'package:flutter_firebaseapp/src/features/controllers/mandassetdialog_controller.dart';
import 'package:flutter_firebaseapp/src/models/asset.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  String? userEmail;
  String errMsg = '';
  List<Asset> assets = [];
  getReference() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('locData')) {
      return json.decode(pref.getString('locData')!) as Map<String, dynamic>;
    }
  }

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
                    ManAssetDialgoController(
                      asset: asset.assetType!,
                      userEmail: userEmail!,
                      delassetlist: delassetlist,
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
      floatingActionButton: AddAssetDialogController(
        userEmail: userEmail,
        addassetlist: addassetlist,
      ),
    );
  }
}
