import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebaseapp/src/enums/enum_datalookup.dart';

class User {
  final String profileName;
  final String profileEmail;
  final String profileAddress;
  final String phoneNumber;
  final DateTime registerDate;
  final String profileGender;
  final String profileStatus;
  User({
    required this.profileName,
    required this.profileEmail,
    required this.profileAddress,
    required this.phoneNumber,
    required this.registerDate,
    required this.profileGender,
    required this.profileStatus,
  });

  Map<String, dynamic> toJason() => {
        'ProfileName': profileName,
        'ProfileEmail': profileEmail,
        'ProfileAddress': profileAddress,
        'PhoneNumber': phoneNumber,
        'RegisterDate': registerDate,
        'ProfileStatus': profileStatus,
        'ProfileGender': profileGender,
      };

  static User fromJason(Map<String, dynamic> json) => User(
        profileName: json['ProfileName'],
        profileEmail: json['ProfileEmail'],
        phoneNumber: json['PhoneNumber'],
        profileAddress: json['ProfileAddress'],
        registerDate: (json['RegisterDate'] as Timestamp).toDate(),
        profileGender: json['ProfileGender'],
        profileStatus: json['ProfileStatus'],
      );

  static User fromDocSnap(DocumentSnapshot<Object?> json) => User(
        profileName: json['ProfileName'],
        profileEmail: json['ProfileEmail'],
        phoneNumber: json['PhoneNumber'],
        profileAddress: json['ProfileAddress'],
        registerDate: (json['RegisterDate'] as Timestamp).toDate(),
        profileGender: json['ProfileGender'],
        profileStatus: json['ProfileStatus'],
      );

  static Future updateUserStatus({
    required String profileEmail,
    required String profileStatus,
  }) async {
    var db = FirebaseFirestore.instance;
    final userProfile = db.collection('Users').doc(profileEmail);
    userProfile.update(
      {
        'ProfileStatus': profileStatus,
      },
    );
  }

  static Future addUser({
    required String profileName,
    required String profileEmail,
    required String profileAddress,
    required String phoneNumber,
    required String profileGender,
  }) async {
    var db = FirebaseFirestore.instance;
    final userProfile = db.collection('Users').doc(profileEmail);

    final user = User(
      profileName: profileName,
      profileEmail: profileEmail,
      profileAddress: profileAddress,
      phoneNumber: phoneNumber,
      registerDate: DateTime.now(),
      profileStatus: 'Candidate',
      profileGender:
          profileGender == UserGenderEnum.male.toString() ? 'Male' : 'Female',
    );
    await userProfile.set(user.toJason());
  }

  static Future<User> readUser(String userEmail) async {
    var db = FirebaseFirestore.instance;
    final docUser = db.collection('Users').doc(userEmail);
    // print(userEmail);
    final sel = await docUser.get();
    return User.fromJason(sel.data()!);
    // if (sel.exists) {
    //   // return null;
    //   return User.fromJason(sel.data()!);
    // } else {
    //   return null;
    // }
  }
}
