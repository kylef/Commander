import XCTest
import Spectre


class CommanderTests: XCTestCase {
  func testRunCommander() {
    describe("ArgumentParser", testArgumentParser)
    describe("ArgumentConvertible", testArgumentConvertible)
    describe("ArgumentDescription", testArgumentDescription)
    describe("CommandType extension", testCommandType)
    describe("Command", testCommand)
    describe("Group", testGroup)
  }
}
