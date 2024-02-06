import 'package:daily_plan/entity/plan_entity.dart';
import 'package:isar/isar.dart';

part 'project_entity.g.dart';

@collection
class ProjectEntity {
  String? name;
  List<String>? flow;
  Id id = Isar.autoIncrement;
  DateTime? createTime;
  final plans = IsarLinks<PlanEntity>();
}