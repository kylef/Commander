public class Flag: ArgumentDescriptor {
  public typealias ValueType = Bool?

  public let name: String
  public let flag: Character?
  public let disabledName: String
  public let disabledFlag: Character?
  public let description: String?
  public let `default`: ValueType
  public var type: ArgumentType { return .option }

  public init(_ name: String, flag: Character? = nil, disabledName: String? = nil, disabledFlag: Character? = nil,
              description: String? = nil, default: Bool = false) {
    self.name = name
    self.disabledName = disabledName ?? "no-\(name)"
    self.flag = flag
    self.disabledFlag = disabledFlag
    self.description = description
    self.`default` = `default`
  }

  public func parse(_ parser: ArgumentParser) throws -> ValueType? {
    if parser.hasOption(disabledName) {
      return false
    }

    if parser.hasOption(name) {
      return true
    }

    if let flag = flag {
      if parser.hasFlag(flag) {
        return true
      }
    }
    if let disabledFlag = disabledFlag {
      if parser.hasFlag(disabledFlag) {
        return false
      }
    }

    return `default`
  }
}
