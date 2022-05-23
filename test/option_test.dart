import 'package:flutter_test/flutter_test.dart';
import 'package:fp/src/functions.dart';
import 'package:fp/src/option.dart';



void main() {
  test('isNone', () {
    final n = None();
    final s = Some(42);

    expect(n.isNone, true);
    expect(s.isNone, false);
  });

  test('isSome', () {
    final n = None();
    final s = Some(42);

    expect(n.isSome, false);
    expect(s.isSome, true);
  });

  test('option', () {
    final o1 = option(true, 42);
    final o2 = option(false, 42);

    expect(o1.isSome, true);
    expect(o2.isSome, false);
  });

  test('fromNullable', () {
    int? a = 42;
    int? b;

    final s = fromNullable(a);
    final n = fromNullable(b);

    expect(s.isSome, true);
    expect(n.isSome, false);
  });

  test('tryCatch', () {
    expect(tryCatch(() => 42), Some(42));
    expect(tryCatch(() => throw 'Error'), None());
  });

  test('getOrElse', () {
    final n = None();
    final s = Some(42);

    expect(n.getOrElse(0), 0);
    expect(s.getOrElse(0), 42);
  });
}
