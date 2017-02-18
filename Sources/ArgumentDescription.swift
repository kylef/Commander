public enum ArgumentType {
  case argument
  case option
}

public protocol ArgumentDescriptor {
  associatedtype ValueType

  /// The arguments name
  var name: String { get }

  /// The arguments description
  var description: String? { get }

  var type: ArgumentType { get }

  /// Parse the argument
  func parse(_ parser: ArgumentParser) throws -> ValueType
}

extension ArgumentConvertible {
  init(string: String) throws {
    try self.init(parser: ArgumentParser(arguments: [string]))
  }
}

class BoxedArgumentDescriptor {
  let name: String
  let description: String?
  let `default`: String?
  let type: ArgumentType

  init<T: ArgumentDescriptor>(value: T) {
    name = value.name
    description = value.description
    type = value.type

    if let value = value as? Flag {
      `default` = value.`default`?.description
    } else if let value = value as? Option<String> {
      `default` = value.`default`?.description
    } else if let value = value as? Option<Int> {
      `default` = value.`default`?.description
    } else {
      // TODO, default for Option of generic type
      `default` = nil
    }
  }
}

class UsageError: Error, ANSIConvertible, CustomStringConvertible {
  let message: String
  let help: Help

  init(_ message: String, _ help: Help) {
    self.message = message
    self.help = help
  }

  var description: String {
    return [message, help.description].filter { !$0.isEmpty }.joined(separator: "\n\n")
  }

  var ansiDescription: String {
    return [message, help.ansiDescription].filter { !$0.isEmpty }.joined(separator: "\n\n")
  }
}

class Help: Error, ANSIConvertible, CustomStringConvertible {
  let command: String?
  let group: Group?
  let descriptors: [BoxedArgumentDescriptor]

  init(_ descriptors: [BoxedArgumentDescriptor], command: String? = nil, group: Group? = nil) {
    self.command = command
    self.group = group
    self.descriptors = descriptors
  }

  func reraise(_ command: String? = nil) -> Help {
    if let oldCommand = self.command, let newCommand = command {
      return Help(descriptors, command: "\(newCommand) \(oldCommand)")
    }
    return Help(descriptors, command: command ?? self.command)
  }

  var description: String {
    var output = [String]()

    let arguments = descriptors.filter { $0.type == ArgumentType.argument }
    let options = descriptors.filter { $0.type == ArgumentType.option }

    if let command = command {
      let args = arguments.map { "<\($0.name)>" }
      let usage = ([command] + args).joined(separator: " ")

      output.append("Usage:")
      output.append("")
      output.append("    \(usage)")
      output.append("")
    }

    if let group = group {
      output.append("Commands:")
      output.append("")
      for command in group.commands {
        if let description = command.description {
          output.append("    + \(command.name) - \(description)")
        } else {
          output.append("    + \(command.name)")
        }
      }
      output.append("")
    } else if !arguments.isEmpty {
      output.append("Arguments:")
      output.append("")

      output += arguments.map { argument in
        if let description = argument.description {
          return "    \(argument.name) - \(description)"
        } else {
          return "    \(argument.name)"
        }
      }

      output.append("")
    }

    if !options.isEmpty {
      output.append("Options:")
      for option in options {
        var line = "    --\(option.name)"

        if let `default` = option.default {
          line += " [default: \(`default`)]"
        }

        if let description = option.description {
          line += " - \(description)"
        }

        output.append(line)
      }
    }

    return output.joined(separator: "\n")
  }

  var ansiDescription: String {
    var output = [String]()

    let arguments = descriptors.filter { $0.type == ArgumentType.argument }
    let options = descriptors.filter { $0.type == ArgumentType.option }

    if let command = command {
      let args = arguments.map { "<\($0.name)>" }
      let usage = ([command] + args).joined(separator: " ")

      output.append("Usage:")
      output.append("")
      output.append("    \(usage)")
      output.append("")
    }

    if let group = group {
      output.append("Commands:")
      output.append("")
      for command in group.commands {
        if let description = command.description {
          output.append("    + \(ANSI.green)\(command.name)\(ANSI.reset) - \(description)")
        } else {
          output.append("    + \(ANSI.green)\(command.name)\(ANSI.reset)")
        }
      }
      output.append("")
    } else if !arguments.isEmpty {
      output.append("Arguments:")
      output.append("")

      output += arguments.map { argument in
        if let description = argument.description {
          return "    \(ANSI.blue)\(argument.name)\(ANSI.reset) - \(description)"
        } else {
          return "    \(ANSI.blue)\(argument.name)\(ANSI.reset)"
        }
      }

      output.append("")
    }

    if !options.isEmpty {
      output.append("Options:")
      for option in options {
        var line = "    \(ANSI.blue)--\(option.name)\(ANSI.reset)"

        if let `default` = option.default {
          line += " [default: \(`default`)]"
        }

        if let description = option.description {
          line += " - \(description)"
        }

        output.append(line)
      }
    }

    return output.joined(separator: "\n")
  }
}
