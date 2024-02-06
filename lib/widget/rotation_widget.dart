import 'dart:math';

import 'package:daily_plan/utils/extension.dart';
import 'package:flutter/material.dart';

class RotationWidget extends StatefulWidget {
  final Widget child;
  const RotationWidget(this.child,{super.key});

  @override
  State<RotationWidget> createState() => _RotationState();
}

class _RotationState extends State<RotationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: 5.seconds);
    _angleAnimation = Tween(begin: 0.0,end: 2*pi).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _angleAnimation, builder: (BuildContext context, Widget? child){
      return Transform.rotate(angle: _angleAnimation.value,child: child!,);
    },child: widget.child,);
  }
}
