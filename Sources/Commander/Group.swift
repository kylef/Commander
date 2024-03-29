/// Represents a group of commands
open class Group : CommandType {
  struct SubCommand {
    let name: String
    let description: String?
    let command: CommandType

    init(name: String, description: String?, command: CommandType) {
      self.name = name
      self.description = description
      self.command = command
    }
  }

  var commands = [SubCommand]()
  public var commandNames: [String] {
    return commands.map { $0.name }
  }

  // When set, allows you to override the default unknown command behaviour
  public var unknownCommand: ((_ name: String, _ parser: ArgumentParser) throws -> ())?

  // When set, allows you to override the default no command behaviour
  public var noCommand: ((_ path: String?, _ group: Group, _ parser: ArgumentParser) throws -> ())?

  /// Create a new group
  public init() {}

  /// Add a named sub-command to the group
  public func addCommand(_ name: String, _ command: CommandType) {
    commands.append(SubCommand(name: name, description: nil, command: command))
  }

  /// Add a named sub-command to the group with a description
  public func addCommand(_ name: String, _ description: String?, _ command: CommandType) {
    commands.append(SubCommand(name: name, description: description, command: command))
  }

  /// Run the group command
  public func run(_ parser: ArgumentParser) throws {
    guard let name = parser.shift() else {
      if let noCommand = noCommand {
        return try noCommand(nil, self, parser)
      } else {
        throw GroupError.noCommand(nil, self)
      }
    }

    guard let command = commands.first(where: { $0.name == name }) else {
      if let unknownCommand = unknownCommand {
        return try unknownCommand(name, parser)
      } else {
        throw GroupError.unknownCommand(name)
      }
    }

    do {
      try command.command.run(parser)
    } catch GroupError.unknownCommand(let childName) {
      throw GroupError.unknownCommand("\(name) \(childName)")
    } catch GroupError.noCommand(let path, let group) {
      let path = (path == nil) ? name : "\(name) \(path!)"

      if let noCommand = noCommand {
        try noCommand(path, group, parser)
      } else {
        throw GroupError.noCommand(path, group)
      }
    } catch let error as Help {
      throw error.reraise(name)
    }
  }
}

extension Group {
  public convenience init(closure: (Group) -> ()) {
    self.init()
    closure(self)
  }

  /// Add a sub-group using a closure
  public func group(_ name: String, _ description: String? = nil, closure: (Group) -> ()) {
    addCommand(name, description, Group(closure: closure))
  }
}