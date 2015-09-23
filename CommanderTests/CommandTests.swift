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

  func testCommandWithArgumentParser() {
    let parser = ArgumentParser(arguments: [])
    var ranParser:ArgumentParser? = nil

    command { parser in
      ranParser = parser
    }.run(parser)

    XCTAssertTrue(ranParser === parser)
  }
}
