// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:barlab/screens/MainScreen/mainscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cocktailesMain extends StatelessWidget {
  const cocktailesMain({super.key, required this.cocktail});
  final DocumentSnapshot cocktail;

// bool toggle1 = false;
  @override
  Widget build(BuildContext context) {
    List<dynamic> ingredients = cocktail['ingredients'];
    List<dynamic> ingredientsPortion = cocktail['ingredientsPortion'];
    print(ingredients[2]);
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              height: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.black, width: 2, style: BorderStyle.solid),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                      color: Color.fromARGB(255, 16, 0, 48),
                    ),
                    child: Image.network(
                      cocktail['photourl'],
                      fit: BoxFit.contain,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          cocktail['name'],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   margin: EdgeInsets.only(top: 10),
                      //   // child: IconButton(
                      //   //   icon: Icon(
                      //   //     Icons.star_border_outlined,
                      //   //   ),
                      //   //   onPressed: () {},
                      //   // ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              // height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.black, width: 2, style: BorderStyle.solid),
                color: Colors.white,
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
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin:
                              EdgeInsets.only(left: 15, top: 15, bottom: 10),
                          child: Text(
                            'Стакан:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(
                            'Вкус:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 15, bottom: 15),
                          child: Text(
                            'Метод:',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          margin:
                              EdgeInsets.only(right: 15, top: 15, bottom: 10),
                          child: Text(
                            cocktail['glass'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 15, bottom: 10),
                          child: Text(
                            cocktail['taste'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 15, bottom: 15),
                          child: Text(
                            cocktail['method'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
  margin: EdgeInsets.all(15),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(
      color: Colors.black,
      width: 2,
      style: BorderStyle.solid
    ),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black,
        blurRadius: 4,
        offset: Offset(2, 2), // changes position of shadow
      ),
    ],
  ),
  child: IntrinsicHeight(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(2),
          padding: EdgeInsets.all(5),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Color.fromARGB(255, 16, 0, 48),
          ),
          child: Text(
            'Ингредиенты',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        Expanded(
        
          // child: Padding(
            // padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String ingredient in ingredients)
                          ListTile(
                            title: Text(
                              ingredient,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (String ingredientPortion in ingredientsPortion)
                          ListTile(
                            title: Text(
                              
                              ingredientPortion,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 20,
                                
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          // ),
        ),
      ],
    ),
  ),
),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.black, width: 2, style: BorderStyle.solid),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                      color: Color.fromARGB(255, 16, 0, 48),
                    ),
                    child: Text(
                      'Украшения',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 15, top: 10, bottom: 15),
                    child: Text(
                      cocktail['decor'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              // height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: Colors.black, width: 2, style: BorderStyle.solid),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 4,
                    offset: Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                      color: Color.fromARGB(255, 16, 0, 48),
                    ),
                    child: Text(
                      'Приготовление',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 15, top: 10, bottom: 15),
                    child: Text(
                       cocktail['cooking'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
