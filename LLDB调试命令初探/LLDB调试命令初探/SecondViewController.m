//
//  SecondViewController.m
//  LLDB调试命令初探
//
//  Created by huangchengdu on 15/11/24.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //命令行中修改属性。比如修改视图的背景颜色
//    (lldb) call [self.view setBackgroundColor:[UIColor redColor]]
//error: no known method '-setBackgroundColor:'; cast the message send to the method's return type
//error: 1 errors parsing expression
//    (lldb) call (void)[self.view setBackgroundColor:[UIColor redColor]]
    
    
    
    
    
    //通过地址错误信息的地址，通过命令得到对应的代码中的位置。
//    NSArray *arr=[[NSArray alloc] initWithObjects:@"1",@"2", nil];
//    NSLog(@"%@",arr[2]);
    
//    2015-11-24 10:15:18.013 LLDB调试命令初探[2449:316812] *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayI objectAtIndex:]: index 2 beyond bounds [0 .. 1]'
//    *** First throw call stack:
//    (
//     0   CoreFoundation                      0x0000000104e4df45 __exceptionPreprocess + 165
//     1   libobjc.A.dylib                     0x00000001048c7deb objc_exception_throw + 48
//     2   CoreFoundation                      0x0000000104d3cb14 -[__NSArrayI objectAtIndex:] + 164
//     3   LLDBË∞ÉËØïÂëΩ‰ª§ÂàùÊé¢              0x00000001043ca533 -[SecondViewController viewDidLoad] + 163
//     4   UIKit                               0x000000010538ccc4 -[UIViewController loadViewIfRequired] + 1198
//     5   UIKit                               0x0000000105392c7b -[UIViewController __viewWillAppear:] + 120
//     6   UIKit                               0x00000001053c2a37 -[UINavigationController _startCustomTransition:] + 1203
//     7   UIKit                               0x00000001053d2cdb -[UINavigationController _startDeferredTransitionIfNeeded:] + 712
//     8   UIKit                               0x00000001053d3cea -[UINavigationController __viewWillLayoutSubviews] + 57
//     9   UIKit                               0x0000000105579c85 -[UILayoutContainerView layoutSubviews] + 248
//     10  UIKit                               0x00000001052aee40 -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 710
//     11  QuartzCore                          0x0000000108d5c59a -[CALayer layoutSublayers] + 146
//     12  QuartzCore                          0x0000000108d50e70 _ZN2CA5Layer16layout_if_neededEPNS_11TransactionE + 366
//     13  QuartzCore                          0x0000000108d50cee _ZN2CA5Layer28layout_and_display_if_neededEPNS_11TransactionE + 24
//     14  QuartzCore                          0x0000000108d45475 _ZN2CA7Context18commit_transactionEPNS_11TransactionE + 277
//     15  QuartzCore                          0x0000000108d72c0a _ZN2CA11Transaction6commitEv + 486
//     16  UIKit                               0x00000001051f4ca4 _UIApplicationHandleEventQueue + 7329
//     17  CoreFoundation                      0x0000000104d7a011 __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
//     18  CoreFoundation                      0x0000000104d6ff3c __CFRunLoopDoSources0 + 556
//     19  CoreFoundation                      0x0000000104d6f3f3 __CFRunLoopRun + 867
//     20  CoreFoundation                      0x0000000104d6ee08 CFRunLoopRunSpecific + 488
//     21  GraphicsServices                    0x00000001085e9ad2 GSEventRunModal + 161
//     22  UIKit                               0x00000001051fa30d UIApplicationMain + 171
//     23  LLDBË∞ÉËØïÂëΩ‰ª§ÂàùÊé¢              0x00000001043caacf main + 111
//     24  libdyld.dylib                       0x000000010757192d start + 1
//     )
//    libc++abi.dylib: terminating with uncaught exception of type NSException
//    (lldb) image lookup --address 0x00000001043ca533
//Address: LLDB调试命令初探[0x0000000100001533] (LLDB调试命令初探.__TEXT.__text + 163)
//Summary: LLDB调试命令初探`-[SecondViewController viewDidLoad] + 163 at SecondViewController.m:21
//    (lldb)
    
}

@end
