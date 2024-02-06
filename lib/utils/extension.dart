import 'package:flutter/widgets.dart';
import 'dart:math' as math;


extension AsDegreesToRadians<T extends num> on T {
  double asDegreesToRadians() => toDouble() * (math.pi / 180.0);
  bool toBool() => this == 0 ? false : true;
}

extension ToInt on bool {
  int toInt() => this ? 1 : 0;
}

extension To on int {
  /// eg:
  /// 1.to(10)  (1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
  /// 1.to(10,false) (1, 2, 3, 4, 5, 6, 7, 8, 9)
  Iterable<int> to(int other, [bool inclusive = true]) =>
      other > this ? [for (int i = this; i < other; i++) i, if (inclusive) other] : [for (int i = this; i > other; i--) i, if (inclusive) other];

  Duration get days => Duration(days: this);
  Duration get seconds => Duration(seconds: this);
  Duration get hours => Duration(hours: this);
  Duration get minutes => Duration(minutes: this);
  Duration get milliseconds => Duration(milliseconds: this);
  Duration get microseconds => Duration(microseconds: this);
}

extension WithDelay<T> on T {
  Future<T> toFuture([Duration? delay]) => delay != null ? Future.delayed(delay, () => this) : Future.value(this);
}

extension IterationWithIndex<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) => Iterable.generate(length).map((i) => f(i, elementAt(i)));
}

extension RandomColor on Color {
  Color randomColor() => Color.fromRGBO(math.Random().nextInt(256), math.Random().nextInt(256), math.Random().nextInt(256), 1);
}

extension ColorString on String {
  _removeAllSpace(Iterable<String> values) => values.fold(this, (String result, String pattern) => result.replaceAll(pattern, ''));
  Color toColor() => Color(int.parse(_removeAllSpace(['0x', '#']).padLeft(8, 'ff'), radix: 16));
}
