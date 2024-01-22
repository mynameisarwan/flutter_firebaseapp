import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/order.dart';
import 'package:flutter_firebaseapp/src/screens/payment_screen.dart';

class PaymentHistoryScreen extends StatelessWidget {
  final Order ordermdl;
  const PaymentHistoryScreen({
    super.key,
    required this.ordermdl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 16,
          ),
        ),
        elevation: 5,
        title: textFormTemplate(
          'Payment ${ordermdl.productType}',
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
          Icons.wallet,
          color: Colors.amber,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(
                ordermdl: ordermdl,
              ),
            ),
          );
        },
      ),
    );
  }
}
