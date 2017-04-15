//
//  CodeView.m
//  UIViewController和UIView生命周期加载和卸载
//
//  Created by huangchengdu on 17/4/14.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "CodeView.h"

@implementation CodeView

-(instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"init");
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    NSLog(@"initWithCoder");
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"移除" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    NSLog(@"initWithFrame");
    return self;
}

-(void)clickButton:(UIButton *)sender{
    [self removeFromSuperview];
    NSLog(@"点击移除");
}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"layoutSubviews");
}

-(void)setNeedsLayout{
    [super setNeedsLayout];
    NSLog(@"setNeedsLayout");
}

-(void)layoutIfNeeded{
    [super layoutIfNeeded];
    NSLog(@"layoutIfNeeded");
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    NSLog(@"willMoveToSuperview");
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    NSLog(@"didMoveToSuperview");
    
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    NSLog(@"willMoveToWindow");
}
- (void)didMoveToWindow{
    [super didMoveToWindow];
    NSLog(@"didMoveToWindow");
}

-(void)dealloc{
    NSLog(@"dealloc");
}

@end
