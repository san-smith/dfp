import 'package:fp/src/option.dart';
import 'dart:math';

void main() {
  Option<double> getNumber() => tryCatch(() {
        final a = Random().nextDouble();
        return a > 0.5 ? a : throw 'Error';
      });

  getNumber()
      .map((a) => a * 100)
      .map((a) => a.toInt())
      .map((a) => a % 2 == 0 ? -a : 2 * a)
      .map(print);
}
