import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.userEmail});
  final String userEmail;
  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    final controller = Get.put(NavigationController());
    return Scaffold(
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.shopping_basket_outlined,
                ),
                label: 'Assets'),
            NavigationDestination(
                icon: Icon(
                  Icons.people_alt_outlined,
                ),
                label: 'Reseller'),
            NavigationDestination(
                icon: Icon(
                  Icons.store_outlined,
                ),
                label: 'Transaction'),
            NavigationDestination(
                icon: Icon(
                  Icons.person_3_outlined,
                ),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
