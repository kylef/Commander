import XCTest


class CommanderTests: XCTestCase {
  func testRunCommander() {
    testArgumentParser()
    testArgumentConvertible()
    testArgumentDescription()
    testCommandType()
    testCommand()
    testGroup()
  }
}
