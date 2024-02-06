import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:daily_plan/common/constant.dart';
import 'package:daily_plan/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ToastUtil {
  ToastUtil._();

  static showSuccess(BuildContext context, {String? msg}) {
    CherryToast.success(
      title: Text(msg ?? '操作成功'),
      animationType: AnimationType.fromTop,
      animationDuration: 300.milliseconds,
      toastDuration: 1.seconds,
      displayCloseButton:false
    ).show(context);
  }

  static showError(BuildContext context, {String? msg, String? reason}) {
    CherryToast.error(
      title: Text(msg ?? '操作失败'),
      description: reason == null ? null : Text(reason,style: const TextStyle(fontSize: 12,color: Colors.redAccent),),
      animationType: AnimationType.fromTop,
      animationDuration: 300.milliseconds,
      toastDuration: 1.seconds,
      displayCloseButton:false
    ).show(context);
  }

  static showInfo(BuildContext context, {required String msg}) {
    CherryToast.info(
      title: Text(msg),
      animationType: AnimationType.fromTop,
      animationDuration: 300.milliseconds,
      toastDuration: 1.seconds,
      displayCloseButton:false
    ).show(context);
  }

  static showUpdateInfo(BuildContext context) {
    CherryToast.info(
        title: const Text('有新的版本发布啦！'),
        animationType: AnimationType.fromTop,
        animationDuration: 300.milliseconds,
        toastDuration: 3.seconds,
        action: Text.rich(TextSpan(
          children: [
            WidgetSpan(child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)))
                ),
                onPressed: (){
              launchUrlString(Constant.githubUpdateUrl);
            }, child: const Text('立即更新')))
          ]
        )),
        // action: const Text('立即更新'),
        // actionHandler: (){},
        autoDismiss: false,
    ).show(context);
  }
}
