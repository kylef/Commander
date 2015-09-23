public protocol ArgumentConvertible {
  /// Initialise the type with an ArgumentParser
  init?(parser: ArgumentParser)
}

extension String : ArgumentConvertible {
  public init?(parser: ArgumentParser) {
    if let value = parser.shift() {
      self.init(value)
    } else {
      return nil
    }
  }
}

extension Int : ArgumentConvertible {
  public init?(parser: ArgumentParser) {
    if let value = parser.shift() {
      self.init(value)
    } else {
      return nil
    }
  }
}


extension Float : ArgumentConvertible {
  public init?(parser: ArgumentParser) {
    if let value = parser.shift() {
      self.init(value)
    } else {
      return nil
    }
  }
}


extension Double : ArgumentConvertible {
  public init?(parser: ArgumentParser) {
    if let value = parser.shift() {
      self.init(value)
    } else {
      return nil
    }
  }
}
