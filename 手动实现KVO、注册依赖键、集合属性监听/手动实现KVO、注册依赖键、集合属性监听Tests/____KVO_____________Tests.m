//
//  ____KVO_____________Tests.m
//  手动实现KVO、注册依赖键、集合属性监听Tests
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface ____KVO_____________Tests : XCTestCase

@end

@implementation ____KVO_____________Tests

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
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
