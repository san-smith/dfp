import 'dart:io';
import 'dart:math';

import 'package:dfp/dfp.dart';

void main() async {
  final number = fromNullable(stdin.readLineSync())
      .flatMap((value) => fromNullable(double.tryParse(value)))
      .map(sin)
      .filter((value) => value >= 0)
      .map((value) => value * 2)
      .map((value) => value.abs().toStringAsFixed(2));

  print(number.toNullable());
}
