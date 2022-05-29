## [0.0.1] - TODO: Add release date.

* TODO: Describe initial release.

## [0.2.0] - 29.05.2022

Added new type Result that represents either success (Ok) or failure (Err).

A number of new methods have been added for Result and Option:
* `ifSome`, `ifNone`, `ifSomeElse`, `when` (Option) and `ifOk`, `ifErr`, `ifOkElse`, `when` for getting internal value using callbacks;
* static method `flatten` that converts from `Option<Option<T>>` to `Option<T>` and respectively `Result<Result<T, E>, E>` to `Result<T, E>`;
* static method `transpose` for both classes that transposes a Result of an Option into an Option of a Result (and vice versa);
* added tests for all methods (code coverage is 100%).