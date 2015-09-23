import XCTest
import Commander


class StringArgumentConvertibleTests : XCTestCase {
  func testValue() {
    let parser = ArgumentParser(arguments: ["argument"])
    let value = String(parser: parser)

    XCTAssertEqual(value, "argument")
  }

  func testNoValue() {
    let parser = ArgumentParser(arguments: [])
    let value = String(parser: parser)

    XCTAssertNil(value)
  }
}


class IntArgumentConvertibleTests : XCTestCase {
  func testValue() {
    let parser = ArgumentParser(arguments: ["5"])
    let value = Int(parser: parser)

    XCTAssertEqual(value, 5)
  }

  func testInvalidValue() {
    let parser = ArgumentParser(arguments: ["five"])
    let value = Int(parser: parser)

    XCTAssertNil(value)
  }

  func testNoValue() {
    let parser = ArgumentParser(arguments: [])
    let value = Int(parser: parser)

    XCTAssertNil(value)
  }
}

class FloatArgumentConvertibleTests : XCTestCase {
  func testValue() {
    let parser = ArgumentParser(arguments: ["5"])
    let value = Float(parser: parser)

    XCTAssertEqual(value, 5)
  }

  func testInvalidValue() {
    let parser = ArgumentParser(arguments: ["five"])
    let value = Float(parser: parser)

    XCTAssertNil(value)
  }

  func testNoValue() {
    let parser = ArgumentParser(arguments: [])
    let value = Float(parser: parser)

    XCTAssertNil(value)
  }
}

class DoubleArgumentConvertibleTests : XCTestCase {
  func testValue() {
    let parser = ArgumentParser(arguments: ["5"])
    let value = Double(parser: parser)

    XCTAssertEqual(value, 5)
  }

  func testInvalidValue() {
    let parser = ArgumentParser(arguments: ["five"])
    let value = Double(parser: parser)

    XCTAssertNil(value)
  }

  func testNoValue() {
    let parser = ArgumentParser(arguments: [])
    let value = Double(parser: parser)

    XCTAssertNil(value)
  }
}