/// Represents a command that can be run, given an argument parser
public protocol CommandType {
  func run(parser:ArgumentParser) throws
}


/// Extensions to CommandType to provide convinience running methods
extension CommandType {
  /// Run the command with an array of arguments
  public func run(arguments:[String]) throws {
    try run(ArgumentParser(arguments: arguments))
  }

  /// Run the command using the `Process.argument`, removing the executable name
  @noreturn public func run() {
    let parser = ArgumentParser(arguments: Process.arguments)
    parser.shift()  // Executable Name

    do {
      try run(parser)
    } catch {
      fputs("\(error)\n", stderr)
      exit(1)
    }

    exit(0)
  }
}
