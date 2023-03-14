// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class feedback extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  void _sendFeedback(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    if (user == null) {
      // User is not signed in
      Fluttertoast.showToast(
        msg: "Вы не вошли в аккаунт",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        // timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16, 
      );
      return;
    }

    final String feedbackText = textController.text.trim();

    if (feedbackText.isEmpty) {
      // Feedback text is empty
      Fluttertoast.showToast(
        msg: "Нельзя отправить пустой отзыв",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        // timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16, 
      );
      return;
    }

    // Add feedback to Firestore
    final CollectionReference feedbacks =
        FirebaseFirestore.instance.collection('feedbacks');
    await feedbacks.add({
      'userId': user.uid,
      'text': feedbackText,
    });

    // Show feedback sent message
   Fluttertoast.showToast(
        msg: "Отзыв успешно отправлен",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
        // timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16, 
      );

    // Clear text field
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 16, 0, 48),
                    ),
                    child: Text(
                      'Опишите вашу проблему или пожелания',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                        controller: textController,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(width: 2.0, color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(255, 117, 172, 255)),
                          ),
                        ),
                        maxLines: 7,
                        minLines: 7),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Container(
                          // margin: EdgeInsets.all(20 ),

                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 195, // <-- Your width
                            height: 56,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 16, 0, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                onPressed: ()  {
                                  _sendFeedback(context);
                                
                                },
                                child: const Text(
                                  'Отправить',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage(
                      'assets/images/ab152861dce10d266884ae61af983f64d8be5ab2.png'),
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
