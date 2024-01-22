// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final num paymentQty;
  final DateTime paymentDate;
  final num paymentPrice;
  String? paymentKey;

  Payment(
      {required this.paymentQty,
      required this.paymentDate,
      required this.paymentPrice,
      this.paymentKey});

  Map<String, dynamic> toJason() => {
        'PaymentDate': paymentDate,
        'paymentQty': paymentQty,
        'PaymentPrice': paymentPrice,
      };

  Payment fromJason(Map<String, dynamic> json) => Payment(
        paymentQty: json['PaymentQty'],
        paymentDate: (json['PaymentDate'] as Timestamp).toDate(),
        paymentPrice: json['PaymentPrice'],
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

  // Payment fromQDS(QueryDocumentSnapshot<Map<String,dynamic>> qds ) => Payment(paymentQty: paymentQty, paymentDate: paymentDate, paymentPrice: paymentPrice)
}
