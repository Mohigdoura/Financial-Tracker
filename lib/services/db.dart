import 'package:shared_preferences/shared_preferences.dart';

class Db {
  Future<List<int>> getList() async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('list');
    if (list == null) {
      return [];
    }
    return list.map((e) => int.parse(e)).toList();
  }

  Future<void> addToDB(int val) async {
    final pref = await SharedPreferences.getInstance();
    final list = pref.getStringList('list');
    if (list == null) {
      pref.setStringList('list', [val.toString()]);
    } else {
      list.add(val.toString());
      pref.setStringList('list', list);
    }
  }
}
