import 'package:common_utils/common_utils.dart';
import 'package:daily_plan/entity/project_entity.dart';
import 'package:flutter/material.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectEntity entity;
  final VoidCallback? onDelete;
  final GestureTapCallback? onTap;
  const ProjectWidget({super.key, required this.entity,this.onDelete,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 185,
        height: 160,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))]),
        child: Stack(
          children: [
            Column(
              children: [
                const Expanded(
                  child: FittedBox(
                    child: Icon(Icons.store_mall_directory_rounded),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration:  BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entity.name ?? '',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        '流程：${ObjectUtil.isEmpty(entity.flow) ? '':entity.flow!.join(',')}',
                        style: const TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      Text(
                        '创建日期：${DateUtil.formatDate(entity.createTime!,format: 'yyyy-MM-dd HH:mm')}',
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
                top: 0,
                right: 0,
                child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.hardEdge,
                    child: IconButton(iconSize: 20,onPressed: onDelete, icon: const Icon(Icons.delete_forever_sharp))))
          ],
        ),
      ),
    );
  }
}
