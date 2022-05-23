
import 'dart:math';

import 'package:fp/src/functions.dart';
import 'package:fp/src/option.dart';

void main() async {
  final a = tryCatch<int, String>(() => getEven(1));
  final b = a
      .map(((value) => value.toDouble()))
      .map(sqr)
      .map(exp)
      .map(toStringAsFixed2);

  if (b.isOk) {
    printOption(b.ok);
  } else {
    printOption(b.error);
  }
  
}

int getEven(int x) => x % 2 == 0 ? x : throw '$x is not even!';

double sqr(double x) => x * x;

String toStringAsFixed2(double x) => x.toStringAsFixed(2);

void printOption(Option<String> s) {
 final str = s.getOrElse('none');
 print(str);
}
