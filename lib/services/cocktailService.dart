import 'package:cloud_firestore/cloud_firestore.dart';

class CocktailService {
   final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getCocktails() {
    return _db.collection('coctailes').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Map<String, dynamic>.from(doc.data()))
        .toList());
  }
}


