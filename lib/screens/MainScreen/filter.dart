// ignore_for_file: no_logic_in_create_state

import 'dart:convert';

import 'package:barlab/screens/CocktailesScreen/cocktailesList.dart';
import 'package:barlab/screens/CocktailesScreen/cocktailesMain.dart';
import 'package:barlab/screens/CocktailesScreen/favorites.dart';
import 'package:barlab/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cocktails extends StatefulWidget {
  const Cocktails({
    super.key,
    required this.optionStyle,
  });

  final TextStyle optionStyle;

  @override
  State<StatefulWidget> createState() => _CocktailesState();
}

class _CocktailesState extends State<StatefulWidget> {
  bool _isCheckedBrandy = false;
  bool _isCheckedLiquor = false;
  bool _isCheckedJin = false;
  bool _isCheckedVodka = false;
  bool _isCheckedWhiskey = false;
  bool _isCheckedRum = false;
  bool _isCheckedTequla = false;
  bool _isCheckedWine = false;
  bool _isCheckedSweet = false;
  bool _isCheckedSour = false;
  bool _isCheckedBitter = false;
  bool _isCheckedLong = false;
  bool _isCheckedShort = false;
  bool _isCheckedShot = false;

  get isCheckedLiqueurs => null;
  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Expanded(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(15.0),
                  height: 290,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        offset: Offset(2, 2), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              child: const Text(
                                'Основа',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Row(
                                  children: <Widget>[
                                    Container(
                                        width: (constraints.maxWidth - 50) / 2,
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                        ),
                                        // decoration: BoxDecoration(color: Colors.blueGrey),
                                        child: Column(
                                          children: [
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              title: const Text(
                                                'Бренди',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedBrandy,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedBrandy = value!;
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              title: const Text(
                                                'Ликер',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedLiquor,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedLiquor = value!;
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              title: const Text(
                                                'Вино',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedWine,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedWine = value!;
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              title: const Text(
                                                'Джин',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedJin,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedJin = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        )),
                                    Container(
                                        width: (constraints.maxWidth - 50) / 2,
                                        margin: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 10.0,
                                        ),
                                        // decoration: BoxDecoration(color: Colors.blueAccent),
                                        child: Column(
                                          children: [
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              title: const Text(
                                                'Водка',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedVodka,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedVodka = value!;
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              // ignore: prefer_const_constructors
                                              title: Text(
                                                'Виски',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedWhiskey,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedWhiskey = value!;
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              // ignore: prefer_const_constructors
                                              title: Text(
                                                'Ром',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedRum,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedRum = value!;
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              activeColor: Colors.red,
                                              // ignore: prefer_const_constructors
                                              title: Text(
                                                'Текила',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                              value: _isCheckedTequla,
                                              onChanged: (value) {
                                                setState(() {
                                                  _isCheckedTequla = value!;
                                                });
                                              },
                                            ),
                                          ],
                                        )),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: <Widget>[
                      Container(
                          // height: 145,
                          width: (constraints.maxWidth - 50) / 2,
                          margin: const EdgeInsets.only(
                            left: 15.0,
                            right: 10.0,
                          ),
                          decoration: BoxDecoration(
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Вкус',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CheckboxListTile(
                                activeColor: Colors.red,
                                // ignore: prefer_const_constructors
                                title: Text(
                                  'Сладкий',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: _isCheckedSweet,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckedSweet = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                activeColor: Colors.red,
                                // ignore: prefer_const_constructors
                                title: Text(
                                  'Кислый',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: _isCheckedSour,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckedSour = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                activeColor: Colors.red,
                                // ignore: prefer_const_constructors
                                title: Text(
                                  'Горький',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: _isCheckedBitter,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckedBitter = value!;
                                  });
                                },
                              ),
                            ],
                          )),
                      Container(
                          // height: 145,
                          width: (constraints.maxWidth - 50) / 2,
                          margin: const EdgeInsets.only(
                            left: 10.0,
                            right: 15.0,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: [
                              const BoxShadow(
                                color: Colors.black,
                                blurRadius: 4,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Обьем',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CheckboxListTile(
                                activeColor: Colors.red,
                                // ignore: prefer_const_constructors
                                title: Text(
                                  'Лонг',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: _isCheckedLong,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckedLong = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                activeColor: Colors.red,
                                // ignore: prefer_const_constructors
                                title: Text(
                                  'Шорт',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: _isCheckedShort,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckedShort = value!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                activeColor: Colors.red,
                                // ignore: prefer_const_constructors
                                title: Text(
                                  'Шот',
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: _isCheckedShot,
                                onChanged: (value) {
                                  setState(() {
                                    _isCheckedShot = value!;
                                  });
                                },
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 358, // <-- Your width
            height: 56,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 16, 0, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FilteredPage(
                              isCheckedBrandy: _isCheckedBrandy,
                              isCheckedLiquor: _isCheckedLiquor,
                              isCheckedWine: _isCheckedWine,
                              isCheckedJin: _isCheckedJin,
                              isCheckedVodka: _isCheckedVodka,
                              isCheckedWhiskey: _isCheckedWhiskey,
                              isCheckedRum: _isCheckedRum,
                              isCheckedTequla: _isCheckedTequla,
                              isCheckedSweet: _isCheckedSweet,
                              isCheckedSour: _isCheckedSour,
                              isCheckedBitter: _isCheckedBitter,
                              isCheckedLong: _isCheckedLong,
                              isCheckedShort: _isCheckedShort,
                              isCheckedShot: _isCheckedShot,
                            )),
                  );
                },
                child: const Text(
                  'Подобрать',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ],
    );
  }
}

class FilteredPage extends StatefulWidget {
  const FilteredPage({
    super.key,
    required this.isCheckedBrandy,
    required this.isCheckedLiquor,
    required this.isCheckedWine,
    required this.isCheckedJin,
    required this.isCheckedVodka,
    required this.isCheckedWhiskey,
    required this.isCheckedRum,
    required this.isCheckedTequla,
    required this.isCheckedSweet,
    required this.isCheckedSour,
    required this.isCheckedBitter,
    required this.isCheckedLong,
    required this.isCheckedShort,
    required this.isCheckedShot,
  });
  final bool isCheckedBrandy;
  final bool isCheckedLiquor;
  final bool isCheckedWine;
  final bool isCheckedJin;
  final bool isCheckedVodka;
  final bool isCheckedWhiskey;
  final bool isCheckedRum;
  final bool isCheckedTequla;
  final bool isCheckedSweet;
  final bool isCheckedSour;
  final bool isCheckedBitter;
  final bool isCheckedLong;
  final bool isCheckedShort;
  final bool isCheckedShot;
// FilteredPage({required this.filter1, required this.filter2});
  @override
  State<FilteredPage> createState() => _ctListSStateq(
        isCheckedBrandy: isCheckedBrandy,
        isCheckedLiquor: isCheckedLiquor,
        isCheckedWine: isCheckedWine,
        isCheckedJin: isCheckedJin,
        isCheckedVodka: isCheckedVodka,
        isCheckedWhiskey: isCheckedWhiskey,
        isCheckedRum: isCheckedRum,
        isCheckedTequla: isCheckedTequla,
        isCheckedSweet: isCheckedSweet,
        isCheckedSour: isCheckedSour,
        isCheckedBitter: isCheckedBitter,
        isCheckedLong: isCheckedLong,
        isCheckedShort: isCheckedShort,
        isCheckedShot: isCheckedShot,
      );
}

class _ctListSStateq extends State<FilteredPage> {
  final bool isCheckedBrandy;
  final bool isCheckedLiquor;
  final bool isCheckedWine;
  final bool isCheckedJin;
  final bool isCheckedVodka;
  final bool isCheckedWhiskey;
  final bool isCheckedRum;
  final bool isCheckedTequla;
  final bool isCheckedSweet;
  final bool isCheckedSour;
  final bool isCheckedBitter;
  final bool isCheckedLong;
  final bool isCheckedShort;
  final bool isCheckedShot;

  _ctListSStateq({
    required this.isCheckedBrandy,
    required this.isCheckedLiquor,
    required this.isCheckedWine,
    required this.isCheckedJin,
    required this.isCheckedVodka,
    required this.isCheckedWhiskey,
    required this.isCheckedRum,
    required this.isCheckedTequla,
    required this.isCheckedSweet,
    required this.isCheckedSour,
    required this.isCheckedBitter,
    required this.isCheckedLong,
    required this.isCheckedShort,
    required this.isCheckedShot,
  });
  List<Map<String, dynamic>> _items = [];

  Set<int> _selectedIndexes = {};
  List<Widget> widgets = [];
  @override
  void initState() {
    super.initState();
    // initFirebase();
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

  bool _isItemAdded(Map<String, dynamic> item) {
    for (var i = 0; i < _items.length; i++) {
      if (_items[i]['name'] == item['name']) {
        return true;
      }
    }
    return false;
  }

  Stream<QuerySnapshot> getFilteredData() {
    Query query = FirebaseFirestore.instance.collection('coctailes');
    if (isCheckedBrandy) {
      query = query.where('hasBrandy', isEqualTo: true);
    }
    if (isCheckedLiquor) {
      query = query.where('hasLiquor', isEqualTo: true);
    }
    if (isCheckedWine) {
      query = query.where('hasVine', isEqualTo: true);
    }
    if (isCheckedJin) {
      query = query.where('hasJin', isEqualTo: true);
    }
    if (isCheckedVodka) {
      query = query.where('hasVodka', isEqualTo: true);
    }
    if (isCheckedWhiskey) {
      query = query.where('hasWhiskey', isEqualTo: true);
    }
    if (isCheckedRum) {
      query = query.where('hasRum', isEqualTo: true);
    }
    if (isCheckedTequla) {
      query = query.where('hasTequla', isEqualTo: true);
    }
    if (isCheckedSweet) {
      query = query.where('isSweet', isEqualTo: true);
    }
    if (isCheckedSour) {
      query = query.where('isSour', isEqualTo: true);
    }
    if (isCheckedBitter) {
      query = query.where('isBitter', isEqualTo: true);
    }
    if (isCheckedLong) {
      query = query.where('isLong', isEqualTo: true);
    }
    if (isCheckedShort) {
      query = query.where('isShort', isEqualTo: true);
    }
    if (isCheckedShot) {
      query = query.where('isShot', isEqualTo: true);
    }
    return query.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'BarLab',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getFilteredData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final documents = snapshot.data!.docs;

          return ListView(
            children: documents.map((DocumentSnapshot document) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => cocktailesMain(
                        cocktail: document,
                      ),
                    ),
                  );
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
                                document['photourl'],
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
                                  document['type'],
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
                                  document['name'],
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
                                  'Вкус:' + document['taste'],
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
                                  'Метод:' + document['method'],
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
                                  'Стакан:' + document['glass'],
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
                              icon: _isItemAdded(
                                      document.data() as Map<String, dynamic>)
                                  ? Icon(Icons.star)
                                  : Icon(Icons.star_border),
                              onPressed: () {
                                setState(() {
                                  final data =
                                      document.data() as Map<String, dynamic>;
                                  final DOCid = document.id;
                                  // print('docID' + DOCid);
                                  if (_isItemAdded(data)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Item already added!'),
                                      duration: Duration(seconds: 2),
                                    ));
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
            }).toList(),
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
    );
  }
}
