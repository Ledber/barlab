import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static Future<List<String>> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final items = prefs.getStringList('items') ?? [];
    return items;
  }

  static Future<void> saveItems(List<String> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', items);
  }
}
