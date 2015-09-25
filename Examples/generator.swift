#!/usr/bin/swift -FRome

import Commander
import Stencil
import PathKit

command(
  Option("amount", 15, description: "The number of arguments to support.")
) { amount in
  let template = try! Template(path: Path("generator-template.swift"))

  let structure = (1..<amount).map {
    return [
      "count": $0,
      "arguments": (1..<$0).map { $0 },
    ]
  }
  let context = Context(dictionary: ["commands": structure])
  let result = template!.render(context)

  switch result {
    case .Success(let rendered):
      Path("../Commander/Commands.swift").write(rendered)
    case .Error(let error):
      print("Failed \(error)")
  }
}.run()

