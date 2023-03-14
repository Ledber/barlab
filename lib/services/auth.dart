import 'package:barlab/domains/entity/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  Future<Users?> signInWithEmailAndPassword(
      String email, String password) async {
    User? user;
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      return Users.fromFirebase(user!);
    } on FirebaseAuthException catch (e) {
      // print(e);
      if (e.code == 'user-not-found') {
        print('Пользователь с таким email не найден');
      } else if (e.code == 'wrong-password') {
        print('Неправильный пароль');
      } else if (e.code == 'invalid-email') {
        print('Некорректный email');
      }
      return null;
    }
    // return user;
  }

  Future<Users> registerWithEmailAndPassword(
      String email, String password, String name) async {
    User? user;
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': name,
        'email': email,
        'avatar_url':
            'https://firebasestorage.googleapis.com/v0/b/barlab-66741.appspot.com/o/avatars%2Fpng-transparent-account-avatar-profile-user-avatars-icon.png?alt=media&token=3c074ae9-aadc-43bd-8ac8-5b59e5725af2',
        'admin': false,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Пользователь с таким email не найден');
      } else if (e.code == 'wrong-password') {
        print('Неправильный пароль');
      }
    }
    return Users.fromFirebase(user!);
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<Users?> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User? user) => user != null ? Users.fromFirebase(user) : null);
  }
}
