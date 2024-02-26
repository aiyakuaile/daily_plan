import 'package:daily_plan/entity/plan_entity.dart';
import 'package:daily_plan/entity/project_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarUtil {
  IsarUtil._();
  static IsarUtil? _instance;
  Isar? isar;
  factory IsarUtil() {
    _instance ??= IsarUtil._();
    return _instance!;
  }

  Future<bool> initIsarData()async{
    if(isar == null){
      final dir = await getLibraryDirectory();
      isar = await Isar.open(
        [ProjectEntitySchema,PlanEntitySchema],
        directory: dir.path,
        inspector:false
      );
    }
    return true;
  }

  Future<List<ProjectEntity>> getAllProjects()async{
    assert(isar != null,'isar must instance');
    return isar!.projectEntitys.where().sortByCreateTimeDesc().findAll();
  }

  Future<bool> deleteProject(ProjectEntity entity)async{
    final ids = entity.plans.map((e) => e.id).toList();
    debugPrint('ids===========$ids');
    return isar!.writeTxn(() async {
      await isar!.planEntitys.deleteAll(ids);
      return isar!.projectEntitys.delete(entity.id);
    });
  }

  Future<int> saveProject(ProjectEntity entity)async{
    return isar!.writeTxn(() async {
      return isar!.projectEntitys.put(entity);
    });
  }

  Future<List<PlanEntity>> getAllPlans(Id projectId)async{
    assert(isar != null,'isar must instance');
    final plans = await (await isar!.projectEntitys.get(projectId))?.plans.filter().sortByCreateTimeDesc().findAll();
    return plans ?? <PlanEntity>[];
  }

  Future<List<PlanEntity>> getStatusPlans(ProjectEntity entity,int status)async{
    assert(isar != null,'isar must instance');
    final plans = await entity.plans.filter().statusEqualTo(status).sortByUpdateTimeDesc().findAll();
    return plans;
  }

  Future<bool> deletePlan(PlanEntity entity)async{
    return isar!.writeTxn(() async {
      return isar!.planEntitys.delete(entity.id);
    });
  }

  Future<bool> savePlan(Id projectId,PlanEntity entity)async{
    final project = await isar!.projectEntitys.get(projectId);
    return isar!.writeTxn(()async{
      await isar!.planEntitys.put(entity);
      project!.plans.add(entity);
      project.plans.save();
      return Future.value(true);
    });
  }

  Future<bool> updatePlan(PlanEntity entity)async{
    return isar!.writeTxn(()async{
      isar!.planEntitys.put(entity);
      return Future.value(true);
    });
  }


  Future<void> closeIsar(){
    return isar!.writeTxn(()async => isar!.clear());
  }
}