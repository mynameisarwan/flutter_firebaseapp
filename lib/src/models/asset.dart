import 'package:cloud_firestore/cloud_firestore.dart';

class Asset {
  final String? assetType; //madu,botol,sticker,spanduk
  final DateTime? createdDate;
  final num? sellingPrice;
  final String? sellingUnit;
  Asset({
    this.assetType,
    this.createdDate,
    this.sellingPrice,
    this.sellingUnit,
  });

  Map<String, dynamic> toJason() => {
        'AssetType': assetType,
        'CreatedDate': createdDate,
        'SellingPrice': sellingPrice,
        'SellingUnit': sellingUnit,
      };

  static Asset fromJason(Map<String, dynamic> json) => Asset(
        assetType: json['AssetType'],
        sellingPrice: json['SellingPrice'] ?? 0,
        sellingUnit: json['SellingUnit'],
        createdDate: (json['CreatedDate'] as Timestamp).toDate(),
      );

  static Asset fromDS(QueryDocumentSnapshot<Map<String, dynamic>> ds) => Asset(
        assetType: ds.reference.id,
        sellingPrice: ds.data()['SellingPrice'] ?? 0,
        sellingUnit: ds.data()['SellingUnit'],
        createdDate: (ds.data()['CreatedDate'] as Timestamp).toDate(),
      );

  static Asset fromDocSnap(DocumentSnapshot<Object?> json) => Asset(
        assetType: json['AssetType'],
        createdDate: (json['CreatedDate'] as Timestamp).toDate(),
      );

  static Future addAssetCollection({
    required String assetType,
    required String userEmail,
  }) async {
    var db = FirebaseFirestore.instance;
    final asset = db.collection('Assets').doc(assetType);
    await asset.set({
      'CreatedDate': DateTime.now(),
      'CreateBy': userEmail,
    });
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

  static Future updateAsset(Asset assetmdl) async {
    var db = FirebaseFirestore.instance;
    final userProfile = db.collection('Assets').doc(assetmdl.assetType);
    userProfile.update(
      assetmdl.toJason(),
    );
  }

  static Future<List<Asset>> readAssets_() async {
    var db = FirebaseFirestore.instance;
    return await db
        .collection('Assets')
        .snapshots()
        .map(
          (ss) => ss.docs.map(
            (doc) {
              return Asset.fromDS(
                doc,
              );
            },
          ).toList(),
        )
        .first;
  }

  static Future<Asset> getAssetbyType(String assetType) async {
    var db = FirebaseFirestore.instance;
    return await db.collection('Assets').doc(assetType).get().then(
          (value) => Asset.fromJason(value.data()!),
        );
  }

  static Future<List<Asset>> getAssetsNamed(List<String> type) async {
    var db = FirebaseFirestore.instance;
    return await db
        .collection('Assets')
        .where('__name__', whereIn: type)
        .snapshots()
        .map(
          (ss) => ss.docs.map(
            (doc) {
              return Asset.fromDS(doc);
            },
          ).toList(),
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
