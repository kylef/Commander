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

    override func setUp() {
        manager = Manager()
    }

    func testHasConvinienceMethodToAddCommand() {
        manager.register("test", "A command registered in the test") {
            
        }

        XCTAssertEqual(manager.commands.count, 1)
        XCTAssertEqual(manager.commands[0].name, "test")
        XCTAssertEqual(manager.commands[0].description, "A command registered in the test")
    }
    
}
