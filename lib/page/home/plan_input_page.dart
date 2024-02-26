import 'package:common_utils/common_utils.dart';
import 'package:daily_plan/entity/plan_entity.dart';
import 'package:daily_plan/entity/project_entity.dart';
import 'package:daily_plan/generated/l10n.dart';
import 'package:flutter/material.dart';

class PlanInputPage extends StatefulWidget {
  final PlanEntity? entity;
  final GestureTapCallback? onDelete;

  const PlanInputPage({super.key, this.entity, this.onDelete});

  @override
  State<PlanInputPage> createState() => _PlanInputPageState();
}

class _PlanInputPageState extends State<PlanInputPage> {
  late final _contentController = TextEditingController(text: widget.entity?.content ?? '');
  late final _labelController = TextEditingController(text: ObjectUtil.isEmpty(widget.entity?.label) ? '' : widget.entity!.label.join(','));
  late final _remarkController = TextEditingController(text: widget.entity?.remark ?? '');

  _onSubmit() {
    if (_contentController.text.trim().isEmpty) return;
    final labelStr = _labelController.text.trim();
    List<String> flowList = labelStr.isEmpty ? <String>[] : _labelController.text.trim().split(RegExp('[、，,.]'));
    if (widget.entity != null) {
      return Navigator.of(context).pop(widget.entity!
        ..content = _contentController.text.trim()
        ..label = flowList
        ..remark = _remarkController.text.trim());
    }
    Navigator.of(context).pop(PlanEntity()
      ..content = _contentController.text.trim()
      ..label = flowList
      ..remark = _remarkController.text.trim()
      ..status = 0
      ..updateTime = DateTime.now()
      ..createTime = DateTime.now());
  }

  @override
  void dispose() {
    _contentController.dispose();
    _labelController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
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
                        controller: _contentController,
                        maxLength: 200,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: '* ${S.of(context).content}',
                        ),
                      ),
                      TextField(
                        controller: _labelController,
                        maxLength: 100,
                        decoration:  InputDecoration(
                          labelText: S.of(context).tags,
                        ),
                      ),
                      TextField(
                        controller: _remarkController,
                        maxLength: 300,
                        maxLines: null,
                        decoration: InputDecoration(
                          labelText: S.of(context).remark,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(height: 0.5),
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    if (widget.entity != null)
                      ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
                          onPressed: () {
                            widget.onDelete?.call();
                            Navigator.of(context).pop();
                          },
                          child: Text(S.of(context).delete,style: const TextStyle(color: Colors.white),)),
                    const Spacer(),
                    OutlinedButton(onPressed: Navigator.of(context).pop, child:  Text(S.of(context).cancel)),
                    const SizedBox(width: 20),
                    ElevatedButton(onPressed: _onSubmit, child: Text(S.of(context).confirm)),
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
