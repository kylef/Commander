CLIKit
======

```swift
var manager = Manager()

manager.register("open", "Opens a new issue") {
  println("A new issue has been created!")
}

manager.register("edit", "Edits an issue") {
  println("The issue has been edited.")
}

manager.register("close", "Closes an open issue") {
  println("Issue has been closed.")
}
```

