import 'package:firebase_auth/firebase_auth.dart' as eos;
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_radionbutton.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/enums/enum_datalookup.dart';
import 'package:flutter_firebaseapp/src/models/user.dart';
import 'package:flutter_firebaseapp/src/screens/signin_screen.dart';

class MyAccountScreen extends StatefulWidget {
  final String userEmail;
  const MyAccountScreen({super.key, required this.userEmail});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late TextEditingController _userNameTextController = TextEditingController();
  late TextEditingController _phoneNumbTextController = TextEditingController();
  late TextEditingController _addressTextController = TextEditingController();
  UserGenderEnum? _gender;
  @override
  void dispose() {
    _userNameTextController.dispose();
    _phoneNumbTextController.dispose();
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: User.readUser(widget.userEmail),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error.toString()}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          _userNameTextController = TextEditingController(
            text: user.profileName,
          );
          _phoneNumbTextController = TextEditingController(
            text: user.phoneNumber,
          );
          _addressTextController = TextEditingController(
            text: user.profileAddress,
          );
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              toolbarHeight: 100,
              actions: [
                Ink(
                  width: 40,
                  height: 40,
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Colors.white12,
                  ),
                  child: Center(
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        eos.FirebaseAuth.instance.signOut().then(
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
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: screenSize.width / 20,
                )
              ],
            ),
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
                  padding: EdgeInsets.fromLTRB(
                    20,
                    screenSize.height * 0.2,
                    20,
                    0,
                  ),
                  child: Column(
                    children: [
                      textFieldTemplForm(
                        _userNameTextController,
                        'Profile Name',
                        Icons.person_2_outlined,
                        TextInputType.name,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          RadioButtonTempl(
                            title: UserGenderEnum.male.name,
                            value: UserGenderEnum.male,
                            userGenderEnum: _gender ??
                                (user.profileGender == 'Male'
                                    ? UserGenderEnum.male
                                    : _gender),
                            onChanged: (val) {
                              setState(() {
                                _gender = val;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          RadioButtonTempl(
                            title: UserGenderEnum.female.name,
                            value: UserGenderEnum.female,
                            userGenderEnum: _gender ??
                                (user.profileGender == 'Female'
                                    ? UserGenderEnum.female
                                    : _gender),
                            onChanged: (val) {
                              setState(() {
                                _gender = val;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFieldTemplForm(
                        _phoneNumbTextController,
                        'Phone Number',
                        Icons.phone_android_outlined,
                        TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFieldTemplForm(
                        _addressTextController,
                        'User Address',
                        Icons.house_outlined,
                        TextInputType.streetAddress,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ButtonTemplate(
                        buttonText: 'Submit Form',
                        onPressed: () {
                          // try{} catch
                          User.addUser(
                            profileName: _userNameTextController.text,
                            profileEmail: widget.userEmail,
                            profileAddress: _addressTextController.text,
                            phoneNumber: _phoneNumbTextController.text,
                            profileGender: _gender.toString(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          // return const Center(child: CircularProgressIndicator());
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
                  padding: EdgeInsets.fromLTRB(
                    20,
                    screenSize.height * 0.2,
                    20,
                    0,
                  ),
                  child: Column(
                    children: [
                      textFieldTemplForm(
                        _userNameTextController,
                        "Profile Name",
                        Icons.person_2_outlined,
                        TextInputType.name,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          RadioButtonTempl(
                            title: UserGenderEnum.male.name,
                            value: UserGenderEnum.male,
                            userGenderEnum: _gender,
                            onChanged: (val) {
                              // print(_gender);
                              setState(() {
                                _gender = val;
                                // print(_gender);
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          RadioButtonTempl(
                            title: UserGenderEnum.female.name,
                            value: UserGenderEnum.female,
                            userGenderEnum: _gender,
                            onChanged: (val) {
                              setState(() {
                                _gender = val;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFieldTemplForm(
                        _phoneNumbTextController,
                        "Phone Number",
                        Icons.phone_android_outlined,
                        TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFieldTemplForm(
                        _addressTextController,
                        "User Address",
                        Icons.house_outlined,
                        TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ButtonTemplate(
                        buttonText: 'Submit Form',
                        onPressed: () {
                          // try{} catch
                          User.addUser(
                            profileName: _userNameTextController.text,
                            profileEmail: widget.userEmail,
                            profileAddress: _addressTextController.text,
                            phoneNumber: _phoneNumbTextController.text,
                            profileGender: _gender.toString(),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
