# dfp

`dfp` is a library for typed functional programming in Dart, inspired by [Rust](https://www.rust-lang.org/).

## Result

Result is a type that represents either success (`Ok`) or failure (`Err`).

For example, you can use Result with `dio`:

```dart
import 'package:dfp/dfp.dart';

...

Future<Result<User, String>> fetchUser() async {
  final response =
      await asyncTryCatch<Response<Map<String, dynamic>>, DioError>(
    dio.get(Urls.account),
  );

  return response
      .map((r) => UserDto.fromJson(r.data!))
      .map((value) => value.toModel())
      .mapErr((error) {
    if (error.response?.statusCode == 401) return 'Unauthorized error';

    return 'Another error';
  });
}
```

In this case, we have converted the successful response to a DTO model, and then we have converted it to a domain model. Also we have converted the error value (if we got it) from DioError to String.

We can use the result value with the provided methods, such as ifOkElse:

```dart
  // somewhere in BLoC
  fetchUser: (_) async {
    emit(UserState.loading());

    final result = await fetchUser();
    result.ifOkElse((user) {
      emit(UserState.loaded(user));
    }, (error) {
      emit(UserState.error(error));
    });
  },
```

If we don't care about the error, then we can use the `result.ok` value, which also provides many useful methods. For example:

```dart
  Future<Option<User>> fetchUser() async {
    final response =
        await asyncTryCatch<Response<Map<String, dynamic>>, DioError>(
      _httpClient.get(Urls.account),
    );

    return response
        .map((r) => UserDto.fromJson(r.data!))
        .map((value) => value.toModel())
        .ok;
  }

  ...

  // somewhere in BLoC
  fetchUser: (_) async {
    emit(UserState.loading());

    final result = await fetchUser();
    result.ifSomeElse((user) {
      emit(UserState.loaded(user));
    }, (error) {
      emit(UserState.error());
    });
  },
```

Instead of `result.ifOkElse` we can use `result.ifOk`, `result.ifErr` or `result.when`:

```dart
result.ifOk((user) {
  emit(UserState.loaded(user));
})
...
result.ifErr(error) {
  emit(UserState.error(error));
});
...
result.when(
  ok: (user) => emit(UserState.loaded(user)),
  err: (error) => emit(UserState.error(error)),
);
```

## Option

`Option<A>` is a container for an optional value of type `A`. If the value of type `A` is present, the `Option<A>` is an instance of `Some<A>`, containing the present value of type `A`. If the value is absent, the `Option<A>` is an instance of `None`.

An option could be looked at as a collection or foldable structure with either one or zero elements.
Another way to look at `Option` is: it represents the effect of a possibly failing computation.

```dart
final str = Option.fromNullable(stdin.readLineSync());
final number = Option.flatten(
  str.map((value) => Option.fromNullable(double.tryParse(value))),
);
final fixed = number
    .map(sin)
    .map((value) => value * 2)
    .map((value) => value.abs().toStringAsFixed(2));
print(fixed.toNullable());
```
