public class VariadicArgument<T: ArgumentConvertible>: ArgumentDescriptor {
  public typealias ValueType = [T]?
  public typealias Validator = (ValueType) throws -> ValueType

  public let name: String
  public let description: String?
  public let validator: Validator?

  public var type: ArgumentType { return .argument }

  public init(_ name: String, description: String? = nil, validator: Validator? = nil) {
    self.name = name
    self.description = description
    self.validator = validator
  }

  public func parse(_ parser: ArgumentParser) throws -> ValueType? {
    let value = try [T](parser: parser)

    if let validator = validator {
      return try validator(value)
    }

    return value
  }
}

@available(*, deprecated, message: "use VariadicArgument instead")
typealias VaradicArgument<T : ArgumentConvertible> = VariadicArgument<T>

public class Argument<T : ArgumentConvertible> : ArgumentDescriptor {
  public typealias ValueType = T?
  public typealias Validator = (ValueType) throws -> ValueType

  public let name: String
  public let description: String?
  public let validator: Validator?

  public var type: ArgumentType { return .argument }

  public init(_ name: String, description: String? = nil, validator: Validator? = nil) {
    self.name = name
    self.description = description
    self.validator = validator
  }

  public func parse(_ parser: ArgumentParser) throws -> ValueType? {
    let value: T

    do {
      value = try T(parser: parser)
    } catch ArgumentError.missingValue {
      throw ArgumentError.missingValue(argument: name)
    } catch {
      throw error
    }

    if let validator = validator {
      return try validator(value)
    }

    return value
  }
}
