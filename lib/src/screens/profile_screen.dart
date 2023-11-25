import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_button.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_radionbutton.dart';
import 'package:flutter_firebaseapp/src/common_widgets/template_widgets.dart';
import 'package:flutter_firebaseapp/src/enums/enum_datalookup.dart';
import 'package:flutter_firebaseapp/src/models/user.dart';

class ProfileScreen extends StatefulWidget {
  final String userEmail;
  const ProfileScreen({super.key, required this.userEmail});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _phoneNumbTextController =
      TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
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

          // _gender = user.profileGender == ''
          //     ? _gender
          //     : user.profileGender == 'Male'
          //         ? UserGenderEnum.male
          //         : UserGenderEnum.female;

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
                        user.profileName,
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
                        user.phoneNumber,
                        Icons.phone_android_outlined,
                        TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textFieldTemplForm(
                        _addressTextController,
                        user.profileAddress,
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
