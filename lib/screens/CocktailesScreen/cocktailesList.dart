// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:barlab/screens/CocktailesScreen/favorites.dart';
import 'package:barlab/services/cocktailService.dart';
import 'package:barlab/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barlab/screens/CocktailesScreen/cocktailesMain.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ctListt extends StatelessWidget {
  const ctListt({super.key});
  static const String _title = 'Flutter Code Sample';
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: _title,
        home: Scaffold(
          body: ctListS(),
        ));
  }
}

class ctListS extends StatefulWidget {
  const ctListS({super.key});

  @override
  State<ctListS> createState() => _ctListSState();
}

class _ctListSState extends State<ctListS> {
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  List<Map<String, dynamic>> _items = [];

  Set<int> _selectedIndexes = {};
  List<Widget> widgets = [];
  @override
  void initState() {
    super.initState();
    initFirebase();
    _loadItems();
    _loadSelectedIndexes();
  }

  Future<void> _loadItems() async {
    final items = await Storage.loadItems();
    setState(() {
      _items = items
          .map((item) => Map<String, dynamic>.from(json.decode(item)))
          .toList();
    });
  }

  Future<void> _saveItems() async {
    final items = _items.map((item) => json.encode(item)).toList();
    await Storage.saveItems(items);
  }

  Future<void> _loadSelectedIndexes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedIndexes =
          (prefs.getStringList('selectedIndexes') ?? []).map(int.parse).toSet();
    });
  }

  Future<void> _saveSelectedIndexes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedIndexes',
        _selectedIndexes.map((index) => index.toString()).toList());
  }

  bool _isItemAdded(Map<String, dynamic> item) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i]['name'] == item['name']) {
        return true;
      }
    }
    return false;
  }

  final CocktailService _cocktailService = CocktailService();
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
              Navigator.of(
                context,
                rootNavigator: true,
              ).pop(
                context,
              );
            },
          ),
        ),
        body: StreamBuilder(
          // stream: _cocktailService.getCocktails(),
          stream:
              FirebaseFirestore.instance.collection('coctailes').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documents = snapshot.data!.docs;
            final cocktails = snapshot.data!;
            // final item = cocktails[index];
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final cocktail = documents[index];

                return InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('coctailes')
                        .doc(cocktail.id)
                        .get()
                        .then((doc) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => cocktailesMain(
                                    cocktail: doc,
                                  )));
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    width: double.infinity,
                    height: 155,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.black,
                          width: 2,
                          style: BorderStyle.solid),
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                          offset: Offset(2, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Container(
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(5),
                              width: 112,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                                color: const Color.fromARGB(255, 16, 0, 48),
                              ),
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Image.network(
                                  cocktail['photourl'],
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(4),
                                  // color: Colors.blue,
                                  child: Text(
                                    cocktail['type'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(4),
                                  // color: Colors.blue,
                                  child: Text(
                                    cocktail['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(4),
                                  // color: Colors.blue,
                                  child: Text(
                                    'Вкус:' + cocktail['taste'],
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(4),
                                  // color: Colors.blue,
                                  child: Text(
                                    'Метод:' + cocktail['method'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(4),
                                  // color: Colors.blue,
                                  child: Text(
                                    'Стакан:' + cocktail['glass'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: _isItemAdded(cocktail.data())
                                    ? Icon(Icons.star)
                                    : Icon(Icons.star_border),
                                onPressed: () {
                                  setState(() {
                                    final data =
                                        cocktail.data() as Map<String, dynamic>;
                                    final DOCid = cocktail.id;
                                    if (_isItemAdded(data)) {
                                      Fluttertoast.showToast(
                                        msg: "Уже добавлено в избранное",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER_RIGHT,
                                        // timeInSecForIosWeb: 2,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      );
                                    } else {
                                      setState(() {
                                        _items.add({...data, 'DOCid': DOCid});
                                        _saveItems();
                                      });
                                    }
                                    // print(_saveItems());
                                  });
                                },
                              ),
                              Icon(Icons.arrow_forward_ios),
                              IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ]),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListViewPage(items: _items)),
            );
          },
          child: Icon(Icons.favorite),
        ),
      ),
    );
  }
}
