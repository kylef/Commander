import Spectre
import Commander


let testCommandType: ((ContextType) -> Void) = {
  $0.it("provides a run with arguments array function") {
    var firstArgument:String? = nil

    try command { (parser:ArgumentParser) in
      firstArgument = parser.shift()
    }.run(["test"])

    try expect(firstArgument) == "test"
  }
}
