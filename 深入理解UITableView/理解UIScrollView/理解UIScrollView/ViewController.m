//
//  ViewController.m
//  理解UIScrollView
//
//  Created by yifan on 15/8/26.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "CustomScrollView.h"

#warning 参考博客地址 http://blog.jobbole.com/70143/
@interface ViewController ()
@property (nonatomic) CustomScrollView *customScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customScrollView = [[CustomScrollView alloc] initWithFrame:self.view.bounds];
    self.customScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1000);
    self.customScrollView.scrollHorizontal = NO;
    

    self.customScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.customScrollView];
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    redView.backgroundColor = [UIColor colorWithRed:0.815 green:0.007
                                               blue:0.105 alpha:1];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(150, 160, 150, 200)];
    greenView.backgroundColor = [UIColor colorWithRed:0.494 green:0.827
                                                 blue:0.129 alpha:1];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(40, 400, 200, 150)];
    blueView.backgroundColor = [UIColor colorWithRed:0.29 green:0.564
                                                blue:0.886 alpha:1];
    
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(100, 600, 180, 150)];
    yellowView.backgroundColor = [UIColor colorWithRed:0.972 green:0.905
                                                blue:0.109 alpha:1];
    
    NSLog(@"yellowView bounds:%@, frame:%@",NSStringFromCGRect(yellowView.bounds),NSStringFromCGRect(yellowView.frame));
    
//    CGRect bounds = self.customScrollView.bounds;
//    bounds.origin = CGPointMake(0, 100);
//    self.customScrollView.bounds = bounds;
    
    [self.customScrollView addSubview:redView];
    [self.customScrollView addSubview:greenView];
    [self.customScrollView addSubview:blueView];
    [self.customScrollView addSubview:yellowView];
    
    UIView *redView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 500+20, 100, 100)];
    UIView *greenView1 = [[UIView alloc] initWithFrame:CGRectMake(150, 500+160, 150, 200)];
    UIView *blueView1 = [[UIView alloc] initWithFrame:CGRectMake(40, 500+400, 200, 150)];
    UIView *yellowView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 500+600, 180, 150)];
    
    redView1.backgroundColor = [UIColor purpleColor];
    greenView1.backgroundColor = [UIColor redColor];
    blueView1.backgroundColor = [UIColor grayColor];
    yellowView1.backgroundColor = [UIColor blackColor];
    
    [self.customScrollView addSubview:redView1];
    [self.customScrollView addSubview:greenView1];
    [self.customScrollView addSubview:blueView1];
    [self.customScrollView addSubview:yellowView1];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
