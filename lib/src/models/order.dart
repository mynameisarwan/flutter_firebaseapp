import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String productType;
  final num orderQty;
  final String orderBy;
  final DateTime orderDate;
  final String orderStatus;

  Order({
    required this.productType,
    required this.orderQty,
    required this.orderBy,
    required this.orderDate,
    required this.orderStatus,
  });

  Map<String, dynamic> toJason() => {
        'ProductType': productType,
        'OrderQty': orderQty,
        'OrderBy': orderBy,
        'OrderDate': orderDate,
        'OrderStatus': orderStatus
      };

  static Order fromJason(Map<String, dynamic> json) => Order(
        productType: json['ProductType'],
        orderQty: json['OrderQty'],
        orderBy: json['orderBy'],
        orderDate: json['orderDate'],
        orderStatus: json['orderStatus'],
      );

  static Future<Order> addOrder(Order data) async {
    var db = FirebaseFirestore.instance;
    final addOrder = db.collection('Order');
    addOrder.add(
      data.toJason(),
    );
    return data;
  }
}
