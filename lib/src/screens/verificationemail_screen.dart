import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_snackbar.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/features/controllers/verification_controller.dart';
import 'package:flutter_firebaseapp/src/screens/myaccount_screen.dart';

class VerifyEmailPage extends StatefulWidget {
  final String userEmail;
  final bool isSignup;

  const VerifyEmailPage({
    super.key,
    required this.userEmail,
    required this.isSignup,
  });

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailverified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    isEmailverified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailverified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (timer) {
          checkEmailverified();
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailverified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailverified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(
        () => canResendEmail = false,
      );
      await Future.delayed(
        const Duration(seconds: 5),
      );
      setState(
        () => canResendEmail = true,
      );
    } catch (e) {
      showSnackBar(
        e.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) => isEmailverified
      ? widget.isSignup
          ? MyAccountScreen(
              userEmail: widget.userEmail,
            )
          : VerificationController(
              userEmail: widget.userEmail,
            )
      : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 5,
            automaticallyImplyLeading: false,
            title: textAlignFormTemplate(
              textlabe: 'Verification Email',
              color: Colors.white,
              isbold: true,
              size: 18,
              textAlign: TextAlign.left,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAlignFormTemplate(
                  textlabe: 'A verification Email has been sent to your email',
                  isbold: true,
                  size: 20,
                  color: Colors.black87,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size.fromHeight(50),
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith(
                      (states) {
                        return states.contains(MaterialState.pressed)
                            ? const Color.fromARGB(255, 249, 174, 0)
                            : Colors.black;
                      },
                    ),
                  ),
                  onPressed: canResendEmail ? sendVerificationEmail : null,
                  icon: const Icon(
                    Icons.email_rounded,
                    color: Colors.amber,
                  ),
                  label: textFormTemplate(
                    'Resend Email',
                    true,
                    20,
                    Colors.amber,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  child: textFormTemplate(
                    'Cancel',
                    true,
                    20,
                    Colors.black,
                  ),
                )
              ],
            ),
          ),
        );
}
