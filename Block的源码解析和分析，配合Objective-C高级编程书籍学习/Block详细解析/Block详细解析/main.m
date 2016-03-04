//
//  main.m
//  Block详细解析
//
//  Created by maiyun on 15/6/12.
//  Copyright © 2015年 黄成都. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <stdio.h>

int main() {
//    @autoreleasepool {
//        // insert code here...
//        NSLog(@"Hello, World!");
//    }
    void (^blk)(void) = ^{
       // printf("Block\n");
        //printf("Block\n");
       // printf("%f\n",1.3);

    };
    blk();
    return 0;
}
