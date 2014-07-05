//
//  Command.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

class Command {
    let name:String
    let description:String

    init(_ name:String, _ description:String) {
        self.name = name
        self.description = description
    }

    func run(arguments:String[]) {

    }
}

class ClosureCommand : Command {
    let handler:(() -> ())

    init(name:String, description:String, handler:(() -> ())) {
        self.handler = handler
        super.init(name, description)
    }

    override func run(arguments:String[]) {
        self.handler()
    }
}
