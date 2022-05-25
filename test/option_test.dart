import 'package:fp/src/option.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Test<T> {
  void ifSome(T value);

  void ifNone();
}

class TestMock<T> extends Mock implements Test<T> {}

void main() {
  group('Option', () {
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

    test('getOrElse', () {
      final n = None();
      final s = Some(42);

      expect(n.getOrElse(0), 0);
      expect(s.getOrElse(0), 42);
    });

    test('fold', () {
      final n = None();
      final s = Some(42);

      expect(n.fold((a) => true, () => false), false);
      expect(s.fold((a) => true, () => false), true);
    });

    test('map', () {
      final n = None<int>();
      final s = Some(42);

      expect(n.map((value) => value.toString()), None<String>());
      expect(s.map((value) => value.toString()), Some('42'));
    });

    group('ifSome', () {
      final s = Some(42);
      final n = None<int>();

      test('called once', () {
        final mock = TestMock();
        s.ifSome(mock.ifSome);
        n.ifSome(mock.ifSome);

        verify(mock.ifSome(42)).called(1);
      });
    });

    group('ifNone', () {
      final s = Some(42);
      final n = None<int>();

      test('called once', () {
        final mock = TestMock();
        s.ifNone(mock.ifNone);
        n.ifNone(mock.ifNone);

        verify(mock.ifNone()).called(1);
      });
    });

    group('ifSomeElse', () {
      final s = Some(42);
      final n = None<int>();

      test('ifSome called once', () {
        final mock = TestMock();
        s.ifSomeElse(mock.ifSome, mock.ifNone);
        n.ifSomeElse(mock.ifSome, mock.ifNone);

        verify(mock.ifSome(42)).called(1);
      });

      test('ifNone called once', () {
        final mock = TestMock();
        s.ifSomeElse(mock.ifSome, mock.ifNone);
        n.ifSomeElse(mock.ifSome, mock.ifNone);

        verify(mock.ifNone()).called(1);
      });
    });

    group('when', () {
      final s = Some(42);
      final n = None<int>();

      test('ifSome called twice', () {
        final mock = TestMock();
        s.when(some: mock.ifSome, none: mock.ifNone);
        n.when(some: mock.ifSome, none: mock.ifNone);

        s.when(some: mock.ifSome);
        n.when(some: mock.ifSome);

        verify(mock.ifSome(42)).called(2);
      });

      test('ifNone called once', () {
        final mock = TestMock();
        s.when(some: mock.ifSome, none: mock.ifNone);
        n.when(some: mock.ifSome, none: mock.ifNone);

        s.when(none: mock.ifNone);
        n.when(none: mock.ifNone);

        verify(mock.ifNone()).called(2);
      });
    });

    test('toNullable', () {
      final s = Some(42);
      final n = None<int>();

      expect(s.toNullable(), 42);
      expect(n.toNullable(), null);
    });

    test('hasCode', () {
      final s = Some(42);
      final n = None<int>();

      expect(s.hashCode, 42.hashCode);
      expect(n.hashCode, 0);
    });
  });
}
