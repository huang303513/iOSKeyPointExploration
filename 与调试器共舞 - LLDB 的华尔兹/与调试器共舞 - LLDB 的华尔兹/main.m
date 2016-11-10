//
//  main.m
//  与调试器共舞 - LLDB 的华尔兹
//
//  Created by huangchengdu on 15/11/24.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning 参考博客地址：http://objccn.io/issue-19-2/


//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        NSUInteger count = 99;
//        NSString *objects = @"red balloons";
//        
//        NSLog(@"%lu   %@.",count,objects);
//        
//        //1 修改变量的值，打印变量的值
//        /*
//        (lldb) print count
//        (NSUInteger) $0 = 99
//        (lldb) print $0 + 7
//        (unsigned long) $1 = 106
//        (lldb) expression count = 42
//        (NSUInteger) $2 = 42
//        2015-11-24 10:56:11.945 与调试器共舞 - LLDB 的华尔兹[2962:478230] 42   red balloons.
//         */
//        //==========================================================
//        //2各种打印模式
//        /*
//         (lldb) p objects
//         (__NSCFConstantString *) $3 = 0x0000000100001038 @"red balloons"
//         (lldb) p @[@"foo", @"bar"]
//         (__NSArrayI *) $4 = 0x00000001028010e0 @"2 objects"
//         (lldb) p -o $4
//         error: use of undeclared identifier 'o'
//         error: 1 errors parsing expression
//         (lldb) p -o -- $4
//         error: use of undeclared identifier 'o'
//         error: 1 errors parsing expression
//         (lldb) e -o -- $4
//         <__NSArrayI 0x1028010e0>(
//         foo,
//         bar
//         )
//         
//         (lldb) po $4
//         <__NSArrayI 0x1028010e0>(
//         foo,
//         bar
//         )
//         */
//        
//        //====================================================
//        //3对变量进行处理
//        /*
//         (lldb) e int $a = 2
//         (lldb) p $a * 19
//         (int) $0 = 38
//         (lldb) e NSArray *$array = @[@"Staturday",@"Sunday",@"Monday"]
//         (lldb) p [$array count]
//         (NSUInteger) $1 = 3
//         (lldb) po [[$array objectAtIndex:0] uppercaseString]
//         STATURDAY
//         
//         (lldb)
//         */
//        
//        //======================================================
//        
//    }
//    return 0;
//}


static BOOL isEven(int i){
    if (i % 2 == 0) {
        NSLog(@"%d is even!",i);
        return YES;
    }
    NSLog(@"%d is odd!",i);
    return NO;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int i = 99;
        BOOL even0 = isEven(i + 2);
        BOOL even1 = isEven(i + 11);
        
        //1 删除断点
//        通过 `br li`命令来查看所有断点列表
//        通过`br dis 1`来让第一个断点无效
//        通过`br del 1`来删除第一个断点
        
        
        
    }
    return 0;
}
