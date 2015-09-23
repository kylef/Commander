private enum Arg {
  /// A positional argument
  case Argument(String)

  /// A boolean like option, `--version`, `--help`, `--no-clean`.
  case Option(String)

  /// A flag
  case Flag(Set<Character>)
}


public final class ArgumentParser {
  private var arguments:[Arg]

  /// Initialises the ArgumentParser with an array of arguments
  public init(arguments: [String]) {
    self.arguments = arguments.map { argument in
      if argument.hasPrefix("-") {
        let flags = String(argument.substringFromIndex(argument.startIndex.successor()))

        if flags.hasPrefix("-") {
          let option = String(flags.substringFromIndex(argument.startIndex.successor()))
          return .Option(option)
        }

        return .Flag(Set(flags.characters))
      }

      return .Argument(argument)
    }
  }

  /// Returns the first positional argument in the remaining arguments.
  /// This will remove the argument from the remaining arguments.
  public func shift() -> String? {
    for (index, argument) in arguments.enumerate() {
      switch argument {
      case .Argument(let value):
        arguments.removeAtIndex(index)
        return value
      default:
        continue
      }
    }

    return nil
  }

  /// Returns whether an option was specified in the arguments
  public func hasOption(name:String) -> Bool {
    for argument in arguments {
      switch argument {
      case .Option(let option):
        if option == name {
          return true
        }
      default:
        continue
      }
    }

    return false
  }

  /// Returns whether a flag was specified in the arguments
  public func hasFlag(flag:Character) -> Bool {
    for argument in arguments {
      switch argument {
      case .Flag(let option):
        if option.contains(flag) {
          return true
        }
      default:
        continue
      }
    }

    return false
  }
}
