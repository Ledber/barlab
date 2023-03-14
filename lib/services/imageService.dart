import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

final usersRef = FirebaseFirestore.instance.collection('users');
Future<DocumentSnapshot> getUserDocument() async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userDoc = await usersRef.doc(currentUser.uid).get();
  return userDoc;
}

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.getImage(source: ImageSource.gallery);
  if (pickedFile == null) return null;
  return File(pickedFile.path);
}

Future<String?> uploadImage(File imageFile) async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final storageRef = FirebaseStorage.instance.ref();
  final ref = storageRef.child('avatars/${currentUser.uid}');
  final uploadTask = ref.putFile(imageFile);
  final snapshot = await uploadTask.whenComplete(() => null);
  final downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future<String?> uploadCocktailImage(File imageFile) async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final storageRef = FirebaseStorage.instance.ref();
  final ref = storageRef.child('cocktails/');
  final uploadTask = ref.putFile(imageFile);
  final snapshot = await uploadTask.whenComplete(() => null);
  final downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

Future<void> updateUserDocument(Map<String, dynamic> data) async {
  final currentUser = FirebaseAuth.instance.currentUser!;
  await usersRef.doc(currentUser.uid).update(data);
  Fluttertoast.showToast(
    msg: "Аватарка изменена, обновите страницу",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER_RIGHT,
    // timeInSecForIosWeb: 2,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16,
  );
}
