import 'dart:io';
import 'dart:math';

import 'package:fp/src/option.dart';

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
