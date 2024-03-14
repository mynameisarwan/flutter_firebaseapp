import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';

class Order {
  final String productType;
  final num orderQty;
  final num orderPrice;
  final String orderBy;
  final DateTime orderDate;
  final String orderStatus;
  String? orderId;

  Order({
    required this.productType,
    required this.orderQty,
    required this.orderBy,
    required this.orderDate,
    required this.orderStatus,
    required this.orderPrice,
    this.orderId,
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

  static Order fromQDS(QueryDocumentSnapshot<Map<String, dynamic>> qdsjson) =>
      Order(
        orderId: qdsjson.reference.id,
        productType: qdsjson.data()['ProductType'],
        orderQty: qdsjson.data()['OrderQty'],
        orderBy: qdsjson.data()['OrderBy'],
        orderDate: (qdsjson.data()['OrderDate'] as Timestamp).toDate(),
        orderStatus: qdsjson.data()['OrderStatus'],
        orderPrice: qdsjson.data()['OrderPrice'],
      );

  static Future<List<Order>?> readOrdersBy(String userName) async {
    var db = FirebaseFirestore.instance;

    final docUser = db.collection('Orders');

    final sel = await docUser
        .where(
          'OrderBy',
          isEqualTo: userName,
        )
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => Order.fromQDS(
                  e,
                ),
              )
              .toList(),
        );
    if (sel.isNotEmpty) {
      return sel;
    } else {
      return null;
    }
  }

  static Future<void> updateOrderStatus(
      String orderStatus, String docid) async {
    var db = FirebaseFirestore.instance;
    final docUser = db.collection('Orders').doc(docid);
    docUser.update({'OrderStatus': orderStatus});
  }

  static Future<List<Order>> readOrders() async {
    var db = FirebaseFirestore.instance;
    final docUser = db.collection('Orders');

    final sel = await docUser.get().then(
          (value) => value.docs
              .map(
                (e) => Order.fromQDS(
                  e,
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

  static Future<String> deleteDocById(String orderId) async {
    var db = FirebaseFirestore.instance;
    return await db.collection('Orders').doc(orderId).delete().then(
      (value) => 'the Data has been deleted',
      onError: (e) {
        return 'Error : ${e.toString()}';
      },
    );
  }
}
