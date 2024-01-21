import 'package:flutter_firebaseapp/src/screens/assets_screen.dart';
import 'package:flutter_firebaseapp/src/screens/orders_screen.dart';
import 'package:flutter_firebaseapp/src/screens/profile_screen.dart';
import 'package:flutter_firebaseapp/src/screens/users_screen.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const AssetsScreen(),
    const UsersScreen(),
    const OrdersScreen(),
    const UserProfile()
  ];
}
