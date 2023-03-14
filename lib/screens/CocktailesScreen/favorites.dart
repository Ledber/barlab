import 'dart:convert';

import 'package:barlab/screens/CocktailesScreen/cocktailesMain.dart';
import 'package:barlab/services/storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListViewPage extends StatefulWidget {
  final List<Map<String, dynamic>> items;

  const ListViewPage({Key? key, required this.items}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
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
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          // final Map<String, dynamic> data = widget.items[index];
// final  id = data['DOCid'];
          final id = item['DOCid'];
          print(item);
          // print(data);
          final cocktail =
              FirebaseFirestore.instance.collection('coctailes').doc(id).get();
          return InkWell(
            onTap: () async {
              DocumentSnapshot<Map<String, dynamic>> doc =
                  await FirebaseFirestore.instance
                      .collection('coctailes')
                      .doc(id)
                      .get();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => cocktailesMain(cocktail: doc)));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              height: 155,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.black, width: 2, style: BorderStyle.solid),
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
                            item['photourl'],
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
                              item['type'],
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
                              item['name'],
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
                              'Вкус:' + item['taste'],
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
                              'Метод:' + item['method'],
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
                              'Стакан:' + item['glass'],
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
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.items.removeAt(index);
                              Storage.saveItems(widget.items
                                  .map((item) => json.encode(item))
                                  .toList());
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
      ),
    );
  }
}
