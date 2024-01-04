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
    return await db
        .collection('Assets')
        .snapshots()
        .map(
          (ss) => ss.docs.map(
            (doc) {
              Map<String, dynamic> json = doc.data();
              return Asset(
                assetType: doc.reference.id,
                createdDate: json['CreateDate'] == null
                    ? null
                    : (json['CreateDate'] as Timestamp).toDate(),
              );
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
