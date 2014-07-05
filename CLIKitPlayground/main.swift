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
    println("The issue has been edited.")
}

manager.register("close", "Closes an open issue") { argv in
    println("Issue has been closed.")
}

manager.registerDefault { argv in
    println("The best default command")
    print(argv.flags)
}

manager.run(arguments: ["--foo", "--bar"])