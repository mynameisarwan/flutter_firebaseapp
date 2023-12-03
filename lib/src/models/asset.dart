import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String assetType; //madu,botol,sticker,spanduk
  final DateTime transDate;
  final num transQty;
  final num transTotalPrice;
  final String transDescription;

  Asset({
    required this.assetType,
    required this.transDate,
    required this.transQty,
    required this.transTotalPrice,
    required this.transDescription,
  });

  Map<String, dynamic> toJason() => {
        'AssetType': assetType,
        'Trans.Date': transDate,
        'Trans.Qty': transQty,
        'Trans.TotalPrice': transTotalPrice,
        'Trans.Description': transDescription,
      };

  static Asset fromJason(Map<String, dynamic> json) => Asset(
        assetType: json['AssetType'],
        transDate: (json['TransDate'] as Timestamp).toDate(),
        transQty: (json['Trans.Qty'] as num),
        transTotalPrice: (json['Trans.TotalPrice'] as num),
        transDescription: json['Trans.Description'],
      );

  static Asset fromDocSnap(DocumentSnapshot<Object?> json) => Asset(
        assetType: json['AssetType'],
        transDate: (json['TransDate'] as Timestamp).toDate(),
        transQty: (json['Trans.Qty'] as num),
        transTotalPrice: (json['Trans.TotalPrice'] as num),
        transDescription: json['Trans.Description'],
      );

  static Future addAssetCollection({
    required String assetType,
    required String userEmail,
  }) async {
    var db = FirebaseFirestore.instance;
    final asset = db.collection('Assets').doc(assetType);
    await asset.set({'CreateDate': DateTime.now(), 'CreateBy': userEmail});
  }
}
