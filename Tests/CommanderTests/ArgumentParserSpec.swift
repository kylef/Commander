import Spectre
import Commander


public func testArgumentParser() {
    describe("ArgumentParser") {
    var parser: ArgumentParser!

    $0.before {
      parser = ArgumentParser(arguments: ["first", "-f", "--verbose", "middle", "end"])
    }

    $0.describe("shifting") {
      $0.it("provides first positional argument") {
        try expect(parser.shift()) == "first"
      }

      $0.it("removes the shifted positional argument") {
        _ = parser.shift()
        try expect(parser.shift()) == "middle"
      }
    }

    $0.describe("options") {
      $0.it("returns when an option is found") {
        try expect(parser.hasOption("verbose")).to.beTrue()
        try expect(parser.hasOption("verbose")).to.beFalse()
      }

      $0.it("returns when an option is not found") {
        try expect(parser.hasOption("f")).to.beFalse()
      }
    }

    $0.describe("flags") {
      $0.it("returns when a flag is found") {
        try expect(parser.hasFlag("f")).to.beTrue()
        try expect(parser.hasFlag("f")).to.beFalse()
      }

      $0.it("returns when a flag is not found") {
        try expect(parser.hasFlag("v")).to.beFalse()
      }
    }

    $0.describe("when shifting a flag") {
      $0.it("returns the flag value when found") {
        parser = ArgumentParser(arguments: ["-o", "value"])
        let value = try parser.shiftValueForFlag("o")

        try expect(value) == "value"
      }

      $0.it("removes the flag and it's value") {
        parser = ArgumentParser(arguments: ["-o", "value"])
        _ = try parser.shiftValueForFlag("o")

        try expect(parser.description) == ""
      }
    }

    $0.describe("when shifting an option") {
      $0.it("should return the options value") {
        let value = try parser.shiftValueForOption("verbose")
        try expect(value) == "middle"
      }

      $0.it("should return nil when option is unknown") {
        let value = try parser.shiftValueForOption("unknown")
        try expect(value).to.beNil()
      }

      $0.it("should thrown an error when options value is not positional") {
        let parser = ArgumentParser(arguments: ["--verbose", "-t"])
        try expect(try parser.shiftValueForOption("verbose")).toThrow(ArgumentParserError("Unexpected flag `-t` as a value for `--verbose`"))
      }

      $0.it("should throw when value is missing") {
        let parser = ArgumentParser(arguments: ["--verbose"])
        try expect(try parser.shiftValueForOption("verbose")).toThrow(ArgumentError.missingValue(argument: "--verbose"))
      }

      $0.it("should return arguments for option") {
        let value = try parser.shiftValuesForOption("verbose", count: 2)
        try expect(value?.count) == 2
        try expect(value?.first) == "middle"
        try expect(value?.last) == "end"
      }
    }
  }
}
