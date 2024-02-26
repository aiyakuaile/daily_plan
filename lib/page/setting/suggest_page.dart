import 'package:daily_plan/common/constant.dart';
import 'package:daily_plan/generated/l10n.dart';
import 'package:daily_plan/widget/setting_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SuggestPage extends StatefulWidget {
  const SuggestPage({super.key});

  @override
  State<SuggestPage> createState() => _SuggestPageState();
}

class _SuggestPageState extends State<SuggestPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
               Text(S.of(context).feedback,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
              const Spacer(),
               GestureDetector(
                 onTap: (){
                   launchUrlString(Constant.githubHomeUrl);
                 },
                 child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: const Text('Github >>',style: TextStyle(color: Colors.white),),
              ),
               )
            ],
          )
        ),
        Container(
          constraints: const BoxConstraints(
              minWidth: 600,
              maxWidth: 600
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SettingItemWidget(title: S.of(context).star,showArrow: true,onTap: (){
                  launchUrlString(Constant.githubHomeUrl);
                },),
                SettingItemWidget(title: S.of(context).issue,showArrow: true,onTap: (){
                  launchUrlString(Constant.githubIssuesUrl);
                },),
              ],
            ),
          ),
        )
      ],
    );
  }
}