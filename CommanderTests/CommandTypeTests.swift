import XCTest
import Commander


class CommandTypeTests : XCTestCase {
  func testRunWithArgumentsArray() {
    var firstArgument:String? = nil

    command { parser in
      firstArgument = parser.shift()
    }.run(["test"])

    XCTAssertEqual(firstArgument, "test")
  }
}
