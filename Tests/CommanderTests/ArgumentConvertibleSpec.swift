import Spectre
import Commander


public func testArgumentConvertible() {
  describe("ArgumentError") {
    $0.it("has a human readable description for missing value") {
      let error = ArgumentError.missingValue(argument: nil)
      try expect(error.description) == "Missing argument"
    }

    $0.it("has a human readable description for no value") {
      let error = ArgumentError.invalidType(value: "five", type: "number", argument: nil)
      try expect(error.description) == "`five` is not a `number`"
    }
  }

  describe("String ArgumentConvertible") {
    $0.it("converts an argument to a string value") {
      let parser = ArgumentParser(arguments: ["argument"])
      let value = try String(parser: parser)

      try expect(value) == "argument"
    }

    $0.it("handles when the argument parser doesn't have any values") {
      let parser = ArgumentParser(arguments: [])
      try expect(try String(parser: parser)).toThrow(ArgumentError.missingValue(argument: nil))
    }
  }

  describe("Int ArgumentConvertible") {
    $0.it("converts a valid number as an integer") {
      let parser = ArgumentParser(arguments: ["5"])
      let value = try Int(parser: parser)

      try expect(value) == 5
    }

    $0.it("errors on invalid input") {
      let parser = ArgumentParser(arguments: ["five"])

      try expect {
        try Int(parser: parser)
      }.toThrow(ArgumentError.invalidType(value: "five", type: "number", argument: nil))
    }

    $0.it("handles when the argument parser doesn't have any values") {
      let parser = ArgumentParser(arguments: [])
      try expect(try Int(parser: parser)).toThrow(ArgumentError.missingValue(argument: nil))
    }
  }

  describe("Float ArgumentConvertible") {
    $0.it("converts a valid number as an float") {
      let parser = ArgumentParser(arguments: ["5"])
      let value = try Float(parser: parser)

      try expect(value) == 5
    }

    $0.it("errors on invalid input") {
      let parser = ArgumentParser(arguments: ["five"])

      try expect {
        try Float(parser: parser)
      }.toThrow(ArgumentError.invalidType(value: "five", type: "number", argument: nil))
    }

    $0.it("handles when the argument parser doesn't have any values") {
      let parser = ArgumentParser(arguments: [])
      try expect(try Float(parser: parser)).toThrow(ArgumentError.missingValue(argument: nil))
    }
  }

  describe("Double ArgumentConvertible") {
    $0.it("converts a valid number as an double") {
      let parser = ArgumentParser(arguments: ["5"])
      let value = try Double(parser: parser)

      try expect(value) == 5
    }

    $0.it("errors on invalid input") {
      let parser = ArgumentParser(arguments: ["five"])

      try expect {
        try Double(parser: parser)
      }.toThrow(ArgumentError.invalidType(value: "five", type: "number", argument: nil))
    }

    $0.it("handles when the argument parser doesn't have any values") {
      let parser = ArgumentParser(arguments: [])
      try expect(try Double(parser: parser)).toThrow(ArgumentError.missingValue(argument: nil))
    }
  }

  describe("Optional ArgumentConvertible") {
    $0.it("converts a valid value as some") {
      let parser = ArgumentParser(arguments: ["5"])
      let value = try Optional<Double>(parser: parser)

      try expect(value) == 5
    }

    $0.it("converts missing value as none") {
      let parser = ArgumentParser(arguments: [])
      let value = try Optional<Double>(parser: parser)

      try expect(value).to.beNil()
    }

    $0.it("errors on invalid value") {
      let parser = ArgumentParser(arguments: ["five"])

      try expect {
        try Optional<Double>(parser: parser)
      }.toThrow(ArgumentError.invalidType(value: "five", type: "number", argument: nil))
    }
  }

  /*
  describe("Array ArgumentConvertible") {
    $0.it("consumes all available arguments") {
      let parser = ArgumentParser(arguments: ["1", "2", "3"])
      let value = try Array<String>(parser: parser)

      try expect(value) == ["1", "2", "3"]
    }
  }
  */
}
