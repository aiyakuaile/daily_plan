import 'package:common_utils/common_utils.dart';
import 'package:daily_plan/entity/plan_entity.dart';
import 'package:daily_plan/utils/colors_util.dart';
import 'package:daily_plan/utils/extension.dart';
import 'package:flutter/material.dart';

class PlanWidget extends StatelessWidget {
  final PlanEntity entity;
  final double? width;
  final int pIndex;

  const PlanWidget(this.entity, {super.key, this.width,this.pIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white.withOpacity(0.8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ObjectUtil.isNotEmpty(entity.content))
            RichText(text: TextSpan(
              children: [
                WidgetSpan(child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: ColorsUtil.getSysColor(pIndex),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                  margin: const EdgeInsets.only(right: 5),
                  child: FittedBox(child: Text('${pIndex+1}',style: const TextStyle(fontSize: 15,color: Colors.white),),)
                ),),
                TextSpan(
                  text: entity.content!,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15,color: Colors.black),
                ),
              ]
            )),
          if (ObjectUtil.isNotEmpty(entity.remark))
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              padding: const EdgeInsets.symmetric(vertical:5,horizontal: 10),
              child: Text(
                entity.remark!,
                style: const TextStyle(fontSize: 12,color: Colors.black54,
              ),
            ),),
          if (entity.label.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: entity.label
                    .mapWithIndex((index, value) => Container(
                  decoration: BoxDecoration(
                    color: ColorsUtil.getSysColor(index),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  child: Text(value,style: const TextStyle(fontSize: 10,color: Colors.white),),
                ))
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
