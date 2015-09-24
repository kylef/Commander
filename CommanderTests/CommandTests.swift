import XCTest
import Commander


class CommandTests : XCTestCase {
  func testCommandWithoutArguments() {
    let parser = ArgumentParser(arguments: [])
    var didRun = false

    try! command {
      didRun = true
    }.run(parser)

    XCTAssertTrue(didRun)
  }

  func testCommandWithOnePositionalArgument() {
    let parser = ArgumentParser(arguments: ["Kyle", "Fuller"])
    var ranName:String? = nil

    try! command { (name:String) in
      ranName = name
    }.run(parser)

    XCTAssertEqual(ranName, "Kyle")
  }

  // MARK: Described Arguments

  func testCommandWithDescribedArgument() {
    var givenName = ""

    let c = command(
      Argument("name")
    ) { name in
      givenName = name
    }

    try! c.run(["Kyle"])
    XCTAssertEqual(givenName, "Kyle")
  }
//
//  func testCommandWithDescribedArgumentShowsUsage() {
//    let c = command(
//      Argument("name")
//    ) { name in
//    }
//
//    try! c.run(["Kyle"])
//  }
//
//  func testCommandWithDescribedArgumentHelp() {
//    var givenName = ""
//
//    let c = command(
//      Argument("name", `default`: "World")
//      ) { name in
//        givenName = name
//    }
//
//    try! c.run(["--help"])
//    XCTAssertEqual(givenName, "Kyle")
//  }
}
