//
//  main.swift
//  CLIKitPlayground
//
//  Created by Radoslaw Pietruszewski on 05/07/14.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import CLIKit

var manager = Manager()

manager.register("open", "Opens a new issue") { argv in
    println("A new issue has been created!")
}

manager.register("edit", "Edits an issue") { argv in
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

manager.register("close", "Closes an open issue") { argv in
    println("Issue has been closed.")
}

manager.registerDefault { argv in
    println("The best default command")
    print(argv.flags)
}

manager.run(arguments: ["edit", "2222", "--assignee=radex", "--milestone=2.0"])