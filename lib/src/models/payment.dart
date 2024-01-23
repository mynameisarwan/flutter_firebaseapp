// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final num paymentQty;
  final DateTime paymentDate;
  final num paymentPrice;
  final String paymentStatus;
  String? paymentKey;

  Payment(
      {required this.paymentQty,
      required this.paymentDate,
      required this.paymentPrice,
      required this.paymentStatus,
      this.paymentKey});

  Map<String, dynamic> toJason() => {
        'PaymentDate': paymentDate,
        'PaymentQty': paymentQty,
        'PaymentPrice': paymentPrice,
        'PaymentStatus': paymentStatus,
      };

  static Payment fromJason(Map<String, dynamic> json) => Payment(
        paymentQty: json['PaymentQty'],
        paymentDate: (json['PaymentDate'] as Timestamp).toDate(),
        paymentPrice: json['PaymentPrice'],
        paymentStatus: json['PaymentStatus'],
      );

  static Payment fromQDS(QueryDocumentSnapshot<Map<String, dynamic>> qds) =>
      Payment(
        paymentKey: qds.reference.id,
        paymentQty: qds.data()['PaymentQty'],
        paymentDate: (qds.data()['PaymentDate'] as Timestamp).toDate(),
        paymentPrice: qds.data()['PaymentPrice'],
        paymentStatus: qds.data()['PaymentStatus'],
      );

  static Future<Payment> paymentAdd(Payment data, String orderKey) async {
    var db = FirebaseFirestore.instance;
    final addOrder =
        db.collection('Orders').doc(orderKey).collection('Payments');
    addOrder.add(
      data.toJason(),
    );
    return data;
  }

  static Future<List<Payment>> readPaymentPerOrder(String orderKey) async {
    // num totalQty = 0;

    var db = FirebaseFirestore.instance;
    final getpayment = await db
        .collection('Orders')
        .doc(orderKey)
        .collection('Payments')
        .get()
        .then(
          (value) => value.docs
              .map(
                (e) => Payment.fromQDS(
                  e,
                ),
              )
              .toList(),
        );

    return getpayment;
  }

  static Future<String> deleteDocById(String orderId, String paymentId) async {
    var db = FirebaseFirestore.instance;
    return await db
        .collection('Orders')
        .doc(orderId)
        .collection('Payments')
        .doc(paymentId)
        .delete()
        .then(
      (value) => 'the Data has been deleted',
      onError: (e) {
        return 'Error : ${e.toString()}';
      },
    );
  }

  static Future<String> updateStatus(
      String orderId, String paymentId, String paymentStatus) async {
    var db = FirebaseFirestore.instance;
    return await db
        .collection('Orders')
        .doc(orderId)
        .collection('Payments')
        .doc(paymentId)
        .update({'PaymentStatus': paymentStatus}).then(
      (value) => 'Update Complete',
      onError: (e) {
        return 'Error ${e.toString()}';
      },
    );
  }
}
