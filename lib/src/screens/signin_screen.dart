import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/screens/signup_screen.dart';
import 'package:flutter_firebaseapp/src/screens/verificationemail_screen.dart';
// import 'package:flutterfirebase_apps/src/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  String _notificationmsg = "";
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.only(
          top: 45,
          bottom: 20,
          left: 20,
          right: 20,
        ),
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
            padding: EdgeInsets.fromLTRB(20, screenSize.height * 0.2, 20, 0),
            child: Column(
              children: [
                logoWidget('assets/logo/bee.png'),
                const SizedBox(
                  height: 20,
                ),
                textFieldTemplLogin(
                  "Enter User Email",
                  Icons.email_outlined,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                textFieldTemplLogin(
                  "Enter Password",
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  _notificationmsg,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(
                  context,
                  true,
                  () => _signinF(
                      _emailTextController.text, _passwordTextController.text),
                ),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t Have Account? ',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  _signinF(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      )
          .then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmailPage(
                userEmail: _emailTextController.text,
                isSignup: false,
              ),
            ),
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      // print(error.message);
      setState(
        () {
          if (error.code == 'INVALID_LOGIN_CREDENTIALS') {
            _notificationmsg = 'Login Failed';
          } else {
            _notificationmsg = 'Login Failed ${error.message}';
          }
        },
      );
    }
  }
}
