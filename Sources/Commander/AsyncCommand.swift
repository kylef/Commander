#if compiler(>=5.5)
/// A simple AsyncCommandType using a closure
struct AnonymousAsyncCommand : AsyncCommandType {
  var closure:(ArgumentParser) async throws -> ()

  init(_ closure:@escaping ((ArgumentParser) async throws -> ())) {
    self.closure = closure
  }

  func run(_ parser:ArgumentParser) async throws {
    try await closure(parser)
  }
}

/// Create a command using a closure
public func command(_ closure: @escaping () async throws -> ()) -> AsyncCommandType {
  return AnonymousAsyncCommand { parser in
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

#endif