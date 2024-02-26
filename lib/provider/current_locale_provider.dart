import 'package:daily_plan/utils/prefs_util.dart';
import 'package:flutter/material.dart';

class CurrentLocaleProvider with ChangeNotifier {
  static String? langCode;
  Locale? _locale;
  Locale? get value {
    if(_locale == null && langCode != null && langCode!.isNotEmpty){
      _locale = Locale(langCode!);
    }
    return _locale;
  }
  setLocale(Locale value,{bool notify = true})async{
    if(value.languageCode != _locale?.languageCode){
      _locale = value;
      if(!notify) return;
        await PrefsUtil.setString('lang', value.languageCode);
        notifyListeners();
    }
  }
}