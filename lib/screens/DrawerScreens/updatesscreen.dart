// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class updatesscreen extends StatelessWidget {
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
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    child: Text(
                      'Обновление v1.0',
                      //  textAlign: TextAlign.center ,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    // alignment: Alignment.center,
                    child: Text(
                      'Разработано приложение, добавлено [неразбочиво], обновлено [неразбочиво], исправлено [неразбочиво].',
                      // textAlign: TextAlign.center ,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage(
                      'assets/images/cc234d937e5a99a2ab7baa1fcd6076f120422d65.png'),
                  width: 230,
                  height: 230,
                  color: Colors.grey,
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 40),
            ),
          ],
        ),
      ),
    );
  }
}
