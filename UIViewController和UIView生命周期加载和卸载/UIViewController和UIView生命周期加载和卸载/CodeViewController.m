//
//  CodeViewController.m
//  UIViewController和UIView生命周期加载和卸载
//
//  Created by huangchengdu on 17/4/14.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "CodeViewController.h"

@interface CodeViewController ()

@end

@implementation CodeViewController
//http://www.jianshu.com/p/b1352b483d85

-(instancetype)init{
    self =[super init];
    NSLog(@"init");
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    NSLog(@"initWithCoder");
    return self;
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nil bundle:nil];
    NSLog(@"initWithNibName");
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
}

-(void)loadView{
    [super loadView];
    NSLog(@"loadView");
}
-(void)loadViewIfNeeded{
    [super loadViewIfNeeded];
    NSLog(@"loadViewIfNeeded");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 100, 50)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    NSLog(@"viewDidLoad");
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"viewWillLayoutSubviews");
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear");
}
-(void)dealloc{
    NSLog(@"dealloc");
}

@end
