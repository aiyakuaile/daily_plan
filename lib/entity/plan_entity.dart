import 'package:isar/isar.dart';

part 'plan_entity.g.dart';

@collection
class PlanEntity {
  Id id = Isar.autoIncrement;
  String? content;
  List<String> label = [];
  String? remark;
  DateTime? createTime;
  DateTime? updateTime;
  int status = 0;
  bool isMoving = false;


  @override
  String toString() {
    return 'PlanEntity(id:$id,content:$content,label:$label,remark:$remark,createTime:$createTime,updateTime:$updateTime,status:$status)';
  }
}
