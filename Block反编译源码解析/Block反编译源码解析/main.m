//
//  main.m
//  Block反编译源码解析
//
//  Created by huangchengdu on 17/4/11.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//




#include "stdio.h"

typedef void (^Block)();

int global_val = 1;
static int static_global_val = 2;

int main() {
    
    @autoreleasepool {
        __block int one = 1;
        static int static_val = 2;
        Block block1 = ^(){
            one =  2;
            global_val = global_val + 1;
            static_global_val = static_global_val + 1;
            static_val = static_val + 1;
            printf("%d--%d--%d--%d",one,global_val,static_global_val,static_val);
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
