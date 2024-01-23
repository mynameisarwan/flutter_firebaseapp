import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/models/order.dart';
import 'package:flutter_firebaseapp/src/models/payment.dart';
import 'package:flutter_firebaseapp/src/screens/payment_screen.dart';
import 'package:intl/intl.dart';

class PaymentHistoryScreen extends StatefulWidget {
  final Order ordermdl;
  const PaymentHistoryScreen({
    super.key,
    required this.ordermdl,
  });

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  String? userRole;
  @override
  void initState() {
    getReference().then(
      (data) {
        setState(
          () {
            userRole = data['userRole'];
          },
        );
      },
    );
    super.initState();
  }

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
          'Payment ${widget.ordermdl.productType}',
          true,
          18.0,
          Colors.amber,
        ),
      ),
      body: FutureBuilder(
        future: Payment.readPaymentPerOrder(widget.ordermdl.orderId!),
        builder: (BuildContext context, AsyncSnapshot<List<Payment>> snapshot) {
          if (snapshot.hasData) {
            var payments = snapshot.data!;
            return ListView(children: [
              for (var data in payments) ...{
                Card(
                  color: Colors.black,
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Icon(
                            Icons.payments_rounded,
                            color: Colors.white,
                          ),
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Payment.updateStatus(
                                  widget.ordermdl.orderId!,
                                  data.paymentKey!,
                                  'Paid (Confirmed)',
                                );
                                setState(() {});
                              },
                              child: textFormTemplate(
                                data.paymentStatus,
                                true,
                                18,
                                Colors.amber,
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                if (userRole! == 'Reseller' &&
                                    data.paymentStatus == 'Paid') {
                                  Payment.deleteDocById(
                                    widget.ordermdl.orderId!,
                                    data.paymentKey!,
                                  );
                                }
                                setState(() {});
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: userRole! == 'Administrator' ||
                                        data.paymentStatus == 'Paid (Confirmed)'
                                    ? Colors.white30
                                    : Colors.red,
                                size: 14,
                              ),
                            )
                          ],
                        ),
                        subtitle: textFormTemplate(
                          '${data.paymentQty} botol',
                          false,
                          14,
                          Colors.white54,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textFormTemplate(
                                  'Total Pembayaran : ',
                                  false,
                                  14,
                                  Colors.white54,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textFormTemplate(
                                  NumberFormat.currency(locale: 'id_ID').format(
                                    data.paymentPrice,
                                  ),
                                  true,
                                  14,
                                  Colors.white70,
                                ),
                                textFormTemplate(
                                  DateFormat('dd MMMM yyyy')
                                      .format(data.paymentDate),
                                  false,
                                  14,
                                  Colors.white70,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              }
            ]);
          } else if (snapshot.hasError) {
            return textFormTemplate(
                'Error : ${snapshot.error.toString()}', true, 14, Colors.black);
          } else {
            return const CircularProgressIndicator();
          }
        },
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
                ordermdl: widget.ordermdl,
              ),
            ),
          );
        },
      ),
    );
  }
}
