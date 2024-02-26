import 'package:daily_plan/page/main/main_page.dart';
import 'package:daily_plan/provider/current_locale_provider.dart';
import 'package:daily_plan/utils/isar_util.dart';
import 'package:daily_plan/utils/prefs_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'common/constant.dart';
import 'generated/l10n.dart';
import 'provider/theme_provider.dart';
import 'widget/rotation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await PrefsUtil.init();
  final lang = await PrefsUtil.getString('lang');
  if(lang != null && lang.isNotEmpty) {
    CurrentLocaleProvider.langCode = lang;
  }
  await windowManager.waitUntilReadyToShow(
      const WindowOptions(size: Size(1000, 800),minimumSize: Size(1000, 800), center: true, backgroundColor: Colors.white, title:
      Constant.appName), () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CurrentLocaleProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentLocaleProvider>(
      builder: (_,p,child) {
        debugPrint('CurrentLocaleProvider::::${p.value}');
        return MaterialApp(
          theme: ThemeData(fontFamily: Constant.defaultFontFamily, colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent), useMaterial3: true),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
            final isSupport = supportedLocales.map((e) => e.languageCode).contains(locale?.languageCode ?? 'en');
            if(isSupport){
              p.setLocale(Locale(locale!.languageCode));
            }else{
              p.setLocale(const Locale('en'));
            }
            return null;
          },
          locale: p.value,
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
    );
  }
}
