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

    assertRaises(try group.run(["unknown"]))
    XCTAssertFalse(didRunHelpCommand)

    try! group.run(["help"])
    XCTAssertTrue(didRunHelpCommand)
  }

  func testRunningCommandReRaisesCommandName() {
    let group = Group {
      $0.group("subgroup") {
        $0.command("command") {}
      }
    }

    do {
      try group.run(["subgroup", "yo"])
      XCTFail("Didn't raise error")
    } catch GroupError.UnknownCommand(let command) {
      XCTAssertEqual(command, "subgroup yo")
    } catch {
      XCTFail("Unexpected error")
    }
  }

  func testRunningCommandMissingCommandNameRaises() {
    let group = Group()

    do {
      try group.run([])
      XCTFail("Didn't raise error")
    } catch GroupError.NoCommand(let path, let raisedGroup) {
      XCTAssertNil(path)
      XCTAssertTrue(raisedGroup === group)
    } catch {
      XCTFail("Unexpected error")
    }
  }


  func testRunningCommandWithSubGroupMissingCommandNameReraises() {
    let subgroup = Group()
    let group = Group { $0.addCommand("group", subgroup) }

    do {
      try group.run(["group"])
      XCTFail("Didn't raise error")
    } catch GroupError.NoCommand(let path, let raisedGroup) {
      XCTAssertEqual(path, "group")
      XCTAssertTrue(raisedGroup === subgroup)
    } catch {
      XCTFail("Unexpected error")
    }
  }

  func testRunningCommandWithSubSubGroupMissingCommandNameReraises() {
    let subsubgroup = Group()
    let subgroup = Group { $0.addCommand("g2", subsubgroup) }
    let group = Group { $0.addCommand("g1", subgroup) }

    do {
      try group.run(["g1", "g2"])
      XCTFail("Didn't raise error")
    } catch GroupError.NoCommand(let path, let raisedGroup) {
      XCTAssertEqual(path, "g1 g2")
      XCTAssertTrue(raisedGroup === subsubgroup)
    } catch {
      XCTFail("Unexpected error")
    }
  }

  // MARK: Extension

  func testClosureConvinienceInitialiser() {
    var didRunHelpCommand = false

    let group = Group {
      $0.addCommand("help", command {
        didRunHelpCommand = true
      })
    }

    assertRaises(try group.run(["unknown"]))
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

class GroupErrorTests : XCTestCase {
  let group = Group {
    $0.command("create") {}
    $0.command("lint") {}
  }

  func testUnknownCommandDescription() {
    let error = GroupError.UnknownCommand("pod spec create")
    XCTAssertEqual(error.description, "Unknown command: `pod spec create`")
  }

  func testNoCommandDescription() {
    let error = GroupError.NoCommand("pod lib", group)
    XCTAssertEqual(error.description, "Usage: pod lib COMMAND\n\nCommands: create, lint")
  }

  func testNoCommandWithoutPathDescription() {
    let error = GroupError.NoCommand(nil, group)
    XCTAssertEqual(error.description, "Commands: create, lint")
  }
}
