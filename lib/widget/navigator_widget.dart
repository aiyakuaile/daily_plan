import 'package:flutter/material.dart';

class NavigatorWidget extends StatelessWidget {
  final GestureTapCallback? onLeft;
  final GestureTapCallback? onRight;
  final String title;
  const NavigatorWidget({super.key,this.title = '正在加载',this.onLeft,this.onRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: onLeft,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
              child: Center(
                  child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
          ))),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: onRight,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
