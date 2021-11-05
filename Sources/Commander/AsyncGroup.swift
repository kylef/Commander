#if compiler(>=5.5)
/// Represents a group of commands

open class AsyncGroup : AsyncCommandType {
  struct AsyncSubCommand {
    let name: String
    let description: String?
    let command: AsyncCommandType

    init(name: String, description: String?, command: AsyncCommandType) {
      self.name = name
      self.description = description
      self.command = command
    }
  }

  var commands = [AsyncSubCommand]()
  public var commandNames: [String] {
    return commands.map { $0.name }
  }

  // When set, allows you to override the default unknown command behaviour
  public var unknownCommand: ((_ name: String, _ parser: ArgumentParser) throws -> ())?

  // When set, allows you to override the default no command behaviour
  public var noAsyncCommand: ((_ path: String?, _ group: AsyncGroup, _ parser: ArgumentParser) throws -> ())?

  /// Create a new group
  @available(macOS 12, *)
  public init() {}

  /// Add a named sub-command to the group
  @available(macOS 12, *)
  public func addCommand(_ name: String, _ command: AsyncCommandType) {
    commands.append(AsyncSubCommand(name: name, description: nil, command: command))
  }

  /// Add a named sub-command to the group with a description
  @available(macOS 12, *)
  public func addCommand(_ name: String, _ description: String?, _ command: AsyncCommandType) {
    commands.append(AsyncSubCommand(name: name, description: description, command: command))
  }

  /// Run the group command
  @available(macOS 12, *)
  public func run(_ parser: ArgumentParser) async throws {
    guard let name = parser.shift() else {
      if let noAsyncCommand = noAsyncCommand {
        return try noAsyncCommand(nil, self, parser)
      } else {
        throw GroupError.noAsyncCommand(nil, self)
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
      try await command.command.run(parser)
    } catch GroupError.unknownCommand(let childName) {
      throw GroupError.unknownCommand("\(name) \(childName)")
    } catch GroupError.noAsyncCommand(let path, let group) {
      let path = (path == nil) ? name : "\(name) \(path!)"

      if let noAsyncCommand = noAsyncCommand {
        try noAsyncCommand(path, group, parser)
      } else {
        throw GroupError.noAsyncCommand(path, group)
      }
    } catch let error as Help {
      throw error.reraise(name)
    }
  }
}

extension AsyncGroup {
@available(macOS 12, *)
  public convenience init(closure: (AsyncGroup) async -> ()) async {
    self.init()
    await closure(self)
  }

  /// Add a sub-group using a closure
  @available(macOS 12, *)
  public func group(_ name: String, _ description: String? = nil, closure: (AsyncGroup) async -> ()) async {
    addCommand(name, description, await AsyncGroup(closure: closure))
  }
}
#endif