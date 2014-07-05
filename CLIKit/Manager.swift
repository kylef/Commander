//
//  Manager.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

class Manager {
    var commands = Command[]()
    var defaultCommand: Command
    
    init() {
        defaultCommand = Command("", "")
        registerDefault {
            println("No command specified")
        }
    }

    func register(name:String, _ description:String, handler:(()->())) {
        register(ClosureCommand(name:name, description:description, handler))
    }

    func register(command:Command) {
        commands.append(command)
    }
    
    func registerDefault(handler: ()->()) {
        defaultCommand = ClosureCommand(name: "", description: "The default command", handler: handler)
    }

    /// Finds a command by name
    func findCommand(name:String) -> Command? {
        let foundCommands = commands.filter({ $0.name == name })
        var command:Command?

        if foundCommands.count > 0 {
            command = foundCommands[0]
        }

        return command
    }

    /// Executes the command with arguments
    func run(name:String, arguments:ARGV) {
        if let command = findCommand(name) {
            command.run(self, arguments: arguments)
        } else {
            println("Unknown command: \(name)")
        }
    }
    
    func run(arguments: String[]? = nil) {
        var argv: ARGV!
        
        if arguments {
            argv = ARGV(arguments!)
        } else {
            var arguments = Process.arguments
            arguments.removeAtIndex(0)
            argv = ARGV(arguments)
        }
        
        if let name = argv.shift() {
            run(name, arguments: argv)
        } else {
            defaultCommand.run(argv)
        }
    }
}
