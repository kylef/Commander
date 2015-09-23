import XCTest
import Commander


class GroupTests : XCTestCase {
  func testGroupDispatchesSubCommands() {
    var didRunHelpCommand = false

    let group = Group()
    group.addCommand("help", command {
      didRunHelpCommand = true
    })

    XCTAssertFalse(didRunHelpCommand)

    try! group.run(["unknown"])
    XCTAssertFalse(didRunHelpCommand)

    try! group.run(["help"])
    XCTAssertTrue(didRunHelpCommand)
  }

  // MARK: Extension

  func testClosureConvinienceInitialiser() {
    var didRunHelpCommand = false

    let group = Group {
      $0.addCommand("help", command {
        didRunHelpCommand = true
      })
    }

    try! group.run(["unknown"])
    XCTAssertFalse(didRunHelpCommand)

    try! group.run(["help"])
    XCTAssertTrue(didRunHelpCommand)
  }

  func testSubGroup() {
    var didRun = false

    try! Group {
      $0.group("group") {
        $0.command("test") {
          didRun = true
        }
      }
    }.run(["group", "test"])

    XCTAssertTrue(didRun)
  }

  func testSubCommand() {
    var didRun = false

    try! Group {
      $0.command("test") {
        didRun = true
      }
    }.run(["test"])

    XCTAssertTrue(didRun)
  }

  func testSubCommandWithArgument() {
    var givenName:String? = nil

    try! Group {
      $0.command("test") { (name:String) in
        givenName = name
      }
    }.run(["test", "kyle"])

    XCTAssertEqual(givenName, "kyle")
  }
}
