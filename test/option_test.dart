import 'package:flutter_test/flutter_test.dart';

import 'package:fp/fp.dart';

void main() {
  test('isNone', () {
    final n = none();
    final s = some(42);

    expect(n.isNone, true);
    expect(s.isNone, false);
  });

  test('isSome', () {
    final n = none();
    final s = some(42);

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
    expect(tryCatch(() => 42), some(42));
    expect(tryCatch(() => throw 'Error'), none());
  });

  test('getOrElse', () {
    final n = none();
    final s = some(42);

    expect(n.getOrElse(0), 0);
    expect(s.getOrElse(0), 42);
  });
}
