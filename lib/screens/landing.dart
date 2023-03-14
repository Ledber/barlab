import 'package:barlab/screens/MainScreen/mainscreen.dart';
import 'package:barlab/screens/StartScreen/startscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:barlab/domains/entity/user.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final Users? user = Provider.of<Users?>(context);
    final bool isLoggedIn = user != null;
    // ignore: dead_code
    return isLoggedIn ? mainscreen() : startscreen();
  }
}
