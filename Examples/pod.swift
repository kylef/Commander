#!/usr/bin/swift -I ../.conche/modules -L ../.conche/libs -lCommander -lStencil -lPathKit

import Commander

Group {
  $0.command("install") {
    print("Installing Pods")
  }

  $0.command("upgrade") { (name:String) in
    print("Updating \(name)")
  }

  $0.command("search",
    Flag("web", description: "Searches on cocoapods.org"),
    Argument<String>("query")
  ) { web, query in
    if web {
      print("Searching for \(query) on the web.")
    } else {
      print("Locally searching for \(query).")
    }
  }
}.run()

