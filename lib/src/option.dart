import 'functions.dart';

/// `Option<A>` is a container for an optional value of type `A`. If the value of type `A` is present, the `Option<A>` is
/// an instance of `Some<A>`, containing the present value of type `A`. If the value is absent, the `Option<A>` is an
/// instance of `None`.
///
/// An option could be looked at as a collection or foldable structure with either one or zero elements.
/// Another way to look at `Option` is: it represents the effect of a possibly failing computation.

abstract class Option<A> {
  bool get isNone => fold(() => true, (a) => false);
  bool get isSome => !isNone;

  B fold<B>(B ifNone(), B ifSome(A a));
  A getOrElse(A a) => fold(() => a, (value) => value);

  Option<B> map<B>(B f(A a)) => fold(() => none(), (a) => some(f(a)));
}

class None<A> extends Option<A> {
  @override
  bool operator ==(other) => other is None;
  @override
  int get hashCode => 0;

  @override
  B fold<B>(B Function() ifNone, B Function(A a) ifSome) => ifNone();
}

class Some<A> extends Option<A> {
  Some(this.value);

  final A value;

  @override
  bool operator ==(other) => other is Some && other.value == value;
  @override
  int get hashCode => value.hashCode;

  @override
  B fold<B>(B Function() ifNone, B Function(A a) ifSome) => ifSome(value);
}

Option<A> none<A>() => None();

Option<A> some<A>(A a) => Some(a);

Option<A> option<A>(bool test, A value) => test ? some(value) : none();

Option<A> fromNullable<A>(A? a) => a != null ? some(a) : none();

Option<A> tryCatch<A>(Lazy<A> f) {
  try {
    return some(f());
  } catch (e) {
    return none();
  }
}
