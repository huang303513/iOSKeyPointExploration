//
//  ViewController.m
//  自定义控件的原理以及实现
//
//  Created by huangchengdu on 15/12/21.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import "ImageControl.h"
#warning 参考博客地址：http://southpeak.github.io/blog/2015/12/13/cocoa-uikit-uicontrol/


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    ImageControl *control = [[ImageControl alloc]initWithFrame:CGRectMake(50, 100, 200, 300) title:@"黄成都你好" image:[UIImage imageNamed:@"blackboard1024"]];
    control.clipsToBounds = YES;
    control.layer.borderWidth = 1;
    control.layer.borderColor = [UIColor lightTextColor].CGColor;
    control.center = (CGPoint){self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f};
    [control addTarget:self action:@selector(tapImageControl:) forControlEvents:UIControlEventTouchUpInside];
    
    [control addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    
    // 如果我们没有指定target，则会将事件分发到响应链上第一个想处理消息的对象上。这里既是control处理
    [control addTarget:nil action:@selector(tapImageControl:) forControlEvents:UIControlEventTouchUpInside];
    
    //模拟一个点击事件
    [control sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:control];
}

- (void)tapImageControl:(id)sender {
    
    NSLog(@"sender = %@", sender);
}

- (void)touchDown:(id)sender {
    NSLog(@"touch down");
}
@end
