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
  Result<U, E> map<U>(U f(T value));
}

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
  Result<U, E> map<U>(U Function(T value) f) => Ok(f(_value));
}

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
  Result<U, E> map<U>(U Function(T value) f) => Err(_error);
}
