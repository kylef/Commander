public class Option<T : ArgumentConvertible> : ArgumentDescriptor {
  public typealias ValueType = T?
  public typealias Validator = (ValueType) throws -> ValueType

  public let name: String
  public let flag: Character?
  public let description: String?
  public let `default`: ValueType
  public var type: ArgumentType { return .option }
  public let validator: Validator?

  public init(_ name: String, default: ValueType = nil, flag: Character? = nil, description: String? = nil, validator: Validator? = nil) {
    self.name = name
    self.flag = flag
    self.description = description
    self.`default` = `default`
    self.validator = validator
  }

  public func parse(_ parser: ArgumentParser) throws -> ValueType? {
    if let value = try parser.shiftValueForOption(name) {
      let value = try T(string: value)

      if let validator = validator {
        return try validator(value)
      }

      return value
    }

    if let flag = flag {
      if let value = try parser.shiftValueForFlag(flag) {
        let value = try T(string: value)

        if let validator = validator {
          return try validator(value)
        }

        return value
      }
    }

    return `default`
  }
}

public class Options<T : ArgumentConvertible> : ArgumentDescriptor {
  public typealias ValueType = [T]?

  public let name: String
  public let description: String?
  public let count: Int
  public let `default`: ValueType
  public var type: ArgumentType { return .option }

  public init(_ name: String, _ default: ValueType, count: Int, description: String? = nil) {
    self.name = name
    self.`default` = `default`
    self.count = count
    self.description = description
  }

  public func parse(_ parser: ArgumentParser) throws -> ValueType? {
    let values = try parser.shiftValuesForOption(name, count: count)
    return try values?.map { try T(string: $0) } ?? `default`
  }
}

public class VariadicOption<T : ArgumentConvertible> : ArgumentDescriptor {
  public typealias ValueType = [T]

  public let name: String
  public let description: String?
  public let `default`: ValueType
  public var type: ArgumentType { return .option }

  public init(_ name: String, _ default: ValueType = [], description: String? = nil) {
    self.name = name
    self.`default` = `default`
    self.description = description
  }

  public func parse(_ parser: ArgumentParser) throws -> ValueType? {
    var values: ValueType? = nil

    while let shifted = try parser.shiftValueForOption(name) {
      let argument = try T(string: shifted)

      if values == nil {
        values = ValueType()
      }
      values?.append(argument)
    }

    return values ?? `default`
  }
}
