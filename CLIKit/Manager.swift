//
//  Manager.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

public class Manager {
    public var commands = [Command]()

    public init() {
    }
    
    lazy var defaultCommand: Command = {
        ClosureCommand(name: "", description: "The default command") { argv in
            println("No command specified")
        }
    }()

    public func register(name:String, _ description:String, handler: ClosureCommand.ClosureType) {
        register(ClosureCommand(name:name, description:description, handler))
    }

    public func register(command:Command) {
        commands.append(command)
    }
    
    public func registerDefault(handler: ClosureCommand.ClosureType) {
        defaultCommand = ClosureCommand(name: "", description: "The default command", handler: handler)
    }

    /// Finds a command by name
    public func findCommand(name:String) -> Command? {
        let foundCommands = commands.filter { $0.name == name }
        var command:Command?

        if foundCommands.count > 0 {
            command = foundCommands[0]
        }

        return command
    }
    
    /// Finds the command to execute based on input arguments
    public func findCommand(argv: ARGV) -> Command? {
        let args = argv.arguments
        // try to find the deepest command name matching the arguments
        for depth in reverse(1...args.count) {
            let slicedArgs = Array(args[0 ..< depth]) as NSArray
            let maybeCommandName = slicedArgs.componentsJoinedByString(" ")
            
            if let command = findCommand(maybeCommandName) {
                argv.arguments = Array(args[depth ..< args.count]) // strip the command name from arguments
                return command
            }
        }
        
        return nil
    }
    
    /// Runs the correct command based on input arguments
    public func run(arguments: [String]? = nil) {
        var argv: ARGV!
        
        // Swift, Y U NO ||= ?!
        if arguments != nil {
            argv = ARGV(arguments!)
        } else {
            var arguments = Process.arguments
            arguments.removeAtIndex(0)
            argv = ARGV(arguments)
        }
        
        if argv.arguments.count > 0 {
            if let command = findCommand(argv) {
                command.run(self, arguments: argv)
            } else {
                println("Unknown command.")
            }
        } else {
            defaultCommand.run(argv)
        }
    }
}
