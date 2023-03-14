// ignore: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:barlab/services/auth.dart';
import 'package:barlab/services/imageService.dart';
// import 'package:barlab/services/isAdmin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  final String email;
  final String name;
  const profile({super.key, required this.name, required this.email});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  // final FirebaseStorage storage = FirebaseStorage.instance;
  final Reference storageRef = FirebaseStorage.instance.ref().child('avatars');
  String? uid;
  late String _name;
  late String _email;
  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        uid = currentUser.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'BarLab',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
          future: getUserDocument(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userDoc = snapshot.data!;
              return Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Expanded(
                    child: Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            radius: 100,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 95,
                              backgroundImage:
                                  NetworkImage(userDoc['avatar_url']),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          // width: double.infinity,
                          margin: EdgeInsets.only(
                            left: 30,
                            right: 30,
                            top: 20,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _name,
                            //  textAlign: TextAlign.center ,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          height: 30,
                          // width: double.infinity,
                          margin:
                              EdgeInsets.only(left: 30, right: 30, bottom: 30),
                          alignment: Alignment.center,
                          child: Text(
                            _email,
                            //  textAlign: TextAlign.center ,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity, // <-- Your width
                            height: 56,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  final imageFile = await pickImage();
                                  if (imageFile == null) return;
                                  final downloadUrl =
                                      await uploadImage(imageFile);
                                  await updateUserDocument(
                                      {'avatar_url': downloadUrl});
                                },
                                child: const Text(
                                  'Добавить/Изменить фото',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ),
                        ),
                        StreamBuilder<DocumentSnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              bool isAdmin = snapshot.data!.get('admin');
                              if (isAdmin) {
                                // Если поле admin равно true, отображаем кнопку
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: double.infinity, // <-- Your width
                                    height: 56,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            side: BorderSide(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pushNamed("/addCocktail");
                                        },
                                        child: const Text(
                                          'Добавить коктейль в базу',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ),
                                );
                              } else {
                                // Иначе скрываем кнопку
                                return SizedBox.shrink();
                              }
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity, // <-- Your width
                      height: 56,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 16, 0, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            AuthService().logOut();
                          },
                          child: const Text(
                            'Выйти из аккаунта',
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
