# Commander Changelog

## 0.9.0 (2019-06-12)

### Breaking

- Support for Swift < 4.2 has been removed.

### Enhancements

- Added syntax for using array as a type with `Argument` instead of using
  `VariadicArgument`:

    ```swift
    command(Argument<[String]>("names")) { names in }
    ```

- Added support for optional arguments and options, for example:

    ```swift
    command(Argument<String?>("name")) { name in }
    command(Option<String?>("name", default: nil)) { name in }
    ```

- Added support for using `--` to signal that subsequent values should
  be treated as arguments instead of options.  
  [Tamas Lustyik](https://github.com/lvsti)

- Output of `--help` for group commands will now sort the commands in
  alphabetical order.  
  [Cameron Mc Gorian](https://github.com/sbarow)

### Bug Fixes

- Showing default values for custom `ArgumentConvertible` types are now
  supported in the `--help` output of commands.

- Only print errors in red if the output terminal supports ANSI colour codes.
  [#58](https://github.com/kylef/Commander/pull/58)

- `ArgumentParser.isEmpty` will now return empty for empty arguments.

## 0.8.0

### Enhancements

- Consolidate the argument descriptors:
  - All Option-related types now have a validator.
  - All Option-related types now have a flag parameter.
  - All constructors have the same constructor arguments order. [#35](https://github.com/kylef/Commander/issues/35)

### Bug Fixes

- Restores compatibility with Linux.

## 0.7.1

### Bug Fixes

- The Swift Package now contains the Commander library product.

## 0.7.0

Switches to Swift 4.0.

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
