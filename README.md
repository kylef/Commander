# Commander

[![Build Status](http://img.shields.io/travis/kylef/Commander/master.svg?style=flat)](https://travis-ci.org/kylef/Commander)

Commander is a small Swift framework allowing you to craft beautiful command
line interfaces in a composable way.

## Usage

##### Simple Hello World

```swift
import Commander

let main = command {
  print("Hello World")
}

main.run()
```

##### Type-safe argument handling

```swift
command { (hostname:String, port:Int) in
  print("Connecting to \(hostname) on port \(port)...")
}
```

##### Grouping commands

You can group a collection of commands together.

```swift
Group {
  $0.command("login") { (name:String) in
    print("Hello \(name)")
  }

  $0.command("logout") {
    print("Goodbye.")
  }
}
```

Usage:

```shell
$ tool login Kyle
Hello Kyle
$ tool logout
Goodbye.
```

#### Using the argument parser

You can get hold of the argument parser to do custom argument handling

```swift
command { (name:String, parser:ArgumentParser) in
  if parser.hasOption("verbose") {
    print("Verbose mode enabled")
  }

  print("Hello \(name)")
}
```

```shell
$ tool Kyle --verbose
Verbose mode enabled
Hello Kyle
```

### Examples tools using Commander

- [QueryKit](https://github.com/QueryKit/querykit-cli) via CocoaPods Rome

## Installation

You can install Commander in many ways, such as with CocoaPods, Carthage or as
a sub-project.

### CocoaPods

```ruby
pod 'Commander'
```

#### Cato

The simplest way to build a Swift script that uses Commander would be to use
[cato](https://github.com/neonichu/cato). Cato will automatically download
Commander behind the scenes.

```swift
#!/usr/bin/env cato

import Commander

let main = command {
  print("Hello World")
}

main.run()
```

## License

Commander is available under the BSD license. See the [LICENSE file](LICENSE)
for more info.

