/// `Option<A>` is a container for an optional value of type `A`. If the value of type `A` is present, the `Option<A>` is
/// an instance of `Some<A>`, containing the present value of type `A`. If the value is absent, the `Option<A>` is an
/// instance of `None`.
///
/// An option could be looked at as a collection or foldable structure with either one or zero elements.
/// Another way to look at `Option` is: it represents the effect of a possibly failing computation.
abstract class Option<T> {
  final bool isNone;
  final bool isSome;

  const Option({
    required this.isNone,
    required this.isSome,
  });

  factory Option.fromNullable(T? value) =>
      value != null ? Some(value) : None<T>();

  /// Converts from `Option<T>` to `B` by applying a function `ifSome` to a contained `Some` value and a function `ifNone` for None.
  B fold<B>(B Function(T value) ifSome, B Function() ifNone);

  /// Returns the contained Some value or a provided fallback.
  T getOrElse(T fallback) => fold((value) => value, () => fallback);

  /// Maps an Option<T> to Option<B> by applying a function to a contained value.
  Option<B> map<B>(B Function(T value) f) => fold(
        (value) => Some(f(value)),
        () => None(),
      );

  /// Apply function `IfSome` to a contained value if it is `Some`, otherwise do nothing.
  void ifSome(void Function(T value) ifSome) => fold(ifSome, () {});

  /// Call function `ifNone` if it is `None`, otherwise do nothing.
  void ifNone(void Function() ifNone) => fold((value) {}, ifNone);

  /// Apply function `IfSome` to a contained value if it is `Some`, otherwise call function `ifNone`.
  void ifSomeElse(void Function(T value) ifSome, void Function() ifNone) =>
      fold(ifSome, ifNone);

  /// Apply function [some] to a contained value if it is `Some` and [some] is present.
  ///
  /// Call function [none] if it is `None` and [none] is present.
  void when({void Function(T value)? some, void Function()? none}) => fold(
        some ?? (value) {},
        none ?? () {},
      );

  /// Returns the contained Some value or null.
  T? toNullable() => fold((value) => value, () => null);

  static Option<T> flatten<T>(Option<Option<T>> option) =>
      option.fold((value) => value, () => None());
}

/// No value.
class None<T> extends Option<T> {
  const None() : super(isNone: true, isSome: false);

  @override
  bool operator ==(other) => other is None;

  @override
  int get hashCode => 0;

  @override
  B fold<B>(B Function(T a) ifSome, B Function() ifNone) => ifNone();
}

/// Some value of type [T].
class Some<T> extends Option<T> {
  const Some(this.value) : super(isNone: false, isSome: true);

  final T value;

  @override
  bool operator ==(other) => other is Some && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  B fold<B>(B Function(T a) ifSome, B Function() ifNone) => ifSome(value);
}
