import 'package:daily_plan/page/main/main_page.dart';
import 'package:daily_plan/utils/isar_util.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'common/constant.dart';
import 'widget/rotation_widget.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(const WindowOptions(
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.white,
    title: Constant.appName
  ),()async{
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        fontFamily: Constant.defaultFontFamily,
      ),
      home: FutureBuilder(
          future: IsarUtil().initIsarData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return const MainPage();
            } else {
              return Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: RotationWidget(Image.asset('images/logo.png', width: 200)),
              );
            }
          }),
    );
  }
}
