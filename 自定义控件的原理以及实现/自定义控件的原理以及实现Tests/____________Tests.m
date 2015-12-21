//
//  ____________Tests.m
//  自定义控件的原理以及实现Tests
//
//  Created by huangchengdu on 15/12/21.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ____________Tests : XCTestCase

@end

@implementation ____________Tests

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
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
