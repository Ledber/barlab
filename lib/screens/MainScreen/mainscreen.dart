// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:barlab/screens/CocktailesScreen/cocktailesList.dart';
import 'package:barlab/screens/DrawerScreens/feedback.dart';
import 'package:barlab/screens/DrawerScreens/profile.dart';
import 'package:barlab/screens/MainScreen/filter.dart';
import 'package:barlab/services/imageService.dart';
import 'package:barlab/services/searchService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../DrawerScreens/updatesscreen.dart';

class mainscreen extends StatelessWidget {
  const mainscreen({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: _title,
        home: Scaffold(
          body: mainscreenS(),
        ));
  }
}

class mainscreenS extends StatefulWidget {
  const mainscreenS({super.key});

  @override
  State<mainscreenS> createState() => _mainscreenSState();
}

class _mainscreenSState extends State<mainscreenS> {
  String? uid;
  String name = '';
  String email = '';
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Cocktails(optionStyle: optionStyle),
    Home(optionStyle: optionStyle),
    Folder(optionStyle: optionStyle),
  ];
  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        uid = currentUser.uid;
      });
    }
    getUserData();
  }

  void getUserData() async {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      // String? name;
      if (userSnapshot != null) {
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;
        if (userData != null) {
          name = userData['name'];
          email = userData['email'];
        }
        if (name == null) {
          throw Exception('Name is null');
        }
      } else {
        throw Exception('User snapshot is null');
      }
      // email = userSnapshot.data()['email'];
    });
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            showSearch(context: context, delegate: MySearchDelegate());
          },
        ),
        title: const Text(
          'BarLab',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      endDrawer: FutureBuilder<DocumentSnapshot>(
        future: getUserDocument(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userDoc = snapshot.data!;
            return Drawer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        SizedBox(
                          height: 236,
                          child: DrawerHeader(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 25, bottom: 5),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Меню',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _closeDrawer,
                                      icon: Icon(Icons.close),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => new profile(
                                                  name: name,
                                                  email: email,
                                                )));
                                  },
                                  // Handle your callback
                                  child: Container(
                                    height: 72,
                                    padding: EdgeInsets.only(
                                        top: 8, bottom: 8, left: 0),
                                    margin: EdgeInsets.zero,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              Color.fromARGB(255, 112, 0, 0),
                                          radius: 40,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                userDoc['avatar_url']),
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '$name',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(), // Добавляем Spacer, чтобы Icon был прижат к правому краю
                                              Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 5))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 1))),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new updatesscreen()));
                            },
                            leading: ImageIcon(
                              AssetImage(
                                  'assets/images/cc234d937e5a99a2ab7baa1fcd6076f120422d65.png'),
                              color: Colors.black,
                            ),
                            title: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Обновления',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 15, right: 15),
                          height: 55,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      width: 1))),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new feedback()));
                            },
                            textColor: Colors.black,
                            leading: ImageIcon(
                              AssetImage(
                                  'assets/images/ab152861dce10d266884ae61af983f64d8be5ab2.png'),
                              color: Colors.black,
                            ),
                            title: Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Обратная связь',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 1))),
                    child: Text(
                      'v.1.0.0',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 5),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          CustomNavBarElement(icon: Icon(Icons.local_bar)),
          CustomNavBarElement(icon: Icon(Icons.home)),
          CustomNavBarElement(icon: Icon(Icons.folder)),
          // CustomNavBarElement(icon: Icon(Icons.add_call)),
        ],
      ),
    );
  }
}

class Folder extends StatelessWidget {
  const Folder({
    super.key,
    required this.optionStyle,
  });

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        folderItem(
          image: Image.asset(
            'assets/images/682298a31b4f39cb1a91498d3bdd64eb9d8ac335.png',
            fit: BoxFit.cover,
          ),
          label: 'Методы',
        ),
        folderItem(
          image: Image.asset(
            'assets/images/c9c93afac9cba6698ad62fe37ee47c587e50c8a4.png',
            fit: BoxFit.cover,
          ),
          label: 'Бокалы',
        ),
        folderItem(
          image: Image.asset(
            'assets/images/ab2fe2ad0b7dbb31d3a96072c13b85ca4ef959c6.png',
            fit: BoxFit.cover,
          ),
          label: 'Инвентарь',
        ),
        folderItem(
          image: Image.asset(
            'assets/images/98a243a5b4599e4e25cf908d8dc717ec6dfda602.png',
            fit: BoxFit.cover,
          ),
          label: 'Алкоголь',
        ),
        folderItem(
          image: Image.asset(
            'assets/images/23731bd5b7ecc6b8156184acaa7b79a5287735c2.png',
            fit: BoxFit.cover,
          ),
          label: 'Классификация',
        ),
      ],
    );
  }
}

class folderItem extends StatelessWidget {
  folderItem({
    super.key,
    required this.image,
    required this.label,
  });
  final Image image;
  var label = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(2),
      // color: Colors.teal[200],
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(5),
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
              color: Color.fromARGB(255, 16, 0, 48),
            ),
            child: image,
          ),
          Container(
            // height: double.infinity,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.optionStyle,
  });

  final TextStyle optionStyle;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          homeWidget(
            image: Image.asset(
                'assets/images/17bdd80d6ae719c33a18e01006160acfc8881d78.png'),
            label: Text(
              'Все коктейли',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black),
            ),
            onTap: () => Navigator.of(context, rootNavigator: true)
                .pushNamed("/cocktailesList"),
          ),
          homeWidget(
            image: Image.asset(
                'assets/images/55b11db40637ae79ba07ebefcb511723093c0534.png'),
            label: Text(
              'В разработке',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 22, color: Colors.red),
            ),
            onTap: () {},
          ),
          homeWidget(
            image: Image.asset(
                'assets/images/55b11db40637ae79ba07ebefcb511723093c0534.png'),
            label: Text(
              'В разработке',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 22, color: Colors.red),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }
}

class homeWidget extends StatelessWidget {
  final Image image;
  final Text label;
  final VoidCallback onTap;
  // final MaterialPageRoute route;
  const homeWidget({
    required this.image,
    required this.label,
    required this.onTap,
    // required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(15),
        width: double.infinity,
        height: 270,
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.all(5),
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
              color: Color.fromARGB(255, 16, 0, 48),
            ),
            child: image,
          ),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
              padding: EdgeInsets.all(4),
              width: 80,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                // border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                color: Color.fromARGB(255, 16, 0, 48),
              ),
              child: Text(
                'Подборка',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white),
              )),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  ),
              child: label),
        ]),
      ),
    );
  }
}

class CustomNavBarElement extends StatelessWidget {
  final Icon icon;

  const CustomNavBarElement({required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      height: double.infinity,
      child: icon,
    );
  }
}

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNavBar({
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.height,
    Key? key,
  }) : super(key: key);

  final List<CustomNavBarElement> items;
  final ValueChanged<int>? onTap;
  final int currentIndex;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: preferredSize.height,
      decoration:
          const BoxDecoration(border: Border(top: BorderSide(width: 2))),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            items.length,
            (index) => Expanded(
              child: InkWell(
                onTap: () {
                  if (onTap != null) onTap!(index);
                },
                child: Theme(
                    data: theme.copyWith(
                        colorScheme: theme.colorScheme.copyWith(
                          background: index == currentIndex
                              ? Colors.black
                              : Colors.white,
                        ),
                        iconTheme: theme.iconTheme.copyWith(
                          color: index == currentIndex
                              ? Colors.white
                              : Colors.black,
                        )),
                    child: items[index]),
              ),
            ),
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 55);
}
