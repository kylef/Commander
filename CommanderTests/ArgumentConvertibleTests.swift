import XCTest
import Commander


class ArgumentErrorTests : XCTestCase {
  func testMissingValueDescription() {
    let error = ArgumentError.MissingValue(nil)
    XCTAssertEqual(error.description, "Missing argument")
  }

  func testNoValue() {
    let error = ArgumentError.InvalidType(value: "five", type: "number")
    XCTAssertEqual(error.description, "five is not a number")
  }
}

class StringArgumentConvertibleTests : XCTestCase {
  func testValue() {
    let parser = ArgumentParser(arguments: ["argument"])
    let value = try? String(parser: parser)

    XCTAssertEqual(value!, "argument")
  }

  func testNoValue() {
    testMissingValue { try String(parser: $0) }
  }
}


class IntArgumentConvertibleTests : XCTestCase {
  func testValue() {
    testValidValue("5", value: 5) { try Int(parser: $0) }
  }

  func testInvalidInput() {
    testInvalidValue("five") { try Int(parser: $0) }
  }

  func testNoValue() {
    testMissingValue { try Int(parser: $0) }
  }
}


class FloatArgumentConvertibleTests : XCTestCase {
  func testValue() {
    testValidValue("5", value: 5) { try Float(parser: $0) }
  }

  func testInvalidInput() {
    testInvalidValue("five") { try Float(parser: $0) }
  }

  func testNoValue() {
    testMissingValue { try Float(parser: $0) }
  }
}


class DoubleArgumentConvertibleTests : XCTestCase {
  func testValue() {
    testValidValue("5", value: 5) { try Double(parser: $0) }
  }

  func testInvalidInput() {
    testInvalidValue("five") { try Double(parser: $0) }
  }

  func testNoValue() {
    testMissingValue { try Double(parser: $0) }
  }
}


func testMissingValue<T>(closure:((ArgumentParser) throws -> (T))) {
  let parser = ArgumentParser(arguments: [])

  do {
    try closure(parser)
    XCTFail("Unexpected success")
  } catch ArgumentError.MissingValue {
  } catch {
    XCTFail("Unexpected error: \(error)")
  }
}

func testInvalidValue<T>(value:String, closure:((ArgumentParser) throws -> (T))) {
  let parser = ArgumentParser(arguments: [value])

  do {
    try closure(parser)
    XCTFail("Unexpected success")
  } catch ArgumentError.InvalidType {
  } catch {
    XCTFail("Unexpected error: \(error)")
  }
}

func testValidValue<T>(argument:String, value:T, closure:((ArgumentParser) throws -> (T))) {
  let parser = ArgumentParser(arguments: ["5"])

  do {
    let value = try Int(parser: parser)
    XCTAssertEqual(value, 5)
  } catch {
    XCTFail("Unexpected error: \(error)")
  }
}
