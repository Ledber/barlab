import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/searchService.dart';

class test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Search Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<HomePage> {
  late final CollectionReference _collectionRef;
  @override
  void initState() {
    super.initState();
    _collectionRef = FirebaseFirestore.instance.collection('coctailes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Search Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Search'),
          onPressed: () {
            showSearch(
              context: context,
              delegate: MySearchDelegate(),
            );
          },
        ),
      ),
    );
  }
}

