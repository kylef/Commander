import XCTest
import Commander


class ArgumentParserTests : XCTestCase {
  let parser = ArgumentParser(arguments: ["first", "-f", "--verbose", "last"])

  func testShiftingReturnsFirstPositionalArgument() {
    XCTAssertEqual(parser.shift(), "first")
  }

  func testShiftingRemovesPositionalArgument() {
    parser.shift()

    XCTAssertEqual(parser.shift(), "last")
  }

  func testHasOption() {
    XCTAssertTrue(parser.hasOption("verbose"))
  }

  func testDoesNotHaveOption() {
    XCTAssertFalse(parser.hasOption("f"))
  }

  func testHasFlag() {
    XCTAssertTrue(parser.hasFlag("f"))
  }

  func testDoesNotHaveFlag() {
    XCTAssertFalse(parser.hasFlag("v"))
  }
}
