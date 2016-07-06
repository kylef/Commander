#if swift(>=3.0)
#else
typealias ErrorProtocol ErrorType

extension SequenceType where Generator.Element : SequenceType {
  func joined(separator separator: String) -> String {
    return joinWithSeparator(separator)
  }
}

extension Array {
  mutating func remove(index index: Int) {

  }

  mutating func insert(o: atIndex: Int) {

  }
}
#endif
