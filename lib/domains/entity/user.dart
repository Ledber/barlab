import 'package:firebase_auth/firebase_auth.dart';

class Users {
  late final String id;
 
  Users.fromFirebase(User user) {
    id = user.uid;
  }
}
