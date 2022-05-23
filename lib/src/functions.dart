import 'option.dart';
import 'result.dart';

Option<A> option<A>(bool test, A value) => test ? Some(value) : None();

Option<A> fromNullable<A>(A? a) => a != null ? Some(a) : None();

Result<T, E> tryCatch<T, E>(T Function() f) {
  try {
    return Ok(f());
  } on E catch (e) {
    return Err(e);
  }
}

Future<Result<T, E>> asyncTryCatch<T, E>(Future<T> f) async {
  try {
    return Ok(await f);
  } on E catch (e) {
    return Err(e);
  }
}
