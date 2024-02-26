import 'package:daily_plan/common/constant.dart';
import 'package:daily_plan/generated/l10n.dart';
import 'package:daily_plan/provider/current_locale_provider.dart';
import 'package:daily_plan/widget/setting_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';


class LangPage extends StatefulWidget {
  const LangPage({super.key});

  @override
  State<LangPage> createState() => _LangPageState();
}

class _LangPageState extends State<LangPage> {

  final _langMap = {
    'zh': '简体中文',
    'en': 'English',
  };

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
                Text(S.of(context).language,style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),),
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
                SettingItemWidget(title: S.of(context).language_item,showArrow: true,rightWidget: PopupMenuButton<String>(
                  initialValue: Intl.getCurrentLocale(),
                  itemBuilder: (context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'zh',
                        child: Text('简体中文'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'en',
                        child: Text('English'),
                      )
                    ];
                  },
                  onSelected: (value)async{
                    final local = Locale(value);
                    if(mounted) context.read<CurrentLocaleProvider>().setLocale(local);
                  },
                  child: Text(_langMap[Intl.getCurrentLocale()]??'English',style: const TextStyle(color: Colors.white),),
                ),),
              ],
            ),
          ),
        )
      ],
    );
  }
}