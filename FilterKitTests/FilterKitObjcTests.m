//
//  FilterKitObjcTests.m
//  FilterKitTests
//
//  Created by Matteo Gavagnin on 05/09/2017.
//  Copyright © 2017 DIMENSION. All rights reserved.
//

#import <XCTest/XCTest.h>
@import FilterKit;
@interface FilterKitObjcTests : XCTestCase

@end

@implementation FilterKitObjcTests

/**
 This test is just to prove the compatibility with Objective-C.
 Take a look at FilterKitTests.swift for the complete test suite.
 */
- (void)testObjectiveC {
    FILFilter *filter = [[FILFilter alloc] initWithProperties:@{@"foo": @"bar"}];
    NSError *error;
    FILFilterResult *result = [filter compileWithFilters:@[] error:&error];
    if(error != nil) {
        NSLog(@"%@", error);
        XCTAssert(error.code == 1);
    }
    XCTAssert(result.valid == false);
}

- (void)testWithFilters {
    FILFilter *filter = [[FILFilter alloc] initWithProperties:@{@"foo": @"bar"}];
    NSError *error;
    FILFilterResult *result = [filter compileWithFilters:@[@"all", @[@"==", @"foo", @"bar"]] error:&error];
    if(error != nil) {
        NSLog(@"%@", error);
        XCTAssert(error.code == 1);
    }
    NSLog(@"Result: %d", result.valid);
    XCTAssert(result.valid == true);
}

@end
