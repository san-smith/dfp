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

  B fold<B>(B ifNone(), B ifSome(T value));

  /// Returns the contained Some value or a provided fallback.
  T getOrElse(T fallback) => fold(() => fallback, (value) => value);

  Option<B> map<B>(B f(T value)) => fold(() => None(), (a) => Some(f(a)));
}

/// No value.
class None<T> extends Option<T> {
  const None() : super(isNone: true, isSome: false);

  @override
  bool operator ==(other) => other is None;
  @override
  int get hashCode => 0;

  @override
  B fold<B>(B Function() ifNone, B Function(T a) ifSome) => ifNone();
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
  B fold<B>(B Function() ifNone, B Function(T a) ifSome) => ifSome(value);
}
