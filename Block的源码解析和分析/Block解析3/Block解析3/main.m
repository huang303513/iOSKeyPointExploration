//
//  main.m
//  Block解析3
//
//  Created by maiyun on 15/6/13.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^blk_t)(id boj);

int main(int argc, const char * argv[]) {
    //=================================================
//    @autoreleasepool {
//        __block int val = 0;
//        //初始化一个block，并且复制到堆上。然后让blk变量引用
//        //对应的val实例变量也复制到堆上。但是堆Block上的val变量和栈Block上的val实例变量指向同一个val对象。
//        void (^blk)(void) = [^{++val;} copy];
//        ++val;
//        blk();
//        NSLog(@"%d",val);  //输出结果为2
//        
//    }
    //===========================================================
    blk_t blk;
    {
        id array = [[NSMutableArray alloc]init];
        blk = [^(id obj){
            [array addObject:obj];
            NSLog(@"array count = %ld",[array count]);
        } copy];
        //blk从栈复制到堆上。同事blk拥有对array的强引用，所以array即使超出了其作用范围也不会被dealloc。array拥有的对象也不会被回收。如果没有使用copy，那么则array中每次都只有一个对象。
    }
    blk([[NSObject alloc]init]);
    blk([[NSObject alloc]init]);
    blk([[NSObject alloc]init]);
    //只有调用了copy方法以后，block才能截获__strong修饰符的自动变量值。
    
    //建议除了以下几种情况以外，其他情况下都需要用block的copy方法。
     //1 Block作为函数返回值返回时。
     //2将Block赋值给有__strong修饰符的id类型或者Block类型的成员变量时。
     //向方法名中含所有usingBlock的Cocoa框架方法或者GCD的API中传递的Block时。
    
    
    return 0;
}
