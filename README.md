CLIKit
======

The swiftest way to write a command line tool.

## Usage

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

manager.run()
```

## Authors

- [Kyle Fuller](https://twitter.com/kylefuller)
- [Radek Pietruszwski](https://twitter.com/radexp)

## License

CLIKit is available under the BSD license. See the [LICENSE file](LICENSE)
for more info.

