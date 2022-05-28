import 'package:fp/fp.dart';

/// Result is a type that represents either success (Ok) or failure (Err).
abstract class Result<T, E> {
  /// Returns true if the result is Ok.
  final bool isOk;

  /// Returns true if the result is Err.
  final bool isErr;

  /// Converts from Result<T, E> to Option<T>.
  ///
  /// Converts self into an Option<T>, consuming self, and discarding the error, if any.
  final Option<T> ok;

  /// Converts from Result<T, E> to Option<E>.
  ///
  /// Converts self into an Option<E>, consuming self, and discarding the success value, if any.
  final Option<E> error;

  const Result({
    required this.isOk,
    required this.isErr,
    required this.ok,
    required this.error,
  });

  /// Maps a Result<T, E> to Result<U, E> by applying a function to a contained Ok value, leaving an Err value untouched.
  ///
  /// This function can be used to compose the results of two functions.
  Result<U, E> map<U>(U Function(T value) f);

  /// Maps a Result<T, E> to Result<T, F> by applying a function to a contained Err value, leaving an Ok value untouched.
  ///
  /// This function can be used to pass through a successful result while handling an error.
  Result<T, F> mapErr<F>(F Function(E error) f);

  /// Converts from `Result<T, E>` to `B` by applying a function `ifOk` to a contained `Ok` value and a function `ifErr` to a contained `Err` value.
  B fold<B>(B Function(T value) ifOk, B Function(E error) ifErr);

  /// Apply function `IfOk` to a contained value if it is `Ok`, otherwise do nothing.
  void ifOk(void Function(T value) ifOk) => fold(ifOk, (error) {});

  /// Apply function `ifErr` to a contained error if it is `Err`, otherwise do nothing.
  void ifErr(void Function(E error) ifErr) => fold((value) {}, ifErr);

  /// Apply function `IfOk` to a contained value if it is `Ok`, otherwise apply function `ifErr` to a contained error.
  void ifOkElse(void Function(T value) ifOk, void Function(E error) ifErr) =>
      fold(ifOk, ifErr);

  /// Apply function `ok` to a contained value if it is `Ok` and `ok` is present.
  ///
  /// Apply function `err` to a contained error if it is `Err` and `err` is present.
  void when({void Function(T value)? ok, void Function(E error)? err}) => fold(
        ok ?? (value) {},
        err ?? (error) {},
      );

  /// Converts from Result<Result<T, E>, E> to Result<T, E>
  static Result<T, E> flatten<T, E>(Result<Result<T, E>, E> result) =>
      result.fold(
        (value) => value,
        (error) => Err(error),
      );
}

/// Contains the success value
class Ok<T, E> extends Result<T, E> {
  final T _value;

  Ok(this._value)
      : super(
          isOk: true,
          isErr: false,
          ok: Some(_value),
          error: const None(),
        );

  @override
  B fold<B>(B Function(T value) ifOk, B Function(E error) ifErr) =>
      ifOk(_value);

  @override
  Result<U, E> map<U>(U Function(T value) f) => Ok(f(_value));

  @override
  Result<T, F> mapErr<F>(F Function(E error) f) => Ok(_value);

  @override
  bool operator ==(other) => other is Ok && other._value == _value;

  @override
  int get hashCode => _value.hashCode;
}

/// Contains the error value
class Err<T, E> extends Result<T, E> {
  final E _error;

  Err(this._error)
      : super(
          isOk: false,
          isErr: true,
          ok: const None(),
          error: Some(_error),
        );

  @override
  B fold<B>(B Function(T value) ifOk, B Function(E error) ifErr) =>
      ifErr(_error);

  @override
  Result<U, E> map<U>(U Function(T value) f) => Err(_error);

  @override
  Result<T, F> mapErr<F>(F Function(E error) f) => Err(f(_error));

  @override
  bool operator ==(other) => other is Err && other._error == _error;

  @override
  int get hashCode => _error.hashCode;
}
