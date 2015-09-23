import XCTest
import Commander


class GroupTests : XCTestCase {
  func testGroupDispatchesSubCommands() {
    var didRunHelpCommand = false

    let group = Group()
    group.addCommand("help", command: command {
      didRunHelpCommand = true
    })

    XCTAssertFalse(didRunHelpCommand)

    group.run(["unknown"])
    XCTAssertFalse(didRunHelpCommand)

    group.run(["help"])
    XCTAssertTrue(didRunHelpCommand)
  }

  // MARK: Extension

  func testClosureConvinienceInitialiser() {
    var didRunHelpCommand = false

    let group = Group {
      $0.addCommand("help", command: command {
        didRunHelpCommand = true
      })
    }

    group.run(["unknown"])
    XCTAssertFalse(didRunHelpCommand)

    group.run(["help"])
    XCTAssertTrue(didRunHelpCommand)
  }
}
