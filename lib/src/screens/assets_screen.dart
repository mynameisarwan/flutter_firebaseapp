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

  Future<List<Asset>> getReference() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('locData')) {
      final myData =
          json.decode(pref.getString('locData')!) as Map<String, dynamic>;

      userEmail = myData['userEmail'];
    }

    return await Asset.readAssets_();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder(
      future: getReference(),
      builder: (context, AsyncSnapshot<List<Asset>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        }
        if (snapshot.hasData) {
          final assets = snapshot.data!;
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
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            ),
            floatingActionButton: AddAssetDialogController(
              userEmail: userEmail,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
