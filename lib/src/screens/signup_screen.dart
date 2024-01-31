import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/screens/verificationemail_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String _notificationmsg = "";
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _key, //_key private key
        child: Container(
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
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldTemplLogin(
                    "Enter User Name",
                    Icons.person_outline,
                    false,
                    _userNameTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textFieldTemplLogin(
                    "Enter Email Address",
                    Icons.mail_outline,
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
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(
                    context,
                    false,
                    () async {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _emailTextController.text.trim(),
                          password: _passwordTextController.text,
                        )
                            .then(
                          (value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyEmailPage(
                                  userEmail: _emailTextController.text.trim(),
                                  isSignup: true,
                                ),
                              ),
                            );
                          },
                        );
                      } on FirebaseAuthException catch (error) {
                        setState(
                          () {
                            if (error.code == 'INVALID_LOGIN_CREDENTIALS') {
                              _notificationmsg = 'Login Failed';
                            } else {
                              _notificationmsg =
                                  'Login Failed ${error.message}';
                            }
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
