

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static late final SharedPreferences prefs;

  static Future<void> init()async {
    prefs = await SharedPreferences.getInstance();
  }
  static Future<bool> saveBool(bool flag) async{
    return await prefs.setBool('introduction', flag);

  }


  static bool? getBool(String key) {
    return prefs.getBool(key);

  }


  static Future<void> saveList(int index) async{
    var previousList=getList("items");
    previousList.add(index);
    var data=previousList.map((e)=>e.toString()).toList()??[];
    await prefs.setStringList('items', data);

  }
  static List<int> getList(String key){
    List<String>? data= prefs.getStringList(key);
    return data?.map((e)=> int.parse(e)).toSet().toList() ??[];
  }
}
