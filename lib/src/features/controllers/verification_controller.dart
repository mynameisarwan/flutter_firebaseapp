import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/features/controllers/reference_controller.dart';
import 'package:flutter_firebaseapp/src/models/user.dart';
import 'package:flutter_firebaseapp/src/screens/navigation_screen.dart';
import 'package:flutter_firebaseapp/src/screens/myaccount_screen.dart';
import 'package:flutter_firebaseapp/src/screens/resellerorder_screen.dart';

class VerificationController extends StatefulWidget {
  const VerificationController({super.key, required this.userEmail});
  final String userEmail;

  @override
  State<VerificationController> createState() => _VerificationControllerState();
}

class _VerificationControllerState extends State<VerificationController> {
  late bool _visible;

  // var db = FirebaseFirestore.instance;
  @override
  void initState() {
    _visible = false;
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (mounted) {
          setState(
            () {
              //tells the widget builder to rebuild again because ui has updated
              _visible =
                  true; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
            },
          );
        }
      },
    );
  }

  void setreference(User user) {
    setReference(
      {
        'userEmail': user.profileEmail,
        'userName': user.profileName,
        'userRole': user.profileStatus,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: User.readUser(widget.userEmail),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error.toString()}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          // print('verification controller profilename ${user.profileName}');
          setreference(user);
          String status = user.profileStatus;
          return status == 'Candidate'
              ? MyAccountScreen(
                  userEmail: widget.userEmail,
                )
              : status == 'Administrator'
                  ? const NavigationScreen(
                      scrIdx: 0,
                    )
                  : const ResellerOrder();
        } else {
          return Scaffold(
            body: Container(
              padding: const EdgeInsets.all(10),
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
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: _visible,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'User ',
                            ),
                            TextSpan(
                              text: widget.userEmail,
                              style: const TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' Profile  Update, please go to ',
                            ),
                            TextSpan(
                              text: 'Profile Page ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MyAccountScreen(
                                        userEmail: widget.userEmail,
                                      ),
                                    ),
                                  );
                                },
                            ),
                            const TextSpan(
                              text: 'page ',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
