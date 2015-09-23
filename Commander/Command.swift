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
    if let argument = A(parser: parser) {
      closure(argument)
    } else {
      throw CommandError.InvalidArgument
    }
  }
}

/// Create a command which takes two arguments using a closure
public func command<A : ArgumentConvertible, B : ArgumentConvertible>(closure:(A, B) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    if let argumentA = A(parser: parser),
      argumentB = B(parser: parser)
    {
      closure(argumentA, argumentB)
    } else {
      throw CommandError.InvalidArgument
    }
  }
}


/// Create a command which takes three arguments using a closure
public func command<A : ArgumentConvertible, B : ArgumentConvertible, C : ArgumentConvertible>(closure:(A, B, C) -> ()) -> CommandType {
  return AnonymousCommand { parser in
    if let argumentA = A(parser: parser),
           argumentB = B(parser: parser),
           argumentC = C(parser: parser)
    {
      closure(argumentA, argumentB, argumentC)
    } else {
      throw CommandError.InvalidArgument
    }
  }
}
