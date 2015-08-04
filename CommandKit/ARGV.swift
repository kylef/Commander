public class ARGV {
    
    public enum ParameterType {
        case Argument, Option, Flag
    }
    
    let originalArgs: [String]
    public var arguments = [String]()
    public var options = [String: String]()
    public var flags = [String: Bool]()
    
    public init(_ args: [String]) {
        originalArgs = args
        
        for arg in originalArgs {
            switch parameterType(arg) {
            case .Argument:
                arguments.append(arg)
            case .Option:
                let (key, value) = optionParameter(arg)
                options[key] = value
            case .Flag:
                let (key, value) = flagParameter(arg)
                flags[key] = value
            }
        }
    }
    
    public func shift() -> String? {
        if arguments.count > 0 {
            return arguments.removeAtIndex(0)
        } else {
            return nil
        }
    }
    
    public func option(name: String) -> String? {
        return options.removeValueForKey(name)
    }
    
    public func flag(name: String) -> Bool? {
        return flags.removeValueForKey(name)
    }
    
    private func parameterType(arg: String) -> ParameterType {
        if arg.hasPrefix("--") {
            if contains(arg, "=") {
                return .Option
            } else {
                return .Flag
            }
        } else {
            return .Argument
        }
    }
    
    private func optionParameter(arg: String) -> (key: String, value: String) {
        let argument = arg.substringFromIndex(advance(arg.startIndex, 2))
        let components = split(argument) { $0 == "=" }
        assert(components.count == 2)
        return (components[0], components[1])
    }
    
    private func flagParameter(arg: String) -> (key: String, value: Bool) {
        if arg.hasPrefix("--no-") {
            return (arg.substringFromIndex(advance(arg.startIndex, 5)), false)
        } else {
            return (arg.substringFromIndex(advance(arg.startIndex, 2)), true)
        }
    }
}
