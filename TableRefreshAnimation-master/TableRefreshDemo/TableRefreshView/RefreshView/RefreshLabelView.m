//
//  RefreshLabelView.m
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/1.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "RefreshLabelView.h"

#define kLabelHeight    40

#define PULLDOWN_REFRESH @"下拉即可刷新..."
#define PULLUP_RERESH    @"上拉即可刷新..."
#define RELEASE_REFRESH  @"松开即可刷新..."
#define IS_REFRESH       @"正在刷新列表..."

@interface RefreshLabelView ()

@property (nonatomic, strong) UILabel *noticeLB;

@end

@implementation RefreshLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.noticeLB = [[UILabel alloc] initWithFrame:CGRectMake(0, self.center.y - kLabelHeight/2, CGRectGetWidth(self.frame), kLabelHeight)];
    self.noticeLB.adjustsFontSizeToFitWidth = YES;
    self.noticeLB.text = PULLDOWN_REFRESH;
    self.noticeLB.textColor = [UIColor blackColor];
    [self addSubview:self.noticeLB];
    self.direction = DOWN;
}

- (void)setProgress:(CGFloat)progress {
    self.noticeLB.alpha = progress;
    
    if (self.isLoading) {
        self.noticeLB.text = IS_REFRESH;
    }else {
        if (progress < 1.0) {
            self.noticeLB.text = self.direction == UP?PULLUP_RERESH:PULLDOWN_REFRESH;
        }else {
            self.noticeLB.text = RELEASE_REFRESH;
        }
    }
}

@end
