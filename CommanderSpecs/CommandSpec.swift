import Spectre
import Commander


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
  }
}
