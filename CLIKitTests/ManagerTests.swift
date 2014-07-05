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

    func testRoutesRegisteredCommand() {
        manager.run("test", arguments:ARGV([]))
        XCTAssertTrue(didExecuteTestCommand)
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
}
