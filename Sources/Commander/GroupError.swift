public enum GroupError : Error, Equatable, CustomStringConvertible {
  /// No-subcommand was found with the given name
  case unknownCommand(String)

  /// No command was given
  /// :param: The current path to the command (i.e, all the group names)
  /// :param: The group raising the error
  case noCommand(String?, Group)
  
  #if compiler(>=5.5)
  case noAsyncCommand(String?, AsyncGroup)
  #endif

  public var description:String {
    switch self {
    case .unknownCommand(let name):
      return "Unknown command: `\(name)`"
    case .noCommand(let path, let group):
      let available = group.commands.map { $0.name }.sorted().joined(separator: ", ")
      if let path = path {
        return "Usage: \(path) COMMAND\n\nCommands: \(available)"
      } else {
        return "Commands: \(available)"
      }
#if compiler(>=5.5)
    case .noAsyncCommand(let path, let group):
      let available = group.commands.map { $0.name }.sorted().joined(separator: ", ")
      if let path = path {
        return "Usage: \(path) COMMAND\n\nCommands: \(available)"
      } else {
        return "Commands: \(available)"
      }
#endif
    }
  }
}

public func == (lhs: GroupError, rhs: GroupError) -> Bool {
  switch (lhs, rhs) {
  case let (.unknownCommand(lhsCommand), .unknownCommand(rhsCommand)):
    return lhsCommand == rhsCommand
  case let (.noCommand(lhsPath, lhsGroup), .noCommand(rhsPath, rhsGroup)):
    return lhsPath == rhsPath && lhsGroup === rhsGroup
#if compiler(>=5.5)
  case let (.noAsyncCommand(lhsPath, lhsGroup), .noAsyncCommand(rhsPath, rhsGroup)):
    return lhsPath == rhsPath && lhsGroup === rhsGroup
#endif
  default:
    return false
  }
}