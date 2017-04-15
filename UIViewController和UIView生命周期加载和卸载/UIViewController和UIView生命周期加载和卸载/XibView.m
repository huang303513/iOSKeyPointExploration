//
//  XibView.m
//  UIViewController和UIView生命周期加载和卸载
//
//  Created by huangchengdu on 17/4/14.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "XibView.h"

@implementation XibView

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
    NSLog(@"initWithFrame");
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 50)];
    view.backgroundColor = [UIColor greenColor];
    [self addSubview:view];
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 100, 50)];
    view1.backgroundColor = [UIColor redColor];
    [self addSubview:view1];
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

- (IBAction)remove:(id)sender {
    [self removeFromSuperview];
}
-(void)dealloc{
    NSLog(@"dealloc");
}

@end
