public enum ArgumentError : ErrorType, CustomStringConvertible {
  case MissingValue(String?)

  /// Value is not convertible to type
  case InvalidType(value:String, type:String)

  public var description:String {
    switch self {
    case .MissingValue:
      return "Missing argument"
    case .InvalidType(let value, let type):
      return "\(value) is not a \(type)"
    }
  }
}

public protocol ArgumentConvertible {
  /// Initialise the type with an ArgumentParser
  init(parser: ArgumentParser) throws
}

extension String : ArgumentConvertible {
  public init(parser: ArgumentParser) throws {
    if let value = parser.shift() {
      self.init(value)
    } else {
      throw ArgumentError.MissingValue(nil)
    }
  }
}

extension Int : ArgumentConvertible {
  public init(parser: ArgumentParser) throws {
    if let value = parser.shift() {
      if let value = Int(value) {
        self.init(value)
      } else {
        throw ArgumentError.InvalidType(value: value, type: "number")
      }
    } else {
      throw ArgumentError.MissingValue(nil)
    }
  }
}


extension Float : ArgumentConvertible {
  public init(parser: ArgumentParser) throws {
    if let value = parser.shift() {
      if let value = Float(value) {
        self.init(value)
      } else {
        throw ArgumentError.InvalidType(value: value, type: "number")
      }
    } else {
      throw ArgumentError.MissingValue(nil)
    }
  }
}


extension Double : ArgumentConvertible {
  public init(parser: ArgumentParser) throws {
    if let value = parser.shift() {
      if let value = Double(value) {
        self.init(value)
      } else {
        throw ArgumentError.InvalidType(value: value, type: "number")
      }
    } else {
      throw ArgumentError.MissingValue(nil)
    }
  }
}
