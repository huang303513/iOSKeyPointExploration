//
//  main.m
//  Block解析2
//
//  Created by maiyun on 15/6/12.
//  Copyright © 2015年 黄成都. All rights reserved.
//

//#import <Foundation/Foundation.h>

int main() {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//    }
    __block int val = 10;
    void (^blk)(void) = ^{val = 1;};
    blk();
    
    return 0;
}
