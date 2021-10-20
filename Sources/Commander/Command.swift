/// A simple CommandType using a closure
struct AnonymousCommand : CommandType {
  var closure:(ArgumentParser) async throws -> ()

  init(_ closure:@escaping ((ArgumentParser) async throws -> ())) {
    self.closure = closure
  }

  func run(_ parser:ArgumentParser) async throws {
    try await closure(parser)
  }
}

enum CommandError : Error {
  case invalidArgument
}

/// Create a command using a closure
public func command(_ closure: @escaping () async throws -> ()) async -> CommandType {
  return AnonymousCommand { parser in
    let help = Help([])

    if parser.hasOption("help") {
      throw help
    }

    if !parser.isEmpty {
      throw UsageError("Unknown Arguments: \(parser)", help)
    }

    try await closure()
  }
}
