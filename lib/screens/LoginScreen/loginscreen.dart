// ignore_for_file: camel_case_types, prefer_const_constructors, use_build_context_synchronously

// import 'package:barlab/domains/profile.dart';
import 'package:barlab/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:barlab/domains/entity/user.dart';

import '../MainScreen/mainscreen.dart';

class loginscreen extends StatelessWidget {
  const loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        body: const loginscreenS(),
      ),
    );
  }
}

class loginscreenS extends StatefulWidget {
  const loginscreenS({super.key});
  @override
  loginscreenState createState() {
    return loginscreenState();
  }
}

class loginscreenState extends State<loginscreenS> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late String _email;
  late String _password;
  AuthService _authService = AuthService();
  void loginButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    if (_email.isEmpty || _password.isEmpty) return;
    Users? user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
        msg: "Невозможно войти",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER_RIGHT,
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
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 150)),
                  Container(
                    margin: EdgeInsets.only(left: 35),
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
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 358,
                      //  height: 72,

                      child: TextFormField(
                        controller: _emailController,

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            //  borderSide: BorderSide(color: Color.fromARGB(255, 156, 173, 1), width: 20),
                          ),
                          hintText: 'Введите почту',
                        ),
                        // The validator receives the text that the user has entered.
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
                    //  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 358,
                      //  height: 72,

                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            //  borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 20),
                          ),
                          hintText: 'Введите пароль',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста, введите пароль';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 230)),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginButtonAction();

                            }
                          
                          },
                          child: const Text(
                            'Войти',
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
    );
  }
}
