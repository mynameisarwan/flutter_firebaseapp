import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/navigation_controller.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  final String userEmail;
  final int scrIdx;
  const NavigationScreen(
      {super.key, required this.userEmail, required this.scrIdx});

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    final controller = Get.put(NavigationController());
    return Scaffold(
      body: Obx(
        // () => controller.screens[controller.selectedIndex.value],
        () {
          if (scrIdx == 0) {
            return controller.screens[controller.selectedIndex.value];
          } else {
            return controller.screens[scrIdx];
          }
        },
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
                label: 'Members'),
            NavigationDestination(
                icon: Icon(
                  Icons.store_outlined,
                ),
                label: 'Orders'),
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
