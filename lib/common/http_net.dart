import 'dart:convert';
import 'package:daily_plan/entity/app_entity.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

class HttpNet {
  HttpNet._();

  static Future<String?> getBingWallPaper()async{
    final response = await http.get(Uri.parse(Constant.bingWallPaper));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['url'].toString();
    }
    return null;
  }

  static Future<AppEntity?> getAppLatestMsg()async{
    final response = await http.get(Uri.parse(Constant.appLatestUrl));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return AppEntity.fromJson(data);
    }
    return null;
  }
}