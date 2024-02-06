import 'package:daily_plan/common/http_net.dart';
import 'package:daily_plan/entity/app_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  AppVersion._();
  static String currentVersion = '';
  static String latestVersion = '';
  static bool isUpdateRequired = false;
  static AppEntity? appInfo;
  static Future<bool> checkUpdate()async{
    try{
      debugPrint('checkUpdate::::::::');
      final packageInfo = await PackageInfo.fromPlatform();
      currentVersion = packageInfo.version;
      final appUpdateInfo = await HttpNet.getAppLatestMsg();
      if (appUpdateInfo == null) return false;
      appInfo = appUpdateInfo;
      latestVersion = appInfo!.tagName ?? appInfo!.name!;
      debugPrint('currentVersion:::$currentVersion----latestVersion::::$latestVersion');
      isUpdateRequired = currentVersion.compareTo(latestVersion) < 0;
      debugPrint('UpdateRequired:::$isUpdateRequired');
      return isUpdateRequired;
    }catch(e){
      debugPrint('checkUpdate:error:::::::$e');
      return false;
    }
  }
}