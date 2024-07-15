import 'option.dart';
import 'result.dart';

Option<T> option<T>(bool test, T value) => test ? Some(value) : None<T>();

Option<T> fromNullable<T>(T? value) => value != null ? Some(value) : None<T>();

Result<T, E> tryCatch<T, E extends Object>(T Function() f) {
  try {
    return Ok(f());
  } on E catch (e, s) {
    return Err(e, s);
  }
}

Future<Result<T, E>> asyncTryCatch<T, E extends Object>(
    Future<T> Function() f) async {
  try {
    return Ok(await f());
  } on E catch (e, s) {
    return Err(e, s);
  }
}
