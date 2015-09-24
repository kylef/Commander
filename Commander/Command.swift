/// A simple CommandType using a closure
struct AnonymousCommand : CommandType {
  var closure:ArgumentParser throws -> ()

  init(_ closure:(ArgumentParser throws -> ())) {
    self.closure = closure
  }

  func run(parser:ArgumentParser) throws {
    try closure(parser)
  }
}

enum CommandError : ErrorType {
  case InvalidArgument
}

/// Create a command using a closure
public func command(closure:() -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure()
  }
}

/// Create a command which takes one argument using a closure
public func command<A : ArgumentConvertible>(closure:A -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser))
  }
}

/// Create a command which takes two arguments using a closure
public func command<A : ArgumentConvertible, B : ArgumentConvertible>(closure:(A, B) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser), try B(parser: parser))
  }
}


/// Create a command which takes three arguments using a closure
public func command<A : ArgumentConvertible, B : ArgumentConvertible, C : ArgumentConvertible>(closure:(A, B, C) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser), try B(parser: parser), try C(parser: parser))
  }
}
