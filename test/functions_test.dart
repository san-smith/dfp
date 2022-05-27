import 'package:fp/src/functions.dart';
import 'package:fp/src/result.dart';
import 'package:test/test.dart';

void main() {
  group('Functions', () {
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
      expect(tryCatch(() => 42), Ok(42));
      expect(tryCatch(() => throw 'Error'), Err('Error'));
    });

    test('asyncTryCatch', () async {
      final ok = await asyncTryCatch(Future.value(42));
      final err = await asyncTryCatch(Future.error('Error'));

      expect(ok, Ok(42));
      expect(err, Err('Error'));
    });
  });
}
