import 'package:daily_plan/entity/plan_entity.dart';
import 'package:daily_plan/entity/project_entity.dart';
import 'package:daily_plan/page/home/plan_input_page.dart';
import 'package:daily_plan/provider/theme_provider.dart';
import 'package:daily_plan/utils/extension.dart';
import 'package:daily_plan/utils/isar_util.dart';
import 'package:daily_plan/widget/plan_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final ProjectEntity projectEntity;

  const HomePage(this.projectEntity, {super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double itemWidth = 0;

  List<List<PlanEntity>> planEntities = [];

  @override
  void initState() {
    _loadPlanData();
    super.initState();
  }

  _loadPlanData() async {
    final res = await Future.wait(widget.projectEntity.flow!.mapWithIndex((index, value) {
      return IsarUtil().getStatusPlans(widget.projectEntity, index);
    }));
    setState(() {
      planEntities = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final flows = widget.projectEntity.flow!;
          itemWidth = (constraints.maxWidth - (flows.length + 1) * 10) / flows.length - 20;
          return planEntities.isEmpty
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: flows.mapWithIndex((index, value) {
                      return _createListView(planEntities[index], value, index);
                    }).toList(),
                  ),
                );
        },
      ),
    );
  }

  Widget _createListView(List<PlanEntity> items, String title, int index) {
    final scrollController = ScrollController();
    return Expanded(
      child: Container(
        height: double.infinity,
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        decoration: BoxDecoration(color: Colors.black.withOpacity(context.watch<ThemeProvider>().backgroundOpacity), borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
              Stack(
                alignment: Alignment.centerRight,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2)))),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          items.isEmpty ? title:'$title(${items.length})',
                          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                        const Spacer()
                      ],
                    )),
                if(index == 0)IconButton(color: Colors.white,onPressed: _showCreateDialog, icon: const Icon(Icons.add))
              ],
            ),
            Expanded(
              child: DragTarget<PlanEntity>(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return ListView.separated(
                    controller: scrollController,
                    itemCount: items.length,
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, index) {
                      final entity = items[index];
                      Widget child = PlanWidget(
                        entity,
                        width: itemWidth,
                        pIndex: index,
                      );
                      if(entity.isMoving){
                        child = Opacity(opacity: 0.3,child: child);
                      }
                      return Draggable<PlanEntity>(
                        onDragCompleted: () {
                          setState(() {
                            items.removeAt(index);
                          });
                        },
                        childWhenDragging: Opacity(opacity: 0,child: child),
                        feedback: Material(color: Colors.transparent,borderRadius: BorderRadius.circular(10),child: child),
                        data: entity,
                        child: GestureDetector(
                          onTap: ()=>_showCreateDialog(entity: entity,onDelete: ()async{
                            await IsarUtil().deletePlan(entity);
                            setState(() {
                              items.removeAt(index);
                            });
                          }),
                          child: child,
                        ),
                      );
                    },
                  );
                },
                onWillAccept: (PlanEntity? data){
                  if(data!.status == index){
                    return false;
                  }
                  scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves
                      .linear);

                  if(items.isEmpty || !items.first.isMoving){
                    final tempPlan = PlanEntity()..id = data.id
                      ..content = data.content
                      ..label = data.label
                      ..remark = data.remark
                      ..createTime = data.createTime
                      ..updateTime = data.updateTime
                      ..status = data.status
                      ..isMoving = true;
                    setState(() {
                      items.insert(0,tempPlan);
                    });
                  }

                  return true;
                },

                onLeave: (PlanEntity? data){
                  if(items.first.isMoving){
                    setState(() {
                      items.removeAt(0);
                    });
                  }
                },
                onAccept: (PlanEntity data) async {
                  data.status = index;
                  data.updateTime = DateTime.now();
                  IsarUtil().updatePlan(data);
                  setState(() {
                    data.isMoving = false;
                    items[0] = data;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showCreateDialog({PlanEntity? entity,GestureTapCallback? onDelete}) async {
    final res = await showDialog<PlanEntity?>(
        context: context,
        builder: (context) {
          return PlanInputPage(
              entity: entity,
              onDelete: onDelete,
          );
        });
    if (res != null) {
      if(entity != null){
        await IsarUtil().updatePlan(res);
        setState(() {});
      }else{
        await IsarUtil().savePlan(widget.projectEntity.id, res);
        _loadPlanData();
      }
    }
  }
}
