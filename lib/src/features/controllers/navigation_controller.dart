import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/screens/users_screen.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    Container(
      color: Colors.amber,
    ),
    const UsersScreen(),
    Container(
      color: Colors.teal,
    ),
    Container(
      color: Colors.deepPurpleAccent,
    )
  ];
}
