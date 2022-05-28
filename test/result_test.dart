import 'package:fp/fp.dart';
import 'package:fp/src/result.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

abstract class Test<T, E> {
  void ifOk(T value);

  void ifErr(E error);
}

class TestMock<T, E> extends Mock implements Test<T, E> {}

void main() {
  group('Result', () {
    test('is Ok', () {
      final ok = Ok(42);
      final err = Err('error');

      expect(ok.isOk, true);
      expect(err.isOk, false);
    });

    test('is Err', () {
      final ok = Ok(42);
      final err = Err('error');

      expect(ok.isErr, false);
      expect(err.isErr, true);
    });

    test('fold works correctly', () {
      final ok = Ok(42);
      final err = Err('error');

      expect(ok.fold((value) => true, (error) => false), true);
      expect(err.fold((value) => true, (error) => false), false);
    });

    test('map works correctly', () {
      final ok = Ok(42);
      final err = Err('error');

      expect(ok.map((value) => 'value: $value'), Ok('value: 42'));
      expect(err.map((value) => 'value: $value'), err);
    });

    test('mapErr works correctly', () {
      final ok = Ok(42);
      final err = Err('error');

      expect(ok.mapErr((err) => 'error: $err'), ok);
      expect(err.mapErr((err) => 'error: $err'), Err('error: error'));
    });

    test('ifOk works correctly', () {
      final ok = Ok(42);
      final err = Err('error');

      final mock = TestMock();
      ok.ifOk(mock.ifOk);
      err.ifErr(mock.ifOk);

      verify(mock.ifOk(42)).called(1);
    });

    test('ifErr works correctly', () {
      final ok = Ok(42);
      final err = Err('error');

      final mock = TestMock();
      ok.ifOk(mock.ifErr);
      err.ifErr(mock.ifErr);

      verify(mock.ifErr('error')).called(1);
    });

    group('ifOkElse', () {
      final ok = Ok(42);
      final err = Err('error');

      test('mock.ifOk called once', () {
        final mock = TestMock();
        ok.ifOkElse(mock.ifOk, mock.ifErr);
        err.ifOkElse(mock.ifOk, mock.ifErr);

        verify(mock.ifOk(42)).called(1);
      });

      test('mock.ifErr called once', () {
        final mock = TestMock();
        ok.ifOkElse(mock.ifOk, mock.ifErr);
        err.ifOkElse(mock.ifOk, mock.ifErr);

        verify(mock.ifErr('error')).called(1);
      });
    });

    group('when', () {
      final ok = Ok(42);
      final err = Err('error');

      test('mock.ifOk called once', () {
        final mock = TestMock();
        ok.when(ok: mock.ifOk, err: mock.ifErr);
        err.when(ok: mock.ifOk, err: mock.ifErr);

        ok.when(ok: mock.ifOk);
        err.when(ok: mock.ifOk);

        verify(mock.ifOk(42)).called(2);
      });

      test('mock.ifErr called once', () {
        final mock = TestMock();
        ok.when(ok: mock.ifOk, err: mock.ifErr);
        err.when(ok: mock.ifOk, err: mock.ifErr);

        ok.when(err: mock.ifErr);
        err.when(err: mock.ifErr);

        verify(mock.ifErr('error')).called(2);
      });
    });

    test('hashCode', () {
      final ok = Ok(42);
      final err = Err('error');

      expect(ok.hashCode, 42.hashCode);
      expect(err.hashCode, 'error'.hashCode);
    });
  });
}
