import 'dart:convert';

import 'package:barlab/screens/CocktailesScreen/cocktailesMain.dart';
import 'package:barlab/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Кнопка очистки поискового запроса
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Кнопка "назад" в AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      List<Map<String, dynamic>> _items = [];
      
      Future<void> _loadItems() async {
    final items = await Storage.loadItems();
    setState(() {
      _items = items
          .map((item) => Map<String, dynamic>.from(json.decode(item)))
          .toList();
    });
  }
  
      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('coctailes')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;
          final lowercaseQuery = query.toLowerCase();
          final filteredDocs = snapshot.data!.docs.where((doc) {
            final name = (doc['name'] as String?)?.toLowerCase() ?? '';
            return name == lowercaseQuery; // Сравниваем в нижнем регистре
          });
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (filteredDocs.isEmpty || query == '') {
            return Center(child: Text('Ничего не найдено'));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка при поиске'));
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              final document = filteredDocs.elementAt(index);
              // Здесь мы можем отобразить нужные данные из найденных результатов
              return InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('coctailes')
                      .doc(document.id)
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
                       
                      ]),
                ),
              );
            },
          );
        },
      );
    });
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    // Здесь мы будем отображать предложения для поиска
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('coctailes').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final lowercaseQuery = query.toLowerCase();
        final documents = snapshot.data!.docs;
        final suggestions = documents
            .where((doc) =>
                doc['name'].toString().toLowerCase().startsWith(lowercaseQuery))
            .toList();
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            // Здесь мы можем отобразить предложения для поиска
            return ListTile(
              title: Container(
                height: 60,
                // margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Colors.black, width: 2, style: BorderStyle.solid),
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(2),
                        padding: EdgeInsets.all(2),
                        width: 55,
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
                            suggestion['photourl'],
                            fit: BoxFit.cover,
                          ),
                        )),
                    Padding(padding: EdgeInsets.only(right: 15)),
                    Text(
                      suggestion['name'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // При нажатии на предложение, переходим к результатам поиска
                query = suggestion['name'];
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}
