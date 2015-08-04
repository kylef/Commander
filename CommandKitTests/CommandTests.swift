import XCTest
import CommandKit

class CommandTests: XCTestCase {
    var command:Command!

    override func setUp() {
        command = Command("help", "Show help for the given command.")
    }

    func testCommandHasName() {
        XCTAssertEqual(command.name, "help")
    }

    func testCommandHasDescription() {
        XCTAssertEqual(command.description, "Show help for the given command.")
    }

}
