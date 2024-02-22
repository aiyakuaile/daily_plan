import 'package:common_utils/common_utils.dart';
import 'package:daily_plan/common/http_net.dart';
import 'package:daily_plan/utils/prefs_util.dart';
import 'package:flutter/material.dart';

const backgroundOpacityKey = 'backgroundOpacity';
const backgroundPathKey = 'customBackgroundImagePath';

class ThemeProvider with ChangeNotifier {

  double _backgroundOpacity = 0.5;

  double get backgroundOpacity => _backgroundOpacity;

  set backgroundOpacity(double value) {
    _backgroundOpacity = value;
    PrefsUtil.setDouble(backgroundOpacityKey, value);
    notifyListeners();
  }


  String? _customBackgroundImagePath;

  String get customBackgroundImagePath => _customBackgroundImagePath ?? '';

  String? _bingNetImageUrl;

  set customBackgroundImagePath(String? value) {
    if(ObjectUtil.isEmpty(value)){
      if(ObjectUtil.isEmpty(_bingNetImageUrl)){
        _loadBgFromNet();
      }else{
        customBackgroundImagePath = _bingNetImageUrl!;
      }
      return;
    }
    _customBackgroundImagePath = value!;
    if(value.startsWith('http')){
      PrefsUtil.remove(backgroundPathKey);
    }else{
      PrefsUtil.setString(backgroundPathKey, value);
    }
    notifyListeners();
  }

  loadTheme(){
    _loadBgImg();
    _loadBackgroundOpacity();
  }

  _loadBackgroundOpacity() async {
    final res = await PrefsUtil.getDouble(backgroundOpacityKey);
    if(res != null){
      backgroundOpacity = res;
    }
  }

  _loadBgImg() async {
    final res = await PrefsUtil.getString(backgroundPathKey);
    if(res == null){
      await _loadBgFromNet();
    }else{
      customBackgroundImagePath = res;
    }
  }

  _loadBgFromNet() async {
    final url = await HttpNet.getBingWallPaper();
    if (ObjectUtil.isNotEmpty(url)) {
      _bingNetImageUrl = url!;
      customBackgroundImagePath = url;
    }
  }
}