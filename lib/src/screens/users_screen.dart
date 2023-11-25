import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebaseapp/src/screens/user_screen.dart';
import '../models/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  Stream<List<User>> selectUsers() => FirebaseFirestore.instance
      .collection('Users')
      .snapshots()
      .map((snapshots) => snapshots.docs
          .map(
            (doc) => User.fromJason(
              doc.data(),
            ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'User List',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        padding: const EdgeInsets.only(
          top: 45,
          bottom: 20,
          left: 10,
          right: 10,
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
        child: StreamBuilder<List<User>>(
          stream: selectUsers(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<User>> snapshot,
          ) {
            if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            }
            if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: [
                  for (var user in users) ...{
                    Card(
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.profileName,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                Text(
                                  user.profileEmail,
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  user.phoneNumber,
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserScreen(
                                      userEmail: user.profileEmail,
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.edit_outlined),
                            ),
                          ],
                        ),
                      ),
                    ),
                  },
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
