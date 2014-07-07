//
//  ARGV.swift
//  CLIKit
//
//  Created by Radoslaw Pietruszewski on 05/07/14.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

class ARGV {
    
    enum ParameterType {
        case Argument, Option, Flag
    }
    
    let originalArgs: [String]
    var arguments = [String]()
    var options = [String: String]()
    var flags = [String: Bool]()
    
    init(_ args: [String]) {
        originalArgs = args
        
        for arg in originalArgs {
            switch _parameterType(arg) {
            case .Argument:
                arguments.append(arg)
            case .Option:
                let (key, value) = _optionParameter(arg)
                options[key] = value
            case .Flag:
                let (key, value) = _flagParameter(arg)
                flags[key] = value
            }
        }
    }
    
    func shift() -> String? {
        if arguments.count > 0 {
            return arguments.removeAtIndex(0)
        } else {
            return nil
        }
    }
    
    func option(name: String) -> String? {
        return options.removeValueForKey(name)
    }
    
    func flag(name: String) -> Bool? {
        return flags.removeValueForKey(name)
    }
    
    func _parameterType(arg: String) -> ParameterType {
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
    
    func _optionParameter(arg: String) -> (key: String, value: String) {
        let components = arg.substringFromIndex(2).componentsSeparatedByString("=") as [String]
        assert(components.count == 2)
        return (components[0], components[1])
    }
    
    func _flagParameter(arg: String) -> (key: String, value: Bool) {
        if arg.hasPrefix("--no-") {
            return (arg.substringFromIndex(5), false)
        } else {
            return (arg.substringFromIndex(2), true)
        }
    }
}
