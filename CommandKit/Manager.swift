public class Manager {
    public var commands = [Command]()

    public init() {}

    lazy var defaultCommand: Command = {
        ClosureCommand(name: "", description: "The default command") { argv in
            print("No command specified")
        }
    }()

    public func register(name: String, _ description: String, handler: ClosureCommand.ClosureType) {
        register(ClosureCommand(name: name, description: description, handler: handler))
    }

    public func register(command: Command) {
        commands.append(command)
    }

    public func registerDefault(handler: ClosureCommand.ClosureType) {
        defaultCommand = ClosureCommand(name: "", description: "The default command", handler: handler)
    }

    /// Finds a command by name
    public func findCommand(name: String) -> Command? {
        return commands.filter { $0.name == name }.first
    }

    /// Finds the command to execute based on input arguments
    public func findCommand(argv: ARGV) -> Command? {
        let args = argv.arguments
        // try to find the deepest command name matching the arguments
        for depth in (1...args.count).reverse() {
            let slicedArgs = args[0 ..< depth]
            let maybeCommandName = slicedArgs.joinWithSeparator(" ")

            if let command = findCommand(maybeCommandName) {
                argv.arguments = Array(args[depth ..< args.count]) // strip the command name from arguments
                return command
            }
        }

        return nil
    }

    /// Runs the correct command based on input arguments
    public func run(arguments arguments: [String]? = nil) {
        let argv: ARGV

        if let arguments = arguments {
            argv = ARGV(arguments)
        } else {
            var arguments = Process.arguments
            arguments.removeAtIndex(0)
            argv = ARGV(arguments)
        }

        if argv.arguments.count > 0 {
            if let command = findCommand(argv) {
                command.run(self, arguments: argv)
            } else {
                print("Unknown command.")
            }
        } else {
            defaultCommand.run(argv)
        }
    }
}
