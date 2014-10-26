//
//  Command.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

public class Command {
    public let name:String
    public let description:String

    public init(_ name:String, _ description:String) {
        self.name = name
        self.description = description
    }

    public func run(arguments: ARGV) {

    }

    public func run(manager:Manager, arguments: ARGV) {
        run(arguments)
    }
}

public class ClosureCommand : Command {
    public typealias ClosureType = (ARGV) -> ()
    let handler: ClosureType

    public init(name:String, description:String, handler: ClosureType) {
        self.handler = handler
        super.init(name, description)
    }

    public override func run(arguments: ARGV) {
        self.handler(arguments)
    }
}
