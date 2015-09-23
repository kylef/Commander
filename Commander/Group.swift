/// Represents a group of commands
public class Group : CommandType {
  private var commands = [String:CommandType]()

  /// Create a new group
  public init() {}

  /// Add a named sub-command to the group
  public func addCommand(name:String, command:CommandType) {
    commands[name] = command
  }

  /// Run the group command
  public func run(parser:ArgumentParser) {
    if let name = parser.shift() {
      if let command = commands[name] {
        command.run(parser)
      }
    }
  }
}

extension Group {
  public convenience init(closure:Group -> ()) {
    self.init()
    closure(self)
  }
}
