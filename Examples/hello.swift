#!/usr/bin/swift -I ../.conche/modules -L ../.conche/lib -lCommander

import Commander

command(
  Option("name", "world"),
  Option("count", 1, description: "The number of times to print.")
) { name, count in
  for _ in 0..<count {
    print("Hello \(name)")
  }
}.run()

