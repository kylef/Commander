import XCTest


class CommanderTests: XCTestCase {
  func testRunCommander() {
    testArgumentParser()
    testArgumentConvertible()
    testCommandType()
    testCommand()
    testGroup()
  }
}
