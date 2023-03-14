// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class startscreen extends StatelessWidget {
  const startscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image(
                  image: AssetImage(
                      'assets/images/b38bcee06045ad1b2bffed237127a355d4ffe61f.png'),
                  width: 240,
                  height: 240,
                )),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              height: 56,
              child: Text(
                'BarLabs',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: SizedBox(
                  width: 292, // <-- Your width
                  height: 56, // <-- Your height

                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                            width: 2.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/loginscreen');
                      },
                      child: Text(
                        'Войти',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))),
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: SizedBox(
                    width: 292, // <-- Your width
                    height: 56, // <-- Your height
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0),
                              width: 2.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signupscreen');
                        },
                        child: Text(
                          'Регистрация',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )))),
          ],
        )),
      ),
    );
  }
}
