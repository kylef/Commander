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
public func command<A:ArgumentConvertible>(closure:A -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser))
  }
}

/// Create a command which takes two arguments using a closure
public func command<A:ArgumentConvertible, B:ArgumentConvertible>(closure:(A, B) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser), try B(parser: parser))
  }
}

/// Create a command which takes three arguments using a closure
public func command<A:ArgumentConvertible, B:ArgumentConvertible, C:ArgumentConvertible>(closure:(A, B, C) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser), try B(parser: parser), try C(parser: parser))
  }
}

/// Create a command which takes four arguments using a closure
public func command<A:ArgumentConvertible, B:ArgumentConvertible, C:ArgumentConvertible, D:ArgumentConvertible>(closure:(A, B, C, D) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser), try B(parser: parser), try C(parser: parser), try D(parser: parser))
  }
}

/// Create a command which takes five arguments using a closure
public func command<A:ArgumentConvertible, B:ArgumentConvertible, C:ArgumentConvertible, D:ArgumentConvertible, E:ArgumentConvertible>(closure:(A, B, C, D, E) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure(try A(parser: parser), try B(parser: parser), try C(parser: parser), try D(parser: parser), try E(parser: parser))
  }
}