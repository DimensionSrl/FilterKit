//
//  FilterKitTests.swift
//  FilterKitTests
//
//  Created by Matteo Gavagnin on 04/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

import XCTest
@testable import FilterKit

class FilterKitTests: XCTestCase {
    
    static var allTests = [
        ("testAllEqualSingle", testAllEqualSingle),
        ("testAllEqualSingleDouble", testAllEqualSingleDouble),
        ("testAllEqualMultiple", testAllEqualMultiple),
        ("testAllEqualDifferent", testAllEqualDifferent),
        ("testAllEqualIn", testAllEqualIn),
        ("testAllEqualInDouble", testAllEqualInDouble),
        ("testAllEqualNotIn", testAllEqualNotIn),
        ("testAllEqualHas", testAllEqualHas),
        ("testAllEqualDoesntHave", testAllEqualDoesntHave),
        ("testAnyEqualSingle", testAnyEqualSingle),
        ("testAnyEqualMultiple", testAnyEqualMultiple),
        ("testNoneEqualSingle", testNoneEqualSingle),
        ("testNoneDifferentMultiple", testNoneDifferentMultiple),
        ("testAllMinor", testAllMinor),
        ("testAllMajor", testAllMajor),
        ("testAllMinorEqual", testAllMinorEqual),
        ("testAllMajorEqual", testAllMajorEqual),
        ("testAllEqualInt", testAllEqualInt),
        ("testAllEqualDouble", testAllEqualDouble),
        ("testAllEqualBool", testAllEqualBool),
        ("testAllNotEqualDouble", testAllNotEqualDouble),
        ("testAllNotEqualBool", testAllNotEqualBool),
        ("testAllNotEqualBool", testAllNotEqualBool),
        ("testAllNotEqualInt", testAllNotEqualInt),
        ("testAllNotEqualInt", testAllNotEqualInt),
        ("testAllMajorInt", testAllMajorInt),
        ("testAllMajorEqualInt", testAllMajorEqualInt),
        ("testAllMinorInt", testAllMinorInt),
        ("testAllMinorEqualInt", testAllMinorEqualInt),
        ("testNoFilters", testNoFilters),
        ("testThrowNotString", testThrowNotString),
        ("testThrowUnknownOperation", testThrowUnknownOperation),
        ("testThrowUnknownFilter", testThrowUnknownFilter),
        ("testThrowPropertyNotString", testThrowPropertyNotString),
        ("testThrowInPropertyNotString", testThrowInPropertyNotString),
        ("testThrowHasPropertyNotString", testThrowHasPropertyNotString),
        ("testThrowInNoValues", testThrowInNoValues),
        ("testThrowEqualNoValue", testThrowEqualNoValue),
        ("testThrowNoFiltersJson", testThrowNoFiltersJson),
        ("testThrowFirstElementNotAString", testThrowFirstElementNotAString),
        ("testThrowWrongJsonFormat", testThrowWrongJsonFormat)
        ]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllEqualSingle() {
        let name = "allEqualSingle"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            Filter(properties: [:]).logger = .debug
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bar": "span"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": 1.53]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to 1.53")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualSingleDouble() {
        let name = "allEqualSingleDouble"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 1.09]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar")
            let shouldPass_1 = try Filter(properties: ["foo": 1.09, "bar": "span"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to 1.09")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            #if swift(>=4.0)
                let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
                XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            #endif
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": 1.53]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to 1.53")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualMultiple() {
        let name = "allEqualMultiple"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bit": "code"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit to code")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "bit": "code", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit to code")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": 1.53]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to 1.53")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualDifferent() {
        let name = "allEqualDifferent"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bit": "bitter"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit shouldn't be equal to code")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "bit": "bitter", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit shouldn't be equal to code")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": 1.53]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to 1.53")
            let shouldFail_6 = try Filter(properties: ["foo": false, "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_6 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_7 = try Filter(properties: ["foo": false, "bit": "bitter"]).compile(parsed)
            XCTAssert(shouldFail_7 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualIn() {
        let name = "allEqualIn"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bit": "code"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit should be code, swift or 0")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "bit": "code", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit should be code, swift or 0")
            let shouldPass_2 = try Filter(properties: ["foo": "bar", "bit": "swift", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo should be equal to bar and bit should be code, swift or 0")
            let shouldPass_3 = try Filter(properties: ["foo": "bar", "bit": 0, "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_3, "Foo should be equal to bar and bit should be code, swift or 0")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": false, "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_6 = try Filter(properties: ["foo": false, "bit": "bitter"]).compile(parsed)
            XCTAssert(shouldFail_6 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualInDouble() {
        let name = "allEqualInDouble"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 1]).compile(parsed)
            #if !os(Linux)
                XCTAssert(shouldPass_0, "Foo should be in 1.0, 2.4 or 3.6")
            #else
                XCTAssert(shouldPass_0 == false, "Foo should be in 1.0, 2.4 or 3.6 and it's 1 as integer")
            #endif
            let shouldPass_1 = try Filter(properties: ["foo": 2.4, "bit": "code", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be in 1.0, 2.4 or 3.6")
            let shouldPass_2 = try Filter(properties: ["foo": 3.6, "bit": "swift", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo should be in 1.0, 2.4 or 3.6")
            let shouldPass_3 = try Filter(properties: ["foo": 3.6, "bit": 0, "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_3, "Foo should be in 1.0, 2.4 or 3.6")
            let shouldPass_4 = try Filter(properties: ["foo": true]).compile(parsed)
            #if !os(Linux)
                XCTAssert(shouldPass_4, "Foo should be in 1.0, 2.4 or 3.6, and as true is equal to 1 it's ok.")
            #else
                XCTAssert(shouldPass_4 == false, "Foo should be in 1.0, 2.4 or 3.6, and as true it's not equal to 1 on Linux the assertion should fail.")
            #endif
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be in 1.0, 2.4 or 3.6, but it's equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be in 1.0, 2.4 or 3.6, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be in 1.0, 2.4 or 3.6, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be in 1.0, 2.4 or 3.6, but it's equal to false")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualNotIn() {
        let name = "allEqualNotIn"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bit": "cat"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit should not be code, swift or 0")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "bit": "cat", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit should not be code, swift or 0")
            let shouldPass_2 = try Filter(properties: ["foo": "bar", "bit": "true", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo should be equal to bar and bit should not be code, swift or 0")
            let shouldPass_3 = try Filter(properties: ["foo": "bar", "bit": 1, "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_3, "Foo should be equal to bar and bit should not be code, swift or 0")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": false, "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_6 = try Filter(properties: ["foo": false, "bit": "bitter"]).compile(parsed)
            XCTAssert(shouldFail_6 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_7 = try Filter(properties: ["foo": "bar", "bit": 0, "green": "door"]).compile(parsed)
            XCTAssert(shouldFail_7 == false, "Foo should be equal to bar and bit should not be code, swift or 0")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualHas() {
        let name = "allEqualHas"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bit": "cat"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit should exists")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "bit": "cat", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit should exists")
            let shouldPass_2 = try Filter(properties: ["foo": "bar", "bit": "true", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo should be equal to bar and bit should exists")
            let shouldPass_3 = try Filter(properties: ["foo": "bar", "bit": 1, "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_3, "Foo should be equal to bar and bit should exists")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": false, "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_6 = try Filter(properties: ["foo": false, "bit": "bitter"]).compile(parsed)
            XCTAssert(shouldFail_6 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_7 = try Filter(properties: ["foo": "bar"]).compile(parsed)
            XCTAssert(shouldFail_7 == false, "Foo should be equal to bar, but bit is missing")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualDoesntHave() {
        let name = "allEqualDoesntHave"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit shouldn't exist")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit should exists")
            let shouldPass_2 = try Filter(properties: ["foo": "bar", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo should be equal to bar and bit should exists")
            let shouldPass_3 = try Filter(properties: ["foo": "bar", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_3, "Foo should be equal to bar and bit should exists")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
            let shouldFail_5 = try Filter(properties: ["foo": false, "bit": "code"]).compile(parsed)
            XCTAssert(shouldFail_5 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_6 = try Filter(properties: ["foo": false, "bit": "bitter"]).compile(parsed)
            XCTAssert(shouldFail_6 == false, "Foo should be equal to bar, but it's equal to false. Bit should be different than code")
            let shouldFail_7 = try Filter(properties: ["foo": "bar", "bit": 1]).compile(parsed)
            XCTAssert(shouldFail_7 == false, "Foo should be equal to bar, but bit is present")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAnyEqualSingle() {
        let name = "anyEqualSingle"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bar": "span"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar")
            let shouldFail_0 = try Filter(properties: ["foo": "fool", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but is equal to fool")
            let shouldFail_1 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_2 = try Filter(properties: ["foo":0]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_3 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_4 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_4 == false, "Foo should be equal to bar, but it's equal to false")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAnyEqualMultiple() {
        let name = "anyEqualMultiple"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bit": "code"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to bar and bit to code")
            let shouldPass_1 = try Filter(properties: ["foo": "bar", "bit": "code", "green": "door"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to bar and bit to code")
            let shouldPass_2 = try Filter(properties: ["foo": "fool", "bit": "code"]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo is equal to fool, but bit is equal to code")
            let shouldFail_0 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to bar, but it's empty")
            let shouldFail_1 = try Filter(properties: ["foo":0]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be equal to bar, but it's 0")
            let shouldFail_2 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldFail_2 == false, "Foo should be equal to bar, but it's equal to true")
            let shouldFail_3 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldFail_3 == false, "Foo should be equal to bar, but it's equal to false")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNoneEqualSingle() {
        let name = "noneEqualSingle"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": false, "bar": "span"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should not be equal to bar")
            let shouldPass_1 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should not be equal to bar")
            let shouldPass_2 = try Filter(properties: [:]).compile(parsed)
            XCTAssert(shouldPass_2, "Foo should not be equal to bar as there are no properties")
            let shouldPass_3 = try Filter(properties: ["foo": 0]).compile(parsed)
            XCTAssert(shouldPass_3, "Foo should not be equal to bar, as but it's 0")
            let shouldPass_4 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldPass_4, "Foo should not be equal to bar, as it's true")
            let shouldPass_5 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldPass_5, "Foo should not be equal to bar, as it's false")
            let shouldPass_6 = try Filter(properties: ["foo": 1.53]).compile(parsed)
            XCTAssert(shouldPass_6, "Foo should not be equal to bar, as it's 1.53")
            let shouldFail_0 = try Filter(properties: ["foo": "bar", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should not be equal to bar, but it is")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNoneDifferentMultiple() {
        let name = "noneDifferentMultiple"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bar": "span"]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be different than bar, but is equal so one codition is be met.")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMinor() {
        let name = "allMinor"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 1.0]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be minor than 1.25")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMajor() {
        let name = "allMajor"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 1.0]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be major than 1.25")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMinorEqual() {
        let name = "allMinorEqual"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 1.0]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be minor or equal to 1.25")
            let shouldPass_1 = try Filter(properties: ["foo": 1.25]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be minor or equal to 1.25")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMajorEqual() {
        let name = "allMajorEqual"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 2.0]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be major or equal to 1.25")
            let shouldPass_1 = try Filter(properties: ["foo": 1.25]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be major or equal to 1.25")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualInt() {
        let name = "allEqualInt"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 4]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to 4")
            let shouldPass_1 = try Filter(properties: ["foo": 4, "bar": true]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to 4")
            let shouldPass_2 = try Filter(properties: ["foo": 4.0]).compile(parsed)
            #if !os(Linux)
                XCTAssert(shouldPass_2, "Foo should be equal to integer 4 even if expressed as double literal")
            #else
                XCTAssert(shouldPass_2 == false, "Foo should be equal to integer 4 as it's expressed as double")
            #endif
            let shouldFail_0 = try Filter(properties: ["foo": 5, "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to 4, but it's 5")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualDouble() {
        let name = "allEqualDouble"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 7.12]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to 7.12")
            let shouldPass_1 = try Filter(properties: ["foo": 7.12, "bar": true]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to 7.12")
            let shouldFail_0 = try Filter(properties: ["foo": 5, "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to 4, but it's 5")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllEqualBool() {
        let name = "allEqualBool"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": true]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be equal to true")
            let shouldPass_1 = try Filter(properties: ["foo": true, "bar": true]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be equal to true")
            let shouldFail_0 = try Filter(properties: ["foo": false, "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be equal to true, but it's false")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllNotEqualDouble() {
        let name = "allNotEqualDouble"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 7.12]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should not be equal to 6.21")
            let shouldPass_1 = try Filter(properties: ["foo": 7.22, "bar": true]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should not be equal to 6.21")
            let shouldFail_0 = try Filter(properties: ["foo": 6.21, "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should not be equal to 6.21, but it's exatly that")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllNotEqualBool() {
        let name = "allNotEqualBool"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": false]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should not be equal to true")
            #if swift(>=4.0)
                let shouldPass_1 = try Filter(properties: ["foo": 7.22, "bar": true]).compile(parsed)
                XCTAssert(shouldPass_1, "Foo should not be equal to true")
            #endif
            let shouldFail_0 = try Filter(properties: ["foo": true, "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should not be equal to true, but it's exatly that")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllNotEqualInt() {
        let name = "allNotEqualInt"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": false]).compile(parsed)
            #if !os(Linux)
                XCTAssert(shouldPass_0, "Foo should not be equal to 1")
            #else
                XCTAssert(shouldPass_0 == false, "Foo should not be equal to 1")
            #endif
            let shouldPass_1 = try Filter(properties: ["foo": 2, "bar": true]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should not be equal to 1")
            let shouldFail_0 = try Filter(properties: ["foo": 1, "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should not be equal to 1, but it's exatly that")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMajorInt() {
        let name = "allMajorInt"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 4]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be major of 3")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMajorEqualInt() {
        let name = "allMajorEqualInt"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 4]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be major or equal to 3")
            let shouldPass_1 = try Filter(properties: ["foo": 3]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be major or equal to 3")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMinorInt() {
        let name = "allMinorInt"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 2]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be minor of 3")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testAllMinorEqualInt() {
        let name = "allMinorEqualInt"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let shouldPass_0 = try Filter(properties: ["foo": 2]).compile(parsed)
            XCTAssert(shouldPass_0, "Foo should be minor or equal to 3")
            let shouldPass_1 = try Filter(properties: ["foo": 3]).compile(parsed)
            XCTAssert(shouldPass_1, "Foo should be minor or equal to 3")
            let shouldFail_0 = try Filter(properties: ["foo": "filled", "bar": "span"]).compile(parsed)
            XCTAssert(shouldFail_0 == false, "Foo should be different than bar, but none of the conditions should be bet")
            let shouldFail_1 = try Filter(properties: ["foo": "bar", "swift": 1]).compile(parsed)
            XCTAssert(shouldFail_1 == false, "Foo should be different than bar, but swift is 1, so one condition is met.")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testNoFilters() {
        do {
            let shouldPass_0 = try Filter(properties: ["foo": "bar", "bar": "span"]).compile( nil)
            XCTAssert(shouldPass_0, "Should pass: no filter provided")
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testThrowNotString() {
        let name = "throwNotString"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: ["foo": "bar", "bar": "span"]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.firstElementNotAString, "First element is not a string")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowUnknownOperation() {
        let name = "throwUnknownOperation"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.unknownOperation, "Unknown operation")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowUnknownFilter() {
        let name = "throwUnknownFilter"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.unknownOperation, "Unknown operation")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowPropertyNotString() {
        let name = "throwPropertyNotString"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.propertyNameNotAString, "Property not a string")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowInPropertyNotString() {
        let name = "throwInPropertyNotString"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.propertyNameNotAString, "Property not a string")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowHasPropertyNotString() {
        let name = "throwHasPropertyNotString"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.propertyNameNotAString, "Property not a string")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowInNoValues() {
        let name = "throwInNoValues"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.noValuesProvidedForProperty, "No values provided for property")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowEqualNoValue() {
        let name = "throwEqualNoValue"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.missingComparisonValue, "Missing comparison value")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowNoFiltersJson() {
        let name = "throwNoFilters"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.missingFilters, "Missing filters")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowFirstElementNotAString() {
        let name = "throwFirstElementNotAString"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.firstElementNotAString, "First element not a string")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func testThrowWrongJsonFormat() {
        let name = "throwWrongJsonFormat"
        guard let parsed = parseFixture(name) else {
            XCTFail("Not a valid fixture")
            return
        }
        do {
            let _ = try Filter(properties: [:]).compile(parsed)
        } catch let error {
            if let error = error as? FilterError {
                XCTAssert(error == FilterError.propertyNameNotAString, "Property name not a string")
            } else {
                XCTFail("Thrown error should be of FilterError type")
            }
        }
    }
    
    func parseFixture(_ named: String) -> [Any]? {
        var _fileUrl : URL?
        #if !os(Linux)
            _fileUrl = Bundle(for: FilterKitTests.self).url(forResource: named, withExtension: "json")
        #else
            _fileUrl = URL(fileURLWithPath: "./Tests/FilterKitTests/Fixtures/\(named).json")
            print(_fileUrl!.absoluteString)
        #endif
        guard let fileUrl = _fileUrl else {
            XCTFail("Cannot open fixture file named \(named)")
            return nil
        }
        
        do {
            let jsonData = try Data.init(contentsOf: fileUrl)
            let deserializedObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            guard let dictionary = deserializedObject as? [String: Any?] else {
                XCTFail("Cannot parse json in fixture file named \(named)")
                return nil
            }
            
            guard let filterArray = dictionary["filter"] as? [Any] else {
                XCTFail("Cannot find proper filter element in fixture file named \(named)")
                return nil
            }
            
            return filterArray
        } catch let error {
            XCTFail("Error in fixture file named \(named) - \(error.localizedDescription)")
        }
        return nil
    }
}
