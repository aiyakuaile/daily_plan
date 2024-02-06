import 'package:common_utils/common_utils.dart';

class AppEntity {
  AppEntity({
      this.id, 
      this.tagName, 
      this.name, 
      this.publishedAt, 
      this.body,});

  AppEntity.fromJson(dynamic json) {
    id = json['id'];
    tagName = json['tag_name'];
    name = json['name'];
    if(ObjectUtil.isNotEmpty(json['published_at'])){
      publishedAt = DateUtil.formatDateStr(json['published_at'],format: DateFormats.full);
    }
    body = json['body'];
  }
  num? id;
  String? tagName;
  String? name;
  String? publishedAt;
  String? body;
}