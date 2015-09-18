//
//  LGSecondView.m
//  iOS事件传递机制以及相应函数
//
//  Created by yifan on 15/9/18.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "LGSecondView.h"

@interface LGSecondView ()
//所有能相应事件的子视图
@property (nonatomic, strong) NSMutableArray *subControlsArray;
@end

@implementation LGSecondView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _subControlsArray = [NSMutableArray array];
      
    }
    return self;
}


/**
 *  重写addsubview方法
 *
 *  @param view 并且保存所有用户添加的子view
 */
- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    if ([view isKindOfClass:[UIControl class]]) {
        [self.subControlsArray addObject:view];
    }
}

/**
 *  遍历是否有点击在用户自己添加的子视图上。如果在这些用户自己添加的子视图上，则返回true表示在这个视图里面。否则表示没有在这个视图里面(这样设置是为了测试用户自己添加的子视图)
 *这样的话，即使用户点击到这个视图上，但是没有点击在用户添加的视图上。都返回no，表示没有在用户范围内。
 *  @param point <#point description#>
 *  @param event <#event description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
{
    BOOL toNext = YES;
    for (UIView *view in _subControlsArray) {
        if (CGRectContainsPoint(view.frame, point)) {
            toNext = NO;
            break;
        }
    }
    return !toNext;
}


@end
