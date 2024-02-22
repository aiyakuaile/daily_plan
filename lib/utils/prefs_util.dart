import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  PrefsUtil._();
  static late SharedPreferences _prefs;
  static init()async{
    _prefs = await SharedPreferences.getInstance();
  }
  static Future<bool> setString(String key,String value)async{
    return _prefs.setString(key, value);
  }
  static Future<String?> getString(String key)async{
    return _prefs.getString(key);
  }
  static Future<bool> setDouble(String key,double value)async{
    return _prefs.setDouble(key, value);
  }
  static Future<double?> getDouble(String key)async{
    return _prefs.getDouble(key);
  }

  static Future<bool> setInt(String key,int value)async{
    return _prefs.setInt(key, value);
  }
  static Future<int?> getInt(String key)async{
    return _prefs.getInt(key);
  }

  static Future<bool> setBool(String key,bool value)async{
    return _prefs.setBool(key, value);
  }
  static Future<bool?> getBool(String key)async{
    return _prefs.getBool(key);
  }

  static Future<bool> remove(String key)async{
    return _prefs.remove(key);
  }

}