// import 'package:barlab/domains/profile.dart';
import 'package:barlab/domains/entity/user.dart';
import 'package:barlab/screens/CocktailesScreen/cocktailesList.dart';
import 'package:barlab/screens/CocktailesScreen/cocktailesMain.dart';
import 'package:barlab/screens/DrawerScreens/addCocktail.dart';
import 'package:barlab/screens/DrawerScreens/feedback.dart';
import 'package:barlab/screens/DrawerScreens/profile.dart';
import 'package:barlab/screens/landing.dart';
import 'package:barlab/screens/test.dart';
import 'package:barlab/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:barlab/screens/StartScreen/startscreen.dart';
import 'package:barlab/screens/LoginScreen/loginscreen.dart';
import 'package:barlab/screens/SignupScreen/signupscreen.dart';
import 'package:barlab/screens/MainScreen/mainscreen.dart';
import 'package:barlab/screens/DrawerScreens/updatesscreen.dart';
import 'package:provider/provider.dart';
import 'package:barlab/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BarLab());
}

class BarLab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        StreamProvider<Users?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BarLab Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: '/mainscreen',
        initialRoute: '/landing',
        // initialRoute: '/startscreen',
        // initialRoute: '/test',
        routes: {
          '/startscreen': (context) => startscreen(),
          '/loginscreen': (context) => loginscreen(),
          '/signupscreen': (context) => signupscreen(),
          '/mainscreen': (context) => mainscreen(),
          '/updatesscreen': (context) => updatesscreen(),
          '/feedback': (context) => feedback(),
          '/cocktailesList': (context) => ctListt(),
          '/landing': (context) => Landing(),
          '/addCocktail': (context) => addCocktail(),
          '/test': (context) => test(),
        },
      ),
    );

    // ignore: prefer_const_constructors
  }
}
