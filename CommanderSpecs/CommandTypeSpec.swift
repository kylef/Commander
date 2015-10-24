import Spectre
import Commander


describe("CommandType extension") {
  $0.it("provides a run with arguments array function") {
    var firstArgument:String? = nil

    try command { (parser:ArgumentParser) in
      firstArgument = parser.shift()
    }.run(["test"])

    try expect(firstArgument) == "test"
  }
}
