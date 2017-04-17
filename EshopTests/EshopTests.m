//
//  EshopTests.m
//  EshopTests
//
//  Created by 吴狄 on 2017/4/10.
//  Copyright © 2017年 jsyh. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface EshopTests : XCTestCase

@end

@implementation EshopTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    XCTAssert(YES,@"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
