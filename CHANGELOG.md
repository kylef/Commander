# Commander Changelog

## 0.8.0

### Bug fixes

- Project passes swift linting now

### Enhancements

- Allow for optional values with Options, Arguments, Flags, etc...
- Reorganized code a little so that the ArgumentDescription.swift file wasn't so large

## 0.7.0

### Bug Fixes

- Better detection of ANSI support in output tty.
  [#43](https://github.com/kylef/Commander/issues/43)

## 0.6.0

### Enhancements

- `VariadicArgument` now supports an optional validator.
- Adds support for variadic options, allowing the user to repeat options to
  provide additional values.
  [#37](https://github.com/kylef/Commander/issues/37)
- Argument descriptions are now printed in command help.
  [#33](https://github.com/kylef/Commander/issues/33)
- Default option and flag default values will now be shown in help output.
  Only default option types of String and Int are currently supported in help output.
  [#34](https://github.com/kylef/Commander/issues/34)

### Bug Fixes

- `VaradicArgument` has been renamed to `VariadicArgument`.


## 0.5.0

### Enhancements

- Adds support for Swift 3.0

## 0.4.1

### Bug Fixes

- Fix a potential crash when `UsageError` is thrown on Linux.
- `--help` output now wraps arguments in diamonds `<>`.
