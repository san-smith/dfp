import 'dart:io';
import 'dart:math';

import 'package:dfp/dfp.dart';

void main() async {
  final str = Option.fromNullable(stdin.readLineSync());
  final number = Option.flatten(
    str.map((value) => Option.fromNullable(double.tryParse(value))),
  );
  final fixed = number
      .map(sin)
      .map((value) => value * 2)
      .map((value) => value.abs().toStringAsFixed(2));
  print(fixed.toNullable());
}
