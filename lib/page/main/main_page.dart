import 'package:common_utils/common_utils.dart';
import 'package:daily_plan/common/app_version.dart';
import 'package:daily_plan/common/http_net.dart';
import 'package:daily_plan/page/home/tab_home_page.dart';
import 'package:daily_plan/page/project/project_page.dart';
import 'package:daily_plan/utils/isar_util.dart';
import 'package:daily_plan/utils/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../setting/setting_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with AutomaticKeepAliveClientMixin {
  final _pageVController = PageController(initialPage: 0);
  final PageController _pageHController = PageController(initialPage: 0);
  final _focusNode = FocusNode();
  String? _bingImgUrl;

  @override
  void initState() {
    _loadBgImg();
    _checkUpdate();
    super.initState();
  }

  _loadBgImg() async {
    final url = await HttpNet.getBingWallPaper();
    if (!mounted) return;
    if (ObjectUtil.isNotEmpty(url)) {
        setState(() {
          _bingImgUrl = url;
        });
    }else{
      ToastUtil.showError(context,msg: '获取壁纸出错啦！');
    }
  }

  _checkUpdate()async{
    final isUpdate = await AppVersion.checkUpdate();
    if(!mounted) return;
    if(isUpdate){
      ToastUtil.showUpdateInfo(context);
    }
  }

  @override
  void dispose() {
    _pageVController.dispose();
    _pageHController.dispose();
    IsarUtil().closeIsar();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: (RawKeyEvent event) {
          if (event is RawKeyUpEvent) {
            final keyId = event.logicalKey.keyId;
            switch (keyId) {
              case 119:
              case 4294968068:
                // 上
                _pageVController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                break;
              case 115:
              case 4294968065:
                // 下
                _pageVController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                break;
              case 97:
              case 4294968066:
                // 左
                if (_pageHController.positions.isNotEmpty) {
                  _pageHController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                }
                break;

              case 100:
              case 4294968067:
                // 右
                if (_pageHController.positions.isNotEmpty) {
                  _pageHController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                }
                break;
              default:
                return;
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, image: _bingImgUrl == null ? null : DecorationImage(image: NetworkImage(_bingImgUrl!), fit: BoxFit.cover)),
          child: PageView(
            controller: _pageVController,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: [
              ProjectPage(
                onChange: (int index) async {
                  await _pageVController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                  _pageHController.jumpToPage(index);
                },
                onSetting: (){
                  _pageVController.animateToPage(2,duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
              ),
              TabHomePage(
                _pageHController,
              ),
              SettingPage(
                onHome: (){
                  _pageVController.animateToPage(0,duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
                onProject: (){
                  _pageVController.animateToPage(1,duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
