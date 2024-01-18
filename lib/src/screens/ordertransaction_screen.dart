import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/screens/order_screen.dart';

class OrderTransaction extends StatelessWidget {
  final String userEmail;
  const OrderTransaction({
    super.key,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: textFormTemplate(
          'Transaction History',
          true,
          18.0,
          Colors.amber,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 5,
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add_shopping_cart,
          color: Colors.amber,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderScreen(),
            ),
          );
        },
      ),
    );
  }
}
