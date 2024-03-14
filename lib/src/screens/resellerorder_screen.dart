import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/order.dart';
import 'package:flutter_firebaseapp/src/screens/order_screen.dart';
import 'package:flutter_firebaseapp/src/screens/paymenthistory_screen.dart';
import 'package:flutter_firebaseapp/src/screens/profile_screen.dart';
import 'package:intl/intl.dart';

import '../features/controllers/reference_controller.dart';

class ResellerOrder extends StatefulWidget {
  // final String userEmail;
  const ResellerOrder({
    super.key,
    // required this.userEmail,
  });

  @override
  State<ResellerOrder> createState() => _ResellerOrderState();
}

class _ResellerOrderState extends State<ResellerOrder> {
  String userName = '';

  @override
  void initState() {
    getReference().then((data) {
      setState(
        () {
          userName = data['userName'];
        },
      );
    });

    // print('username init adalah $userName');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // initreference();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: textFormTemplate(
          'Order History',
          true,
          18.0,
          Colors.amber,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Colors.amber,
            ),
            tooltip: 'Open shopping cart',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserProfile()),
              ); // handle the press
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Order.readOrdersBy(userName),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Order>?> snapshot,
        ) {
          if (snapshot.hasData) {
            var dorders = snapshot.data!;
            return ListView(
              children: [
                for (var order in dorders) ...{
                  GestureDetector(
                    onTap: () {
                      order.orderStatus == 'Received'
                          ? Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    PaymentHistoryScreen(ordermdl: order),
                              ),
                            )
                          : null;
                    },
                    child: Card(
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
                                Icons.shopping_bag_rounded,
                                color: Colors.white,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textFormTemplate(
                                  order.productType,
                                  true,
                                  18,
                                  Colors.amber,
                                ),
                                GestureDetector(
                                  onLongPress: () {
                                    if (order.orderStatus == 'Request') {
                                      Order.deleteDocById(
                                        order.orderId!,
                                      );
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: order.orderStatus == 'Request'
                                        ? Colors.red
                                        : Colors.white.withOpacity(0.1),
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                            subtitle: textFormTemplate(
                              '${order.orderQty} Botol',
                              false,
                              14,
                              Colors.white54,
                            ),
                            isThreeLine: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textFormTemplate(
                                      'Total Belanja : ',
                                      false,
                                      14,
                                      Colors.white54,
                                    ),
                                    GestureDetector(
                                      child: textFormTemplate(
                                        order.orderStatus,
                                        true,
                                        14,
                                        Colors.white70,
                                      ),
                                      onLongPress: () {
                                        order.orderStatus == 'Delivered'
                                            ? Order.updateOrderStatus(
                                                'Received',
                                                order.orderId!,
                                              )
                                            : null;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textFormTemplate(
                                      NumberFormat.currency(locale: 'id_ID')
                                          .format(
                                        order.orderPrice * order.orderQty,
                                      ),
                                      true,
                                      14,
                                      Colors.white70,
                                    ),
                                    textFormTemplate(
                                      DateFormat('dd MMMM yyyy').format(
                                        order.orderDate,
                                      ),
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
                  ),
                },
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error : ${snapshot.error.toString()}');
          } else {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
        },
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
