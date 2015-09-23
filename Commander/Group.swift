/// Represents a group of commands
public class Group : CommandType {
  private var commands = [String:CommandType]()

  /// Create a new group
  public init() {}

  /// Add a named sub-command to the group
  public func addCommand(name:String, _ command:CommandType) {
    commands[name] = command
  }

  /// Run the group command
  public func run(parser:ArgumentParser) throws {
    if let name = parser.shift() {
      if let command = commands[name] {
        try command.run(parser)
      }
    }
  }
}

extension Group {
  public convenience init(closure:Group -> ()) {
    self.init()
    closure(self)
  }

  /// Add a sub-group using a closure
  public func group(name:String, closure:Group -> ()) {
    addCommand(name, Group(closure: closure))
  }

  /// Add a command using a closure
  public func command(name:String, closure:() -> ()) {
    addCommand(name, AnonymousCommand { parser in closure() })
  }

  /// Add a command which takes one argument using a closure
  public func command<A : ArgumentConvertible>(name:String, closure:A -> ()) {
    addCommand(name, Commander.command(closure))
  }
}
