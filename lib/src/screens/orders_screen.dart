import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/models/order.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: textFormTemplate(
          'Order List',
          true,
          18.0,
          Colors.amber,
        ),
      ),
      body: FutureBuilder(
        future: Order.readOrders(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasData) {
            var dorders = snapshot.data!;
            return ListView(
              children: [
                for (var order in dorders) ...{
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
                              Icons.shopping_bag_rounded,
                              color: Colors.white,
                            ),
                          ),
                          title: textFormTemplate(
                            order.productType,
                            true,
                            18,
                            Colors.amber,
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
                                      // print(order.orderId!);
                                      order.orderStatus == 'Request'
                                          ? Order.updateUserStatus(
                                              'Ready', order.orderId!)
                                          : null;
                                      setState(() {});
                                    },
                                    onDoubleTap: () {
                                      order.orderStatus == 'Ready'
                                          ? Order.updateUserStatus(
                                              'Request', order.orderId!)
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
                }
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
    );
  }
}
