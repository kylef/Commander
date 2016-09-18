import Spectre
import Commander


extension ExpectationType where ValueType == CommandType {
  func run(_ arguments: [String]? = nil) throws -> Expectation<Void> {
    if let command = try expression() {
      return expect {
        try command.run(arguments ?? [])
      }
    }

    throw failure("command was nil")
  }
}


public func testCommand() {
  describe("Command") {
    $0.it("allows you to create a command with no arguments") {
      let parser = ArgumentParser(arguments: [])
      var didRun = false
      try command { didRun = true }.run(parser)

      try expect(didRun).to.beTrue()
    }

    $0.it("allows you to create a command with a single positional argument") {
      let parser = ArgumentParser(arguments: ["Kyle", "Fuller"])
      var ranName: String? = nil
      try command { (name:String) in ranName = name }.run(parser)

      try expect(ranName) == "Kyle"
    }

    $0.describe("with described arguments") {
      $0.it("allows you to create a command with described arguments") {
        var givenName = ""
        let c = command(
          Argument("name")
        ) { name in givenName = name }
        try c.run(["Kyle"])

        try expect(givenName) == "Kyle"
      }

      $0.it("errors when required arguments are missing") {
        let c = command(Argument<String>("name")) { _ in }
        try expect(c).run([]).toThrow(ArgumentError.missingValue(argument: "name"))
      }

      $0.it("errors when invalid arguments are passed") {
        let verboseCommand = command(Flag("verbose")) { verbose in }
        try expect(verboseCommand).run(["--unknown"]).toThrow()
      }

      $0.it("doesn't error for known arguments") {
        let verboseCommand = command(Flag("verbose")) { verbose in }
        try verboseCommand.run(["--verbose"])
      }
    }
  }
}
