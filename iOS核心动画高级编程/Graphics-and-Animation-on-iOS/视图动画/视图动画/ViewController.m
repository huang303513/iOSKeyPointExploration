//
//  ViewController.m
//  视图动画
//
//  Created by maiyun on 15/6/17.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIImageView *XcodeImageView;


@property(nonatomic,strong)UIImageView *XcodeImageView1;
@property(nonatomic,strong)UIImageView *XcodeImageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *xcodeImage = [UIImage imageNamed:@"Xcode.png"];
    _XcodeImageView1 = [[UIImageView alloc]initWithImage:xcodeImage];
    [_XcodeImageView1 setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    [self.view addSubview:self.XcodeImageView1];
    
    _XcodeImageView2 = [[UIImageView alloc]initWithImage:xcodeImage];
    [_XcodeImageView2 setFrame:CGRectMake(220.0f, 350.0f, 100.0f, 100.0f)];
    [self.view addSubview:self.XcodeImageView2];

    
}

- (void) startTopLeftImageViewAnimation{
    
    /* Start from top left corner */
    [self.XcodeImageView1 setFrame:CGRectMake(0.0f,
                                              0.0f,
                                              100.0f,
                                              100.0f)];
    
    self.XcodeImageView1.transform = CGAffineTransformIdentity;
    
    [self.XcodeImageView1 setAlpha:1.0f];
    
    [UIView beginAnimations:@"xcodeImageView1Animation"
                    context:(__bridge void *)(_XcodeImageView1)];
    
    /* 3 seconds animation */
    [UIView setAnimationDuration:3.0f];
    
    /* Receive animation delegates */
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:
     @selector(imageViewDidStop:finished:context:)];
    
    /* End at the bottom right corner */
    [self.XcodeImageView1 setFrame:CGRectMake(220.0f,
                                              350.0f,
                                              100.0f,
                                              100.0f)];
    
    [self.XcodeImageView1 setAlpha:0.0f];
    
    [UIView commitAnimations];
    
}

- (void) startBottomRightViewAnimationAfterDelay:
(CGFloat)paramDelay{
    
    /* Start from bottom right corner */
    [self.XcodeImageView2 setFrame:CGRectMake(220.0f,
                                              350.0f,
                                              100.0f,
                                              100.0f)];
    
    [self.XcodeImageView2 setAlpha:1.0f];
    
    [UIView beginAnimations:@"xcodeImageView2Animation"
                    context:(__bridge void *)(_XcodeImageView2)];
    
    /* 3 seconds animation */
    [UIView setAnimationDuration:3.0f];
    
    [UIView setAnimationDelay:paramDelay];
    
    /* Receive animation delegates */
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationDidStopSelector:
     @selector(imageViewDidStop:finished:context:)];
    
    /* End at the top left corner */
    [self.XcodeImageView2 setFrame:CGRectMake(0.0f,
                                              0.0f,
                                              100.0f,
                                              100.0f)];
    
    [self.XcodeImageView2 setAlpha:0.0f];
    
    [UIView commitAnimations];
    
}

- (void)imageViewDidStop:(NSString *)paramAnimationID
                finished:(NSNumber *)paramFinished
                 context:(void *)paramContext{
    
    UIImageView *contextImageView = (__bridge UIImageView *)paramContext;
    [contextImageView removeFromSuperview];
    
}

- (void) viewDidAppear:(BOOL)paramAnimated{
    
    [super viewDidAppear:paramAnimated];
    [self startTopLeftImageViewAnimation];
    [self startBottomRightViewAnimationAfterDelay:2.0f];
    
}








////视图从左上角移动到右下角
//-(void)moveFromTopLeftToRightBottow{
//    UIImage *xcodeImage = [UIImage imageNamed:@"Xcode.png"];
//    _XcodeImageView = [[UIImageView alloc]initWithImage:xcodeImage];
//    [_XcodeImageView setFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
//    [self.view addSubview:self.XcodeImageView];
//    
//    [UIView beginAnimations:@"xcodeImageViewAnimation" context:(__bridge void *)(_XcodeImageView)];
//    [UIView setAnimationDuration:5.0f];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(imageVieweDidStop:finished:context:)];
//    [self.XcodeImageView setFrame:CGRectMake(200.0f, 350.0f, 100.0f, 100.0f)];
//    [UIView commitAnimations];
//}
//
//
//
//-(void)imageVieweDidStop:(NSString *)paramAnimationID finished:(NSNumber *)paramFinished context:(void *)paramContext{
//    NSLog(@"animation finished.");
//    NSLog(@"Animation ID = %@",paramAnimationID);
//    UIImageView *contextImageView =(__bridge UIImageView *)paramContext;
//    NSLog(@"Image View = %@",contextImageView);
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
