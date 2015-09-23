/// A simple CommandType using a closure
struct AnonymousCommand : CommandType {
  var closure:ArgumentParser -> ()

  init(_ closure:(ArgumentParser -> ())) {
    self.closure = closure
  }

  func run(parser:ArgumentParser) {
    closure(parser)
  }
}


/// Create a command using a closure
public func command(closure:() -> ()) -> CommandType {
  return AnonymousCommand { parser in
    closure()
  }
}

/// Create a command which takes the argument parser using a closure
public func command(closure:ArgumentParser -> ()) -> CommandType {
  return AnonymousCommand(closure)
}
