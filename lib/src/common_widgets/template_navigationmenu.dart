import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_basket_outlined),
            label: 'Assets',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Reseller',
          ),
        ],
      ),
    );
  }
}
