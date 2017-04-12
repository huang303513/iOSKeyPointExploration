//
//  main.m
//  Block反编译源码解析
//
//  Created by huangchengdu on 17/4/11.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//




#include "stdio.h"

typedef void (^Block)();

int main() {
    
    @autoreleasepool {
        __block int i = 1;
        Block block1 = ^(){
            i =  2;
            printf("%d",i);
        };
        block1();
    }
    return 0;
}


//
//int main() {
//    int (^blk)(int i) = ^(int i){
//        int result =  i + 1;
//        return result;
//    };
//    blk(3);
//    return 0;
//}
