import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String? assetType; //madu,botol,sticker,spanduk
  final DateTime? transDate;
  final num? transQty;
  final num? transTotalPrice;
  final String? transDescription;
  final DateTime createdDate;
  Asset({
    required this.assetType,
    required this.transDate,
    required this.transQty,
    required this.transTotalPrice,
    required this.transDescription,
    required this.createdDate,
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
        transDate: json['TransDate'] == null
            ? null
            : (json['TransDate'] as Timestamp).toDate(),
        transQty: json['Trans.Qty'] == null ? null : (json['Trans.Qty'] as num),
        transTotalPrice: json['Trans.TotalPrice'] == null
            ? null
            : (json['Trans.TotalPrice'] as num),
        transDescription: json['Trans.Description'],
        createdDate: (json['CreateDate'] as Timestamp).toDate(),
      );

  static Asset fromDocSnap(DocumentSnapshot<Object?> json) => Asset(
        assetType: json['AssetType'],
        transDate: (json['TransDate'] as Timestamp).toDate(),
        transQty: (json['Trans.Qty'] as num),
        transTotalPrice: (json['Trans.TotalPrice'] as num),
        transDescription: json['Trans.Description'],
        createdDate: (json['CreateDate'] as Timestamp).toDate(),
      );

  static Future addAssetCollection({
    required String assetType,
    required String userEmail,
  }) async {
    var db = FirebaseFirestore.instance;
    final asset = db.collection('Assets').doc(assetType);
    await asset.set({'CreateDate': DateTime.now(), 'CreateBy': userEmail});
  }

  static Future<Asset?>? readAsset(String assetId) async {
    var db = FirebaseFirestore.instance;
    final docAsset = db.collection('Assets').doc(assetId);

    final sel = await docAsset.get();
    // print('the value is $sel');
    if (sel.exists) {
      return Asset.fromJason(sel.data()!);
    } else {
      return null;
    }
  }

  static Future<List<Asset>> readAssets() async {
    var db = FirebaseFirestore.instance;
    return db
        .collection('Assets')
        .snapshots()
        .map(
          (ss) => ss.docs
              .map(
                (doc) => Asset.fromJason(
                  doc.data(),
                ),
              )
              .toList(),
        )
        .first;
  }

  static Future<String> deleteDocById(String docId) async {
    var db = FirebaseFirestore.instance;
    return await db.collection('Assets').doc(docId).delete().then(
      (value) => 'the Data has been deleted',
      onError: (e) {
        return 'Error : ${e.toString()}';
      },
    );
  }

  static Future<List<Asset>> readAssets_() async {
    var db = FirebaseFirestore.instance;
    return db
        .collection('Assets')
        .snapshots()
        .map(
          (ss) => ss.docs.map((doc) {
            return Asset(
              assetType: doc.reference.id,
              transDate: doc.data()['Trans.Date'] == null
                  ? null
                  : (doc.data()['Trans.Date'] as Timestamp).toDate(),
              transQty: doc.data()['Trans.Qty'],
              transTotalPrice: doc.data()['Trans.TotalPrice'],
              transDescription: doc.data()['Trans.Description'],
              createdDate: (doc.data()['CreateDate'] as Timestamp).toDate(),
            );
          }).toList(),
        )
        .first;
  }

  static Future<bool?>? isExists(String assetId) async {
    var db = FirebaseFirestore.instance;
    final docAsset = db.collection('Assets').doc(assetId);

    final sel = await docAsset.get();
    // print('the value is $sel');
    if (sel.exists) {
      return true;
    } else {
      return null;
    }
  }

  static Future<String?>? isAssetExists(String assetId) async {
    var db = FirebaseFirestore.instance;
    final docUser = db.collection('Assets').doc(assetId);

    final sel = await docUser.get();
    if (sel.exists) {
      // return null;
      return 'Asset $assetId is Already Exists';
    } else {
      return null;
    }
  }
}
