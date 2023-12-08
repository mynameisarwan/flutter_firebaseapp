import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/dialog_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  String? userEmail;
  String? testAja;
  Future<void> getReference() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey('locData')) {
      final myData =
          json.decode(pref.getString('locData')!) as Map<String, dynamic>;

      userEmail = myData['userEmail'];
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return FutureBuilder(
      future: getReference(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text(
            'Assets $userEmail',
            style: const TextStyle(color: Colors.amber),
          ),
        ),
        floatingActionButton: AlertDialogController(
          userEmail: userEmail,
        ),
      ),
    );
  }
}
