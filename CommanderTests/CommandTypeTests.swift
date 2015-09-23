import XCTest
import Commander


class CommandTypeTests : XCTestCase {
  func testRunWithArgumentsArray() {
    var firstArgument:String? = nil

    try! command { (parser:ArgumentParser) in
      firstArgument = parser.shift()
    }.run(["test"])

    XCTAssertEqual(firstArgument, "test")
  }
}
