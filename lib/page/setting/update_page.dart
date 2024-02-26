import 'dart:math';

import 'package:daily_plan/common/app_version.dart';
import 'package:daily_plan/common/constant.dart';
import 'package:daily_plan/common/http_net.dart';
import 'package:daily_plan/entity/app_entity.dart';
import 'package:daily_plan/generated/l10n.dart';
import 'package:daily_plan/provider/theme_provider.dart';
import 'package:daily_plan/widget/rotation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  AppEntity? entity = AppVersion.appInfo;
  String currentVersion = AppVersion.currentVersion;
  String latestVersion = AppVersion.latestVersion;
  bool isUpdateRequired = AppVersion.isUpdateRequired;

  @override
  void initState() {
    _loadAppMsg();
    super.initState();
  }

  _loadAppMsg() async {
    await AppVersion.checkUpdate();
    entity = AppVersion.appInfo;
    currentVersion = AppVersion.currentVersion;
    latestVersion = AppVersion.latestVersion;
    isUpdateRequired = AppVersion.isUpdateRequired;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).check_update,
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotationWidget(Image.asset('images/logo.png', width: 100)),
                const SizedBox(height: 10),
                const Text(
                  Constant.appName,
                  style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    'v$currentVersion',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(min(0.2 + context.watch<ThemeProvider>().backgroundOpacity, 1.0)),
                  ),
                  constraints: const BoxConstraints(maxWidth: 500, minWidth: 500),
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isUpdateRequired ? '${S.of(context).new_version_note}：v$latestVersion' : S.of(context).version_note,
                        style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        entity?.body ?? '*' * 10,
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      const SizedBox(height: 50),
                      ElevatedButton(
                          onPressed: isUpdateRequired
                              ? () {
                                  launchUrlString(Constant.githubUpdateUrl);
                                }
                              : () {},
                          child: Text(isUpdateRequired ? S.of(context).update_version : S.of(context).latest_version))
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
