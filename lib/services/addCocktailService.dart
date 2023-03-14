import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addCocktailToFirestore(
    String name,
    String type,
    String taste,
    String method,
    String glass,
    List<String> ingredients,
    List<String> proportions,
    String decoration,
    String recipe,
    bool hasBrandy,
    bool hasLiquor,
    bool hasWine,
    bool hasJin,
    bool hasVodka,
    bool hasWhiskey,
    bool hasRum,
    bool hasTequla,
    bool isSweet,
    bool isSour,
    bool isBitter,
    bool isLong,
    bool isShort,
    bool isShot,
    String imageURL) async {
  CollectionReference cocktails =
      FirebaseFirestore.instance.collection('coctailes');

  try {
    await cocktails.add({
      'name': name,
      'type': type,
      'taste': taste,
      'method': method,
      'glass': glass,
      'ingredients': ingredients,
      'ingredientsPortion': proportions,
      'decor': decoration,
      'cooking': recipe,
      'hasBrandy': hasBrandy,
      'hasLiquor': hasLiquor,
      'hasVine': hasWine,
      'hasJin': hasJin,
      'hasVodka': hasVodka,
      'hasWhiskey': hasWhiskey,
      'hasRum': hasRum,
      'hasTequla': hasTequla,
      'isSweet': isSweet,
      'isSour': isSour,
      'isBitter': isBitter,
      'isLong': isLong,
      'isShort': isShort,
      'isShot': isShot,
      'photourl': imageURL,
    });
  } catch (e) {
    print(e);
  }
}
