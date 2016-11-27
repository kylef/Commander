# Commander Changelog

## Master

### Enhancements

- `VariadicArgument` now supports an optional validator.
- Adds support for variadic options, allowing the user to repeat options to
  provide additional values.
  [#37](https://github.com/kylef/Commander/issues/37)
- Argument descriptions are now printed in command help.
  [#33](https://github.com/kylef/Commander/issues/33)

### Bug Fixes

- `VaradicArgument` has been renamed to `VariadicArgument`.


## 0.5.0

### Enhancements

- Adds support for Swift 3.0

## 0.4.1

### Bug Fixes

- Fix a potential crash when `UsageError` is thrown on Linux.
- `--help` output now wraps arguments in diamonds `<>`.
