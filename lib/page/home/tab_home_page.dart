import 'package:daily_plan/entity/project_entity.dart';
import 'package:daily_plan/page/home/home_page.dart';
import 'package:daily_plan/utils/isar_util.dart';
import 'package:daily_plan/widget/navigator_widget.dart';
import 'package:flutter/material.dart';

class TabHomePage extends StatefulWidget {
  final PageController controller;

  const TabHomePage(this.controller, {super.key});

  @override
  State<TabHomePage> createState() => _TabHomePageState();
}

class _TabHomePageState extends State<TabHomePage> {
  String title = '';
  List<ProjectEntity> _projects = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    _projects = await IsarUtil().getAllProjects();
    if(_projects.isNotEmpty){
      title = _projects[widget.controller.initialPage].name ?? '';
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          NavigatorWidget(
            onLeft: () {
              if(widget.controller.positions.isNotEmpty) {
                widget.controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves
                  .easeIn);
              }
            },
            onRight: () {
              if(widget.controller.positions.isNotEmpty) {
                widget.controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves
                  .easeIn);
              }
            },
            title: title,
          ),
          Expanded(
            child: _projects.isNotEmpty
                ? PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: widget.controller,
                    itemBuilder: (BuildContext context, int index) {
                      final project = _projects[index];
                      return HomePage(project);
                    },
                    itemCount: _projects.length,
                    onPageChanged: (int index) {
                      final data = _projects[index];
                      setState(() {
                        title = data.name ?? '';
                      });
                    },
                  )
                : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: const Text('请先添加计划',style: TextStyle(color: Colors.white,fontSize: 30),),
                    ),
                ),
          ),
        ],
      ),
    );
  }
}
