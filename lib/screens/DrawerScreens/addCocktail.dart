import 'dart:ffi';
import 'dart:io';

import 'package:barlab/services/addCocktailService.dart';
import 'package:barlab/services/imageService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class addCocktail extends StatefulWidget {
  const addCocktail({super.key});

  @override
  State<addCocktail> createState() => _addCocktailState();
}

class _addCocktailState extends State<addCocktail> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  late String _imageURL;
  String _name = '';
  String _type = '';
  String _taste = '';
  String _method = '';
  String _glass = '';
  List<String> _ingredients = [];
  List<String> _proportions = [];
  String _decoration = '';
  String _recipe = '';
  bool _hasBrandy = false;
  bool _hasLiquor = false;
  bool _hasWine = false;
  bool _hasJin = false;
  bool _hasVodka = false;
  bool _hasWhiskey = false;
  bool _hasRum = false;
  bool _hasTequla = false;
  bool _isSweet = false;
  bool _isSour = false;
  bool _isBitter = false;
  bool _isLong = false;
  bool _isShort = false;
  bool _isShot = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _tasteController = TextEditingController();
  TextEditingController _methodController = TextEditingController();
  TextEditingController _glassController = TextEditingController();
  TextEditingController _ingredientsController = TextEditingController();
  TextEditingController _proportionsController = TextEditingController();
  TextEditingController _decorationController = TextEditingController();
  TextEditingController _recipeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'BarLab',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    setState(() {
                      _imageFile = File(pickedFile!.path);
                    });
                    _imageURL = (await uploadCocktailImage(_imageFile!))!;
                    print(_imageURL);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    width: 150,
                    height: 150,
                    child: _imageFile != null
                        ? Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text('Tap to add image'),
                          ),
                  ),
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Название Коктейля'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _name = value ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: _typeController,
                  decoration: InputDecoration(labelText: 'Тип коктейля'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите тип коктейля';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _type = value ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: _tasteController,
                  decoration: InputDecoration(labelText: 'Вкус'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите вкус коктейля';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _taste = value ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: _methodController,
                  decoration: InputDecoration(labelText: 'Метод приготовления'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите метод приготовления';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _method = value ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: _glassController,
                  decoration: InputDecoration(labelText: 'Стекло'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите тип стекла, используемого для коктейлей';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _glass = value ?? '';
                    });
                  },
                ),

                Wrap(
                  spacing: 8,
                  children: _ingredients.map((value) {
                    return Chip(
                      label: Text(value),
                      onDeleted: () {
                        setState(() {
                          _ingredients.remove(value);
                        });
                      },
                    );
                  }).toList(),
                ),

// Поле для ввода нового значения
                TextField(
                  controller: _ingredientsController,
                  onSubmitted: (value) {
                    setState(() {
                      _ingredients.add(value);
                      print(_ingredients);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Добавте ингредиенты'),
                ),
                Wrap(
                  spacing: 8,
                  children: _proportions.map((value) {
                    return Chip(
                      label: Text(value),
                      onDeleted: () {
                        setState(() {
                          _proportions.remove(value);
                        });
                      },
                    );
                  }).toList(),
                ),

// Поле для ввода нового значения
                TextField(
                  controller: _proportionsController,
                  onSubmitted: (value) {
                    setState(() {
                      _proportions.add(value);
                      print(_proportions);
                    });
                  },
                  decoration: InputDecoration(labelText: 'Добавте пропорцию'),
                ),
                TextFormField(
                  controller: _decorationController,
                  decoration: InputDecoration(labelText: 'Украшение'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите украшение коктейля';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _decoration = value ?? '';
                    });
                  },
                ),
                TextFormField(
                  controller: _recipeController,
                  decoration: InputDecoration(labelText: 'Рецепт'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите рецепт приготовления';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      _recipe = value ?? '';
                    });
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  // height: 460,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
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
                      CheckboxListTile(
                        title: Text('Бренди'),
                        value: _hasBrandy,
                        onChanged: (value) {
                          setState(() {
                            _hasBrandy = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Ликер'),
                        value: _hasLiquor,
                        onChanged: (value) {
                          setState(() {
                            _hasLiquor = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Вино'),
                        value: _hasWine,
                        onChanged: (value) {
                          setState(() {
                            _hasWine = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Джин'),
                        value: _hasJin,
                        onChanged: (value) {
                          setState(() {
                            _hasJin = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Водка'),
                        value: _hasVodka,
                        onChanged: (value) {
                          setState(() {
                            _hasVodka = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Виски'),
                        value: _hasWhiskey,
                        onChanged: (value) {
                          setState(() {
                            _hasWhiskey = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Ром'),
                        value: _hasRum,
                        onChanged: (value) {
                          setState(() {
                            _hasRum = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Текила'),
                        value: _hasTequla,
                        onChanged: (value) {
                          setState(() {
                            _hasTequla = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  // height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
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
                      CheckboxListTile(
                        title: Text('Сладкий'),
                        value: _isSweet,
                        onChanged: (value) {
                          setState(() {
                            _isSweet = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Кислый'),
                        value: _isSour,
                        onChanged: (value) {
                          setState(() {
                            _isSour = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Горький'),
                        value: _isBitter,
                        onChanged: (value) {
                          setState(() {
                            _isBitter = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  // height: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: Colors.black,
                        width: 2,
                        style: BorderStyle.solid),
                    color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
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
                      CheckboxListTile(
                        title: Text('Лонг'),
                        value: _isLong,
                        onChanged: (value) {
                          setState(() {
                            _isLong = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Шорт'),
                        value: _isShort,
                        onChanged: (value) {
                          setState(() {
                            _isShort = value ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: Text('Шот'),
                        value: _isShot,
                        onChanged: (value) {
                          setState(() {
                            _isShot = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
// Add the cocktail to the database
                        addCocktailToFirestore(
                            _name,
                            _type,
                            _taste,
                            _method,
                            _glass,
                            _ingredients,
                            _proportions,
                            _decoration,
                            _recipe,
                            _hasBrandy,
                            _hasLiquor,
                            _hasWine,
                            _hasJin,
                            _hasVodka,
                            _hasWhiskey,
                            _hasRum,
                            _hasTequla,
                            _isSweet,
                            _isSour,
                            _isBitter,
                            _isLong,
                            _isShort,
                            _isShot,
                            _imageURL);
                        _nameController.clear();
                        _typeController.clear();
                        _tasteController.clear();
                        _methodController.clear();
                        _glassController.clear();
                        _ingredientsController.clear();
                        _proportionsController.clear();
                        _decorationController.clear();
                        _recipeController.clear();
                        _hasBrandy = false;
                        _hasLiquor = false;
                        _hasWine = false;
                        _hasJin = false;
                        _hasVodka = false;
                        _hasWhiskey = false;
                        _hasRum = false;
                        _hasTequla = false;
                        _isSweet = false;
                        _isSour = false;
                        _isBitter = false;
                        _isLong = false;
                        _isShort = false;
                        _isShot = false;
                      }
                      Fluttertoast.showToast(
                        msg: "Коктейль успешно добавлен",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER_RIGHT,
                        // timeInSecForIosWeb: 2,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                    },
                    child: Text('Add Cocktail'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
