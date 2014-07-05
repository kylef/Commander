//
//  Manager.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

class Manager {
    var commands = Command[]()

    func register(name:String, _ description:String, handler:(()->())) {
        register(ClosureCommand(name:name, description:description, handler))
    }

    func register(command:Command) {
        commands.append(command)
    }
}
