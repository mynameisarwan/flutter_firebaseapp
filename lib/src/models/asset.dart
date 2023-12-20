import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String? assetType; //madu,botol,sticker,spanduk
  final DateTime? createdDate;
  Asset({
    required this.assetType,
    required this.createdDate,
  });

  Map<String, dynamic> toJason() => {
        'AssetType': assetType,
      };

  static Asset fromJason(Map<String, dynamic> json) => Asset(
        assetType: json['AssetType'],
        createdDate: (json['CreateDate'] as Timestamp).toDate(),
      );

  static Asset fromDocSnap(DocumentSnapshot<Object?> json) => Asset(
        assetType: json['AssetType'],
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

  static Future updateAssetTransaction({
    required Map<String, dynamic> trans,
    required String assettype,
  }) async {
    List asset_ = [trans];
    var db = FirebaseFirestore.instance;
    final asset = db.collection('Assets').doc(assettype);
    final upd = await asset.get();
    if (upd.exists) {
      await asset.update(
        {'Transaction': FieldValue.arrayUnion(asset_)},
      );
    }
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
              createdDate: doc.data()['CreateDate'] == null
                  ? null
                  : (doc.data()['CreateDate'] as Timestamp).toDate(),
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

class AssetTransaction {
  final DateTime? transDate;
  final num? transQty;
  final num? transPrice;
  final num? transTotalPrice;
  final String? transMeasurement;
  AssetTransaction({
    required this.transDate,
    required this.transQty,
    required this.transPrice,
    required this.transTotalPrice,
    required this.transMeasurement,
  });
  Map<String, dynamic> toJason() => {
        'TransDate': transDate,
        'TransQty': transQty,
        'TransMeasurement': transMeasurement,
        'TransPrice': transPrice,
        'ransTotalPrice': transTotalPrice
      };
}
