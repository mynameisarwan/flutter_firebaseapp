import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/models/user.dart';
import 'package:flutter_firebaseapp/src/screens/navigation_screen.dart';
import 'package:flutter_firebaseapp/src/screens/profile_screen.dart';
// import 'package:flutter_firebaseapp/src/screens/profile_screen.dart';

class VerificationController extends StatelessWidget {
  const VerificationController({super.key, required this.userEmail});
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    Future<User?>? readUser() async {
      final docUser = db.collection('Users').doc(userEmail);

      final sel = await docUser.get();
      if (sel.exists) {
        // return null;
        return User.fromJason(sel.data()!);
      } else {
        return null;
      }
    }

    return FutureBuilder<User?>(
      future: readUser(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error.toString()}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          String status = user.profileStatus;
          return status == 'Candidate'
              ? ProfileScreen(
                  userEmail: userEmail,
                )
              : NavigationScreen(
                  userEmail: userEmail,
                );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
    // return ProfileScreen(userEmail: userEmail);
  }
}
