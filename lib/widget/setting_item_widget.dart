import 'package:flutter/material.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool showArrow;
  final Widget? rightWidget;
  final GestureTapCallback? onTap;
  const SettingItemWidget({super.key,required this.title,this.subTitle,this.showArrow = false,this.rightWidget,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Colors.black38,Colors.black87]),
            borderRadius: BorderRadius.circular(10)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Text(title,style: const TextStyle(color: Colors.white),),
            const Spacer(),
            if(subTitle != null)Text(subTitle!,style: const TextStyle(color: Colors.white),),
            if(showArrow) const Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.white,),
            if(rightWidget != null) rightWidget!
          ],
        ),
      ),
    );
  }
}
