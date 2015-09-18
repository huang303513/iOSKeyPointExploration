//
//  LGFirstView.m
//  iOS事件传递机制以及相应函数
//
//  Created by yifan on 15/9/18.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "LGFirstView.h"

@interface LGFirstView ()
@property (nonatomic, strong) UIButton *buttonFirst;
@end

@implementation LGFirstView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *buttonFirst = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFirst.frame = CGRectMake(20, 20, 100, 50);
        [buttonFirst setTitle:@"first" forState:UIControlStateNormal];
        [buttonFirst setBackgroundColor:[UIColor orangeColor]];
        [buttonFirst setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:buttonFirst];
        [buttonFirst addTarget:self action:@selector(actionButtonFirstClick:) forControlEvents:UIControlEventTouchUpInside];
        _buttonFirst = buttonFirst;
    }
    return self;
}

- (void)actionButtonFirstClick:(id)sender
{
    NSLog(@"点击了FirstView的button");
}
//如果返回空，表示没有找到响应者。
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 当touch point是在self.buttonFirst上，则hitTest返回self.buttonFirst。。这意味着buttonFirst来处理这个时间并且停止遍历相应者。
    CGPoint btnPointInA = [self.buttonFirst convertPoint:point fromView:self];
    if ([self.buttonFirst pointInside:btnPointInA withEvent:event]) {
        return self.buttonFirst;
    }
    // 否则，返回默认处理
    return [super hitTest:point withEvent:event];
    
}


@end
