# CommandKit

[![Build Status](http://img.shields.io/travis/kylef/CommandKit/master.svg?style=flat)](https://travis-ci.org/kylef/CommandKit)

The swiftest way to write a command line tool.

## Usage

Code:

```swift
var manager = Manager()

manager.register("issue", "Options for issue") { argv in
    println("Say `open`, `close` or `edit`")
}

manager.register("issue open", "Opens a new issue") { argv in
    println("A new issue has been created!")
}

manager.register("issue close", "Closes an open issue") { argv in
    println("Issue has been closed.")
}

manager.register("issue edit", "Edits an issue") { argv in
    if let id = argv.shift() {
        var alert = "Editing issue #\(id). "

        if let assignee = argv.option("assignee") {
            alert += "\(assignee) will be the new assignee. "
        }

        if let milestone = argv.option("milestone") {
            alert += "The issue must be completed before \(milestone). "
        }

        println(alert)
    } else {
        println("Issue id not specified")
    }
}


manager.run()
```

Result:
```
$ ./my_cli issue open
A new issue has been created!
$ ./my_cli issue edit 22 --assignee=radex --milestone=2.0
Editing issue #22. radex will be the new assignee. The issue must be completed before 2.0.
$ ./my_cli issue
Say `open`, `close` or `edit`
```

## Features

* Specify commands and subcommands
* Arguments (`edit 22`)
* Boolean flags (`coffee make --sugar --no-milk`)
* Options (`open --title=foo --author=bar`)

## Authors

- [Kyle Fuller](https://twitter.com/kylefuller)
- [Radek Pietruszwski](https://twitter.com/radexp)

## License

CommandKit is available under the BSD license. See the [LICENSE file](LICENSE)
for more info.

