//
//  CommandTests.swift
//  CLIKit
//
//  Created by Kyle Fuller on 05/07/2014.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import XCTest
import CLIKit

class CommandTests: XCTestCase {
    var command:Command!

    override func setUp() {
        command = Command("help", "Show help for the given command.")
    }

    func testCommandHasName() {
        XCTAssertEqual(command.name, "help")
    }

    func testCommandHasDescription() {
        XCTAssertEqual(command.description, "Show help for the given command.")
    }

}
