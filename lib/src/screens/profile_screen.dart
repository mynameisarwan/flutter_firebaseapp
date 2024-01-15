import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/screens/signin_screen.dart';
import '../models/user.dart' as model;

String userEmail = "";
String userName = "";
AsyncSnapshot<model.User?>? dataUser;

var db = FirebaseFirestore.instance;

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  Future<model.User?> getData() async {
    await getReference().then(
      (data) {
        userEmail = data['userEmail'];
        // udata.
      },
    );
    return await model.User.readUser(userEmail).then(
      (value) => value,
    );
    // return null;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 94, 94),
                Color.fromARGB(255, 239, 126, 46),
                Color.fromARGB(255, 237, 196, 18),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              controller: ScrollController(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            FirebaseAuth.instance.signOut().then(
                              (value) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'My Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: screenSize.height * 0.4,
                      color: Colors.transparent,
                      child: FutureBuilder(
                        future: getData(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<model.User?> snapshot,
                        ) {
                          if (snapshot.hasData) {
                            final user = snapshot.data!;
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                double innerheight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerheight * 0.65,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: innerheight * 0.2,
                                            ),
                                            Text(
                                              user.profileName,
                                              style: const TextStyle(
                                                fontSize: 24,
                                              ),
                                            ),
                                            SizedBox(
                                              height: innerWidth * 0.01,
                                            ),
                                            Text(
                                              user.profileStatus,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black38,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: user.profileGender == 'Male'
                                            ? profileImage(
                                                'assets/images/pimg_m.png',
                                                innerWidth * 0.45,
                                                innerWidth * 0.45)
                                            : profileImage(
                                                'assets/images/pimg_f.png',
                                                innerWidth * 0.45,
                                                innerWidth * 0.45),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                double innerheight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerheight * 0.65,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: innerheight * 0.2,
                                            ),
                                            Text(
                                              "Error: ${snapshot.error}",
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: profileImage(
                                            'assets/images/pimg_m.png',
                                            innerWidth * 0.45,
                                            innerWidth * 0.45),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                double innerheight = constraints.maxHeight;
                                double innerWidth = constraints.maxWidth;
                                return Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        height: innerheight * 0.65,
                                        width: innerWidth,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: innerheight * 0.2,
                                            ),
                                            const CircularProgressIndicator(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      top: 0,
                                      left: 0,
                                      right: 0,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
