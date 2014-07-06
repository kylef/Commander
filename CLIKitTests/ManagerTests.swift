//
//  ManagerTests.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import XCTest
import CLIKit

class ManagerTests: XCTestCase {
    var manager:Manager!
    var didExecuteTestCommand = false

    override func setUp() {
        didExecuteTestCommand = false
        manager = Manager()
        manager.register("test", "A command registered in the test") { argv in
            self.didExecuteTestCommand = true
        }
    }

    func testConvinienceMethodAddsCommand() {
        XCTAssertEqual(manager.commands.count, 1)
        XCTAssertEqual(manager.commands[0].name, "test")
        XCTAssertEqual(manager.commands[0].description, "A command registered in the test")
    }

    func testFindsCommandByNameFindsCommand() {
        let command = manager.findCommand("test")
        XCTAssertEqual(command!.name, "test")
    }

    func testFindsCommandByNameReturnsOptionalWhenNoCommandNamesMatch() {
        let command = manager.findCommand("unknown")
        XCTAssertNil(command)
    }
    
    func testFindsSubcommands() {
        manager.register("test foo", "") { argv in }
        manager.register("test foo bar", "") { argv in }
        
        let command = manager.findCommand(ARGV(["test", "foo", "arg", "arg"]))
        XCTAssertEqual(command!.name, "test foo")
        
        let command2 = manager.findCommand(ARGV(["test", "foo", "bar", "arg"]))
        XCTAssertEqual(command2!.name, "test foo bar")
    }
    
    func testAutomaticRun() {
        manager.run(arguments: ["test"])
        XCTAssertTrue(didExecuteTestCommand)
    }
    
    func testPassesArgumentsToCommand() {
        var closureRan = false
        manager.register("test_argument_passing", "A tester command") { argv in
            closureRan = true
            XCTAssertEqualObjects(argv.arguments, ["arg", "arg2"])
            XCTAssertEqualObjects(argv.options, ["option": "value"])
        }
        manager.run(arguments: ["test_argument_passing", "arg", "arg2", "--option=value"])
        XCTAssertTrue(closureRan)
    }
    
    func testRunsDefaultCommand() {
        var closureRan = false
        manager.registerDefault { argv in
            closureRan = true
            XCTAssertEqualObjects(argv.options, ["option": "value"])
        }
        manager.run(arguments: ["--option=value"])
        XCTAssertTrue(closureRan)
    }
    
    func testStripsArgumentsForSubcommandsCorrectly() {
        var closureRan = false
        manager.register("test foo bar", "") { argv in
            closureRan = true
            XCTAssertEqualObjects(argv.arguments, ["arg", "arg"])
        }
        manager.run(arguments: ["test", "foo", "bar", "arg", "arg"])
        XCTAssertTrue(closureRan)
    }
}
