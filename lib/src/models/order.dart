import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';

class Order {
  final String productType;
  final num orderQty;
  final num orderPrice;
  final String orderBy;
  final DateTime orderDate;
  final String orderStatus;

  Order({
    required this.productType,
    required this.orderQty,
    required this.orderBy,
    required this.orderDate,
    required this.orderStatus,
    required this.orderPrice,
  });

  Map<String, dynamic> toJason() => {
        'ProductType': productType,
        'OrderQty': orderQty,
        'OrderBy': orderBy,
        'OrderDate': orderDate,
        'OrderStatus': orderStatus,
        'OrderPrice': orderPrice
      };

  static Order fromJason(Map<String, dynamic> json) => Order(
        productType: json['ProductType'],
        orderQty: json['OrderQty'],
        orderBy: json['OrderBy'],
        orderDate: (json['OrderDate'] as Timestamp).toDate(),
        orderStatus: json['OrderStatus'],
        orderPrice: json['OrderPrice'],
      );

  static Future<List<Order>> readOrdersBy() async {
    String userName = '';
    var db = FirebaseFirestore.instance;
    final docUser = db.collection('Orders');

    userName = await getReference().then(
      (data) => data['userName'],
    );

    final sel = await docUser.where('OrderBy', isEqualTo: userName).get().then(
          (value) => value.docs
              .map(
                (e) => Order.fromJason(
                  e.data(),
                ),
              )
              .toList(),
        );
    return sel;
  }

  static Future<List<Order>> readOrders() async {
    var db = FirebaseFirestore.instance;
    final docUser = db.collection('Orders');

    final sel = await docUser.get().then(
          (value) => value.docs
              .map(
                (e) => Order.fromJason(
                  e.data(),
                ),
              )
              .toList(),
        );
    return sel;
  }

  static Future<Order> addOrder(Order data) async {
    var db = FirebaseFirestore.instance;
    final addOrder = db.collection('Orders');
    addOrder.add(
      data.toJason(),
    );
    return data;
  }
}
