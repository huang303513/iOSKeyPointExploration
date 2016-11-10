//
//  ViewController.m
//  LLDB调试命令初探
//
//  Created by huangchengdu on 15/11/24.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#warning 参考博客地址：http://www.starfelix.com/blog/2014/03/17/lldbdiao-shi-ming-ling-chu-tan/

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    /*
    (lldb) po [self view]
    <UIView: 0x7fcccbe14c10; frame = (0 0; 320 568); autoresize = W+H; layer = <CALayer: 0x7fcccbe2b760>>
    
    (lldb) p [[[self view] subviews] count]
error: no known method '-count'; cast the message send to the method's return type
error: 1 errors parsing expression
    (lldb) p (int)[[[self view] subviews] count]
    (int) $1 = 2
    (lldb) po $1
    2
     */
    
    
    
    int a = 1;
    NSLog(@"实际值:%d",a);
    //在调试过程中修改变量的值
//    (lldb) expr a = 2
//    (int) $0 = 2
//    2015-11-24 09:59:29.302 LLDB调试命令初探[2220:263598] 实际值:2
//    (lldb)
    
    //新声明一个变量对象
//    (lldb) expr int $b=2
//    (lldb) p $b
//    (int) $b = 2
    
    
    
    
    
}



-(void)insertNewObject:(UIBarButtonItem *)item{
    SecondViewController *second = [[SecondViewController alloc]init];
    [self.navigationController  pushViewController:second animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
