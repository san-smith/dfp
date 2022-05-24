import 'dart:math';

import 'package:fp/src/functions.dart';

void main() async {
  final a = tryCatch<int, String>(() => getEven(1));
  final b = a
      .map(((value) => value.toDouble()))
      .map(sqr)
      .map(exp)
      .map(toStringAsFixed2);

  b.when(
    ok: (value) {
      print('value: $value');
    },
    err: (error) {
      print('error: $error');
    },
  );
}

int getEven(int x) => x % 2 == 0 ? x : throw '$x is not even!';

double sqr(double x) => x * x;

String toStringAsFixed2(double x) => x.toStringAsFixed(2);
