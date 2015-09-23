import XCTest
import Commander


class CommandTests : XCTestCase {
  func testCommandWithoutArguments() {
    let parser = ArgumentParser(arguments: [])
    var didRun = false

    command {
      didRun = true
    }.run(parser)

    XCTAssertTrue(didRun)
  }

  func testCommandWithOnePositionalArgument() {
    let parser = ArgumentParser(arguments: ["Kyle", "Fuller"])
    var ranName:String? = nil

    command { (name:String) in
      ranName = name
    }.run(parser)

    XCTAssertEqual(ranName, "Kyle")
  }
}
