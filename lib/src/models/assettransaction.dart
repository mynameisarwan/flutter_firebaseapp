import 'package:cloud_firestore/cloud_firestore.dart';

class AssetTransaction {
  final String? docId;
  final DateTime? transDate;
  final num transQty;
  final num transPrice;
  final num transTotalPrice;
  final String transMeasurement;
  final String assetId;
  AssetTransaction({
    required this.docId,
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
        docId: json['DocId'],
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

  static Future<String> deleteDocById(String docId) async {
    var db = FirebaseFirestore.instance;
    return await db.collection('AssetTransaction').doc(docId).delete().then(
      (value) => 'the Data has been deleted',
      onError: (e) {
        return 'Error : ${e.toString()}';
      },
    );
  }

  static Future<List<AssetTransaction>> readAssetTransaction(
      String assetId) async {
    var db = FirebaseFirestore.instance;
    return await db
        .collection('AssetTransaction')
        .where('AssetId', isEqualTo: assetId)
        .snapshots()
        .map(
          (ss) => ss.docs.map(
            (doc) {
              Map<String, dynamic> json = doc.data();
              return AssetTransaction(
                docId: doc.reference.id,
                transDate: (json['TransDate'] as Timestamp).toDate(),
                transQty: json['TransQty'],
                transPrice: json['TransPrice'],
                transTotalPrice: json['TransTotalPrice'],
                transMeasurement: json['TransMeasurement'],
                assetId: json['AssetId'],
              );
            },
          ).toList(),
        )
        .first;
  }
}
