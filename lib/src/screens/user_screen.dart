// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_displaybottomsheet.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
// import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/user.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({
    super.key,
    required this.userEmail,
  });
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var db = FirebaseFirestore.instance;
    final TextEditingController userStatusTextController =
        TextEditingController();

    Stream<DocumentSnapshot<Map<String, dynamic>>> readUser() =>
        db.collection('Users').doc(userEmail).snapshots();

    // Future<User?>? readUser() async {
    //   final docUser = db.collection('Users').doc(userEmail);

    //   final sel = await docUser.get();
    //   if (sel.exists) {
    //     // return null;
    //     return User.fromJason(sel.data()!);
    //   } else {
    //     return null;
    //   }
    // }

    return StreamBuilder(
      stream: readUser(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error.toString()}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      const interactivestate = <MaterialState>{
                        MaterialState.focused,
                        MaterialState.pressed,
                        MaterialState.hovered,
                      };

                      if (states.any(interactivestate.contains)) {
                        return const Color.fromARGB(255, 246, 185, 2);
                      } else {
                        return Colors.transparent;
                      }
                    },
                  ),
                ),
              ),
              backgroundColor: Colors.transparent,
              title: const Text(
                'Profile Update',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 94, 94),
                    Color.fromARGB(255, 239, 126, 46),
                    Color.fromARGB(255, 237, 196, 18),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    screenSize.height * 0.2,
                    20,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFormTemplate(
                        'Profile Info',
                        true,
                        20,
                        Colors.white,
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Profile Name',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: textFormTemplate(
                              user['ProfileName'],
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Phone Number',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: textFormTemplate(
                              user['PhoneNumber'],
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Profile Email',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: textFormTemplate(
                              user['ProfileEmail'],
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Profile Address',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: textFormTemplate(
                              user['ProfileAddress'],
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Gender',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: textFormTemplate(
                              user['ProfileGender'],
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Phone Number',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: textFormTemplate(
                              DateFormat('dd MMMM yyyy hh:mm a').format(
                                  (user['RegisterDate'] as Timestamp).toDate()),
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height / 50,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: screenSize.width / 3,
                            child: textFormTemplate(
                              'Profile Status',
                              true,
                              14,
                              Colors.white70,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: textFormTemplate(
                                      user['ProfileStatus'],
                                      true,
                                      14,
                                      Colors.white,
                                    ),
                                  ),
                                  FittedBox(
                                    // userStatusTextController
                                    child: DisplayButtomSheetComboboxTemplate(
                                      selectedvalue: user['ProfileStatus'],
                                      statuslist: const [
                                        'Candidate',
                                        'Administrator',
                                        'Reseller',
                                      ],
                                      userEmail: user['ProfileEmail'],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ButtonTemplate(
                        buttonText: 'Submit Form',
                        onPressed: () {
                          // try{} catch
                          User.updateUserStatus(
                            profileEmail: user['ProfileEmail'],
                            profileStatus: userStatusTextController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );

    // return FutureBuilder<User?>(
    //   future: readUser(),
    //   builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
    //     if (snapshot.hasError) {
    //       return Text('Error : ${snapshot.error.toString()}');
    //     } else if (snapshot.hasData) {
    //       final user = snapshot.data!;
    //       return Scaffold(
    //         extendBodyBehindAppBar: true,
    //         appBar: AppBar(
    //           leading: BackButton(
    //             color: Colors.white,
    //             style: ButtonStyle(
    //               backgroundColor: MaterialStateProperty.resolveWith<Color>(
    //                 (states) {
    //                   const interactivestate = <MaterialState>{
    //                     MaterialState.focused,
    //                     MaterialState.pressed,
    //                     MaterialState.hovered,
    //                   };

    //                   if (states.any(interactivestate.contains)) {
    //                     return const Color.fromARGB(255, 246, 185, 2);
    //                   } else {
    //                     return Colors.transparent;
    //                   }
    //                 },
    //               ),
    //             ),
    //           ),
    //           backgroundColor: Colors.transparent,
    //           title: const Text(
    //             'Profile Update',
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //         ),
    //         body: Container(
    //           width: screenSize.width,
    //           height: screenSize.height,
    //           decoration: const BoxDecoration(
    //             gradient: LinearGradient(
    //               colors: [
    //                 Color.fromARGB(255, 255, 94, 94),
    //                 Color.fromARGB(255, 239, 126, 46),
    //                 Color.fromARGB(255, 237, 196, 18),
    //               ],
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //             ),
    //           ),
    //           child: SingleChildScrollView(
    //             child: Padding(
    //               padding: EdgeInsets.fromLTRB(
    //                 20,
    //                 screenSize.height * 0.2,
    //                 20,
    //                 0,
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   textFormTemplate(
    //                     'Profile Info',
    //                     true,
    //                     20,
    //                     Colors.white,
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Profile Name',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: textFormTemplate(
    //                           user.profileName,
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Phone Number',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: textFormTemplate(
    //                           user.phoneNumber,
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Profile Email',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: textFormTemplate(
    //                           user.profileEmail,
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Profile Address',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: textFormTemplate(
    //                           user.profileAddress,
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Gender',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: textFormTemplate(
    //                           user.profileGender,
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Phone Number',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: textFormTemplate(
    //                           DateFormat('dd MMMM yyyy hh:mm a')
    //                               .format(user.registerDate),
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   SizedBox(
    //                     height: screenSize.height / 50,
    //                   ),
    //                   Row(
    //                     children: [
    //                       SizedBox(
    //                         width: screenSize.width / 3,
    //                         child: textFormTemplate(
    //                           'Profile Status',
    //                           true,
    //                           14,
    //                           Colors.white70,
    //                         ),
    //                       ),
    //                       Expanded(
    //                         child: Container(
    //                           padding: const EdgeInsets.all(5),
    //                           decoration: BoxDecoration(
    //                             color: Colors.white24,
    //                             borderRadius:
    //                                 const BorderRadius.all(Radius.circular(10)),
    //                             border: Border.all(
    //                               color: Colors.white,
    //                             ),
    //                           ),
    //                           child: Row(
    //                             children: [
    //                               Expanded(
    //                                 child: textFormTemplate(
    //                                   user.profileStatus,
    //                                   true,
    //                                   14,
    //                                   Colors.white,
    //                                 ),
    //                               ),
    //                               FittedBox(
    //                                 // userStatusTextController
    //                                 child: DisplayButtomSheetComboboxTemplate(
    //                                   selectedvalue: user.profileStatus,
    //                                   statuslist: const [
    //                                     'Candidate',
    //                                     'Administrator',
    //                                     'Reseller',
    //                                   ],
    //                                   userEmail: user.profileEmail,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   ButtonTemplate(
    //                     buttonText: 'Submit Form',
    //                     onPressed: () {
    //                       // try{} catch
    //                       User.updateUserStatus(
    //                         profileEmail: user.profileEmail,
    //                         profileStatus: userStatusTextController.text,
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //   },
    // );
  }
}
