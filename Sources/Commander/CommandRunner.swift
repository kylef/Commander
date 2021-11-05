#if os(Linux)
  import Glibc
#elseif os(Windows)
  import CRT
#else
  import Darwin
#endif


/// Extensions to CommandType to provide convinience running methods for CLI tools
extension CommandType {
  /// Run the command using the `Process.argument`, removing the executable name
  public func run(_ version:String? = nil) -> Void  {
    let parser = ArgumentParser(arguments: CommandLine.arguments)

    if parser.hasOption("version") && !parser.hasOption("help") {
      if let version = version {
        print(version)
        exit(0)
      }
    }

    let executableName = parser.shift()!  // Executable Name

    do {
      try run(parser)
    } catch let error as Help {
      let help = error.reraise("$ \(executableName)")
      help.print()
      exit(1)
    } catch GroupError.noCommand(let path, let group) {
      var usage = "$ \(executableName)"
      if let path = path {
        usage += " \(path)"
      }
      let help = Help([], command: usage, group: group)
      help.print()
      exit(1)
    } catch let error as ANSIConvertible {
      error.print()
      exit(1)
    } catch {
      ANSI.red.print("An error occurred: \(error)", to: stderr)
      exit(1)
    }

    exit(0)
  }
}

#if compiler(>=5.5)
/// Extensions to AsyncommandType to provide convinience running methods for CLI tools
@available(macOS 12, *)
extension AsyncCommandType {
  /// Run the command using the `Process.argument`, removing the executable name
  public func run(_ version:String? = nil) async -> Void  {
    let parser = ArgumentParser(arguments: CommandLine.arguments)

    if parser.hasOption("version") && !parser.hasOption("help") {
      if let version = version {
        print(version)
        exit(0)
      }
    }

    let executableName = parser.shift()!  // Executable Name

    do {
      try await run(parser)
    } catch let error as Help {
      let help = error.reraise("$ \(executableName)")
      help.print()
      exit(1)
    } catch GroupError.noCommand(let path, let group) {
      var usage = "$ \(executableName)"
      if let path = path {
        usage += " \(path)"
      }
      let help = Help([], command: usage, group: group)
      help.print()
      exit(1)
    } catch let error as ANSIConvertible {
      error.print()
      exit(1)
    } catch {
      ANSI.red.print("An error occurred: \(error)", to: stderr)
      exit(1)
    }

    exit(0)
  }
}
#endif