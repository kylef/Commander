import Spectre
import Commander


public func testArgumentParser() {
    describe("ArgumentParser") {
    var parser: ArgumentParser!

    $0.before {
      parser = ArgumentParser(arguments: ["first", "-f", "--verbose", "middle", "end", "--varOption", "varValue1", "--varOption", "varValue2"])
    }

    $0.describe("isEmpty") {
      $0.it("returns when not empty") {
        parser = ArgumentParser(arguments: [])
        try expect(parser.isEmpty).to.beTrue()
      }

      $0.it("returns when not empty") {
        try expect(parser.isEmpty).to.beFalse()
      }

      $0.it("returns empty when containing empty arguments") {
        parser = ArgumentParser(arguments: [""])
        try expect(parser.isEmpty).to.beTrue()
      }
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
        let value = try parser.shiftValue(for: "o" as ArgumentParser.Flag)

        try expect(value) == "value"
      }

      $0.it("removes the flag and it's value") {
        parser = ArgumentParser(arguments: ["-o", "value"])
        _ = try parser.shiftValue(for: "o" as ArgumentParser.Flag)

        try expect(parser.description) == ""
      }
    }

    $0.describe("when shifting an option") {
      $0.it("should return the options value") {
        let value = try parser.shiftValue(for: "verbose")
        try expect(value) == "middle"
      }

      $0.it("should return nil when option is unknown") {
        let value = try parser.shiftValue(for: "unknown")
        try expect(value).to.beNil()
      }

      $0.it("should thrown an error when options value is not positional") {
        let parser = ArgumentParser(arguments: ["--verbose", "-t"])
        try expect(try parser.shiftValue(for: "verbose")).toThrow(ArgumentParserError("Unexpected flag `-t` as a value for `--verbose`"))
      }

      $0.it("should throw when value is missing") {
        let parser = ArgumentParser(arguments: ["--verbose"])
        try expect(try parser.shiftValue(for: "verbose")).toThrow(ArgumentError.missingValue(argument: "--verbose"))
      }

      $0.it("should return arguments for option") {
        let value = try parser.shiftValues(for: "verbose", count: 2)
        try expect(value?.count) == 2
        try expect(value?.first) == "middle"
        try expect(value?.last) == "end"
      }
    }

    $0.describe("variadic options") {
      $0.it("should return arguments for option") {
        let option = VariadicOption<String>("varOption")
        let values = try option.parse(parser)
        try expect(values.count) == 2
        try expect(values.first) == "varValue1"
        try expect(values.last) == "varValue2"
      }

      $0.it("should return empty array when option is unknown") {
        let option = VariadicOption<String>("unknown")
        let values = try option.parse(parser)
        try expect(values.count) == 0
      }
    }

    $0.describe("positional arguments") {
      $0.before {
        parser = ArgumentParser(arguments: ["-a", "value1", "--", "-b", "value2"])
      }

      $0.it("should not count double dash into the arguments") {
        try expect(parser.remainder.count) == 4
        _ = try parser.shiftValue(for: "a" as ArgumentParser.Flag)
        try expect(parser.remainder.count) == 2
      }

      $0.it("should not parse parameters as flags after the double dash") {
        try expect(parser.hasFlag("a" as ArgumentParser.Flag)).to.beTrue()
        try expect(parser.hasFlag("b" as ArgumentParser.Flag)).to.beFalse()

        _ = try parser.shiftValue(for: "a" as ArgumentParser.Flag)
        let value = try parser.shiftValue(for: "b" as ArgumentParser.Flag)
        try expect(value).to.beNil()
      }

      $0.it("should return parameters after the double dash as arguments") {
        _ = try parser.shiftValue(for: "a" as ArgumentParser.Flag)
        let value1 = parser.shift()
        let value2 = parser.shift()
        try expect(value1) == "-b"
        try expect(value2) == "value2"
      }
    }
  }
}
