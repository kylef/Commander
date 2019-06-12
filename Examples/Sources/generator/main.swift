import Commander
import Stencil
import PathKit

let sourcePath = Path(#file) + ".."

command(
  Option("amount", default: 32, description: "The number of arguments to support.")
) { amount in
  let template = try Template(path: sourcePath + "template.swift")

  let structure = (1..<amount).map {
    return [
      // FIXME Stencil appears to replace `count` with 2
      "count_": $0,
      "arguments": (1..<$0).map { $0 },
    ]
  }
  let rendered = try template.render(["commands": structure])

  try Path("../Sources/Commander/Commands.swift").write(rendered)
}.run()

