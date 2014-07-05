//
//  main.swift
//  CLIKitPlayground
//
//  Created by Radosław Pietruszewski on 05/07/14.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import CLIKit

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