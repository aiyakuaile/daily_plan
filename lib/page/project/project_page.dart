import 'package:daily_plan/common/constant.dart';
import 'package:daily_plan/entity/project_entity.dart';
import 'package:daily_plan/page/home/project_input_page.dart';
import 'package:daily_plan/utils/extension.dart';
import 'package:daily_plan/utils/isar_util.dart';
import 'package:daily_plan/widget/project_widget.dart';
import 'package:daily_plan/widget/rotation_widget.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class ProjectPage extends StatefulWidget {
  final ValueChanged<int>? onChange;
  final GestureTapCallback? onSetting;
  const ProjectPage({super.key, this.onChange,this.onSetting});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with AutomaticKeepAliveClientMixin {
  List<ProjectEntity> _projects = <ProjectEntity>[];

  @override
  void initState() {
    super.initState();
    _loadProjectData();
  }

  _loadProjectData() async {
    _projects = await IsarUtil().getAllProjects();
    setState(() {});
  }

  _onDelete(ProjectEntity entity) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(title:  Text(S.of(context).dialog_title), content: Text(S.of(context).delete_project_content), actions: [
            OutlinedButton(onPressed: Navigator.of(context).pop, child: Text(S.of(context).cancel)),
            ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await IsarUtil().deleteProject(entity);
                  _loadProjectData();
                },
                child: Text(S.of(context).confirm)),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: MediaQuery.of(context).size.width, height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  Constant.appNameFirst,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: widget.onSetting,
                  child: RotationWidget(Image.asset('images/logo.png', width: 100)),
                ),
                const Text(
                  Constant.appNameLast,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                GestureDetector(
                  onTap: _showCreateDialog,
                  child: Container(
                    width: 185,
                    height: 160,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))]),
                    child: const Icon(
                      Icons.add,
                      size: 80,
                    ),
                  ),
                ),
                ..._projects.mapWithIndex((index, e) => ProjectWidget(
                      entity: e,
                      onDelete: () => _onDelete(e),
                      onTap: () => widget.onChange?.call(index),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _showCreateDialog() async {
    final res = await showDialog<ProjectEntity?>(
        context: context,
        builder: (context) {
          return const ProjectInputPage();
        });
    if (res != null) {
      await IsarUtil().saveProject(res);
      _loadProjectData();
    }
  }
}
