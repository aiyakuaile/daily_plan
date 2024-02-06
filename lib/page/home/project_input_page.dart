import 'package:daily_plan/entity/project_entity.dart';
import 'package:flutter/material.dart';

class ProjectInputPage extends StatefulWidget {
  const ProjectInputPage({super.key});

  @override
  State<ProjectInputPage> createState() => _ProjectInputPageState();
}

class _ProjectInputPageState extends State<ProjectInputPage> {
  final _nameController = TextEditingController();
  final _flowController = TextEditingController();

  _onSubmit() {
    if (_nameController.text.trim().isEmpty || _flowController.text.trim().isEmpty) return;

    List<String> flowList = _flowController.text.trim().split(RegExp('[、，,.]'));

    Navigator.of(context).pop(
        ProjectEntity()
          ..name = _nameController.text.trim()
          ..flow = flowList
          ..createTime = DateTime.now());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _flowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.9),borderRadius: BorderRadius.circular(10)),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _nameController,
                        maxLength: 20,
                        decoration: const InputDecoration(
                          labelText: '名称',
                        ),
                      ),
                      TextField(
                        controller: _flowController,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          labelText: '流程(例如：待办、进行中、已完成)',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(height: 0.5),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Spacer(),
                    OutlinedButton(onPressed: Navigator.of(context).pop, child: const Text('取消')),
                    const SizedBox(width: 20),
                    ElevatedButton(onPressed: _onSubmit, child: const Text('确定')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
