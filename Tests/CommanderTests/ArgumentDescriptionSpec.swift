import Spectre
@testable import Commander


public func testArgumentDescription() {
  describe("help") {
    $0.it("shows arguments") {
      let help = Help([
        BoxedArgumentDescriptor(value: Argument<String>("arg1")),
        BoxedArgumentDescriptor(value: Argument<String>("arg2", description: "an example")),
      ])

      try expect(help.description) == "Arguments:\n\n    arg1\n    arg2 - an example\n"
      try expect(help.ansiDescription) == "Arguments:\n\n    \(ANSI.blue)arg1\(ANSI.reset)\n    \(ANSI.blue)arg2\(ANSI.reset) - an example\n"
    }
  }
}
