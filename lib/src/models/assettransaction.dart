import 'package:cloud_firestore/cloud_firestore.dart';

class AssetTransaction {
  final DateTime? transDate;
  final num transQty;
  final num transPrice;
  final num transTotalPrice;
  final String transMeasurement;
  final String assetId;
  AssetTransaction({
    required this.transDate,
    required this.transQty,
    required this.transPrice,
    required this.transTotalPrice,
    required this.transMeasurement,
    required this.assetId,
  });

  Map<String, dynamic> toJason() => {
        'TransDate': transDate,
        'TransQty': transQty,
        'TransMeasurement': transMeasurement,
        'TransPrice': transPrice,
        'TransTotalPrice': transTotalPrice,
        'AssetId': assetId,
      };

  static AssetTransaction fromJason(Map<String, dynamic> json) =>
      AssetTransaction(
        transDate: (json['TransDate'] as Timestamp).toDate(),
        transQty: json['TransQty'],
        transPrice: json['TransPrice'],
        transTotalPrice: json['TransTotalPrice'],
        transMeasurement: json['TransMeasurement'],
        assetId: json['AssetId'],
      );

  static Future addAssetTransaction({
    required String userEmail,
    required AssetTransaction data,
  }) async {
    var db = FirebaseFirestore.instance;
    final assetTrans = db.collection('AssetTransaction');
    await assetTrans.add(data.toJason());
  }

  static Future<List<AssetTransaction>> readAsssetTransaction(
      String assetId) async {
    var db = FirebaseFirestore.instance;
    return await db
        .collection('AssetTransaction')
        .where('AssetId', isEqualTo: assetId)
        .snapshots()
        .map(
          (ss) => ss.docs.map(
            (doc) {
              return AssetTransaction.fromJason(doc.data());
            },
          ).toList(),
        )
        .first;
  }
}
