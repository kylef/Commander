//
//  main.swift
//  CLIKitPlayground
//
//  Created by Radoslaw Pietruszewski on 05/07/14.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import CLIKit

var manager = Manager()

manager.register("issue", "") { argv in
    println("Issues will be managed!")
    print(argv.arguments)
}

manager.register("issue edit", "") { argv in
    println("Issues will be edited!")
    print(argv.arguments)
}

manager.register("issue delete", "") { argv in
    println("Issues will be edited!")
    print(argv.arguments)
}

manager.run(arguments: ["issue", "foo", "bar"])