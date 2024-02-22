import 'dart:math';

import 'package:daily_plan/page/setting/suggest_page.dart';
import 'package:daily_plan/page/setting/theme_page.dart';
import 'package:daily_plan/page/setting/update_page.dart';
import 'package:daily_plan/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SettingPage extends StatefulWidget {
  final GestureTapCallback? onHome;
  final GestureTapCallback? onProject;
  const SettingPage({super.key,this.onHome,this.onProject});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with AutomaticKeepAliveClientMixin{
  final _settingPageController = PageController();
  final List<String> options = ['主题设置','检查更新','用户反馈'];
  int selectedIndex = 0;

  @override
  void dispose() {
    _settingPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(context.watch<ThemeProvider>().backgroundOpacity),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 44,
                    child: const Text('设置',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                  ),
                  const Divider(height: 0.5),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedIndex = index;
                          });
                          _settingPageController.jumpToPage(index);
                        },
                        child: Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == selectedIndex?Colors.black.withOpacity(min(0.2+context.watch<ThemeProvider>().backgroundOpacity, 1.0)):null
                          ),
                          child: Row(
                            children: [
                              Text(options[index],style: const TextStyle(fontSize: 15,color: Colors.white),),
                              const Spacer(),
                              const Icon(Icons.arrow_forward_ios_rounded,size: 12,color: Colors.white,),
                            ],
                          )
                        ),
                      );
                    }, itemCount: options.length),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 44,
                    child: Opacity(
                      opacity: 0.5,
                      child: Row(
                        children: [
                          IconButton(onPressed: widget.onHome,splashColor: Colors.transparent, icon: const Icon(Icons.home,color: Colors.white,)),
                          IconButton(onPressed: widget.onProject,splashColor: Colors.transparent, icon: const Icon(Icons.store_mall_directory_rounded,color:
                          Colors.white))
                        ],
                      ),
                    )
                  ),
                ],
              )
            ),),
            const SizedBox(width: 10),
            Expanded(flex: 3,child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(context.watch<ThemeProvider>().backgroundOpacity),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _settingPageController,
                children: const [
                  ThemePage(),
                  UpdatePage(),
                  SuggestPage(),
                  // RewardPage()
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
