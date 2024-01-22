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

  static Future<Payment> paymentAdd(Payment data, String orderKey) async {
    var db = FirebaseFirestore.instance;
    final addOrder =
        db.collection('Orders').doc(orderKey).collection('Payments');
    addOrder.add(
      data.toJason(),
    );
    return data;
  }

  static Future<List<Payment>> getTotalPaidQTY(String orderKey) async {
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
                (e) => Payment.fromJason(
                  e.data(),
                ),
              )
              .toList(),
        );

    // print('test');
    // for (var data in scPayment) {
    //   totalQty = totalQty + data.paymentQty;
    // }
    // print('totalqty = $totalQty');
    return getpayment;
  }

  // Payment fromQDS(QueryDocumentSnapshot<Map<String,dynamic>> qds ) => Payment(paymentQty: paymentQty, paymentDate: paymentDate, paymentPrice: paymentPrice)
}
