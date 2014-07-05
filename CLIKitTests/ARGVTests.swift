//
//  ARGVTests.swift
//  CLIKit
//
//  Created by Radoslaw Pietruszewski on 05/07/14.
//  Copyright (c) 2014 Cocode. All rights reserved.
//

import XCTest
import CLIKit

class ARGVTests: XCTestCase {
    var argv: ARGV!
    
    override func setUp() {
        argv = ARGV("argument1 --flag1 argument2 --no-flag2 --option1=value1 argument3 --flag3 --option2=value2".componentsSeparatedByString(" "))
    }
    
    func testPresenceOfAllParameters() {
        XCTAssertEqualObjects(argv.arguments, ["argument1", "argument2", "argument3"])
        XCTAssertEqualObjects(argv.options, ["option1": "value1", "option2": "value2"])
        XCTAssertEqualObjects(argv.flags, ["flag1": true, "flag2": false, "flag3": true])
    }
    
    func testShiftingOfArguments() {
        XCTAssert(argv.shift() == "argument1")
        XCTAssertEqualObjects(argv.arguments, ["argument2", "argument3"])
        XCTAssert(argv.shift() == "argument2")
        XCTAssert(argv.shift() == "argument3")
        XCTAssertEqualObjects(argv.arguments, [])
        XCTAssert(argv.shift() == nil)
    }
    
    func testOptions() {
        XCTAssert(argv.option("option1") == "value1")
        XCTAssert(argv.option("option1") == nil)
        XCTAssertEqualObjects(argv.options, ["option2": "value2"])
        
        XCTAssert(argv.option("option2") == "value2")
        XCTAssert(argv.option("option2") == nil)
        XCTAssertEqualObjects(argv.options, [:])
        
        XCTAssert(argv.option("doesn't exist") == nil)
    }
    
    func testFlags() {
        XCTAssert(argv.flag("flag1") == true)
        XCTAssert(argv.flag("flag1") == nil)
        XCTAssertEqualObjects(argv.flags, ["flag2": false, "flag3": true])
        
        XCTAssert(argv.flag("flag2") == false)
        XCTAssert(argv.flag("flag2") == nil)
        XCTAssertEqualObjects(argv.flags, ["flag3": true])
        
        XCTAssert(argv.flag("doesn't exist") == nil)
    }
}