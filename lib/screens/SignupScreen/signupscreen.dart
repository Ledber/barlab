// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:barlab/domains/entity/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:barlab/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../MainScreen/mainscreen.dart';

class signupscreen extends StatelessWidget {
  const signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        body: const signupscreenS(),
      ),
    );
  }
}

class signupscreenS extends StatefulWidget {
  const signupscreenS({super.key});
  @override
  signupscreenState createState() {
    return signupscreenState();
  }
}

class signupscreenState extends State<signupscreenS> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  late String _email;
  late String _password;
  late String _name;
  AuthService _authService = AuthService();
  void registerButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    _name = _nameController.text;
    if (_email.isEmpty || _password.isEmpty || _name.isEmpty) return;
    Users user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim(), _name.trim());
    if (user == null) {
      Fluttertoast.showToast(
        msg: "Невозможно войти",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_LEFT,
        // timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16,
      );
    }
    Navigator.of(
      context,
      rootNavigator: true,
    ).pop(
      context,
    );
    //   else{
    //     Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //     builder: (context) => new mainscreen()));
    // }
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 80)),
                      Container(
                        margin: EdgeInsets.only(left: 35),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358,
                          child: Text(
                            'Имя',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358,
                          //  height: 72,

                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                ),
                              hintText: 'Введите имя',
                            ),
                           validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите логин';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35, top: 20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358,
                          child: Text(
                            'EMAIL',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358,
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                ),
                              hintText: 'Введите почту',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите логин';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35, top: 20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358,
                          child: Text(
                            'Пароль',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358,
                          child: TextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                               ),
                              hintText: 'Введите пароль',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Пожалуйста, введите пароль';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                activeColor: Colors.red,
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                }),
                            Container(
                               child: SizedBox(
                                // width: 358,
                                // height: 20,
                                child: Text(
                                  'Подтверждаю, что мне исполнилось 18 лет',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 170)),
                      Container(
                        margin: EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 358, // <-- Your width
                          height: 56,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 16, 0, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              onPressed: _isChecked
                                  ? () {
                                      if (_formKey.currentState!.validate()) {
                                        registerButtonAction();
                                        }
                                    }
                                  : null,
                              child: const Text(
                                'Зарегистрироваться',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 20, top: 0),
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 358, // <-- Your width
                            height: 56, // <-- Your height

                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop(
                                    context,
                                  );
                                },
                                child: Text(
                                  'Назад',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
