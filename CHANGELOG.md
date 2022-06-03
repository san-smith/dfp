## [0.3.0] - 03.05.2022

Added new methods to `Option` and `Result`.

Option:

- `flatMap` - returns None or calls `f` with the wrapped value and returns `Some(f(value))`;
- `filter` - returns None if the option is None or predicate returns false, otherwise returns Some.

Result:

- `flatMap` - calls `f` if the result is `Ok`, otherwise returns the `Err` value of self;
- `flatMapErr` - Calls `f` if the result is `Err`, otherwise returns the `Ok` value of self.

## [0.2.1] - 31.05.2022

Restricted the parameterized type E for tryCatch and asyncTryCatch.

Fixed typos in the README and expanded the description of `Option` class.

## [0.2.0] - 29.05.2022

Added new type Result that represents either success (Ok) or failure (Err).

A number of new methods have been added for Result and Option:

- `ifSome`, `ifNone`, `ifSomeElse`, `when` (Option) and `ifOk`, `ifErr`, `ifOkElse`, `when` for getting internal value using callbacks;
- static method `flatten` that converts from `Option<Option<T>>` to `Option<T>` and respectively `Result<Result<T, E>, E>` to `Result<T, E>`;
- static method `transpose` for both classes that transposes a Result of an Option into an Option of a Result (and vice versa);
- added tests for all methods (code coverage is 100%).

## [0.0.1] - TODO: Add release date.

- TODO: Describe initial release.
