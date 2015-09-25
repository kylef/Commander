import XCTest
import Commander


class ArgumentParserTests : XCTestCase {
  let parser = ArgumentParser(arguments: ["first", "-f", "--verbose", "middle", "end"])

  func testShiftingReturnsFirstPositionalArgument() {
    XCTAssertEqual(parser.shift(), "first")
  }

  func testShiftingRemovesPositionalArgument() {
    parser.shift()

    XCTAssertEqual(parser.shift(), "middle")
  }

  func testHasOption() {
    XCTAssertTrue(parser.hasOption("verbose"))
    XCTAssertFalse(parser.hasOption("verbose"))
  }

  func testDoesNotHaveOption() {
    XCTAssertFalse(parser.hasOption("f"))
  }

  func testHasFlag() {
    XCTAssertTrue(parser.hasFlag("f"))
    XCTAssertFalse(parser.hasFlag("f"))
  }

  func testDoesNotHaveFlag() {
    XCTAssertFalse(parser.hasFlag("v"))
  }

  func testValueForOptionMissing() {
    let value = try! parser.shiftValueForOption("unknown")
    XCTAssertNil(value)
  }

  func testValueForOption() {
    let value = try! parser.shiftValueForOption("verbose")
    XCTAssertEqual(value, "middle")
  }

  func testValueForOptionThrowsWhenValueIsNotPositionalArgument() {
    let parser = ArgumentParser(arguments: ["--verbose", "-t"])

    do {
      try parser.shiftValueForOption("verbose")
      XCTFail("Unexpected Success")
    } catch let error as CustomStringConvertible {
      XCTAssertEqual(error.description, "Unexpected flag `-t` as a value for `--verbose`")
    } catch {
      XCTFail("Unexpected error")
    }
  }

  func testValueForOptionThrowsWhenValueIsMissing() {
    let parser = ArgumentParser(arguments: ["--verbose"])

    do {
      try parser.shiftValueForOption("verbose")
      XCTFail("Unexpected Success")
    } catch let error as CustomStringConvertible {
      XCTAssertEqual(error.description, "Missing value for `--verbose`")
    } catch {
      XCTFail("Unexpected error")
    }
  }

  func testValuesForOption() {
    let value = try! parser.shiftValuesForOption("verbose", count: 2)!
    XCTAssertEqual(value, ["middle", "end"])
  }
}
