//
//  RefreshView.m
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/1.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "RefreshView.h"
#import "RefreshLayer.h"

@interface RefreshView ()

@property (nonatomic, strong) RefreshLayer *refreshLayer;

@end

@implementation RefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {
    self.refreshLayer.progress = progress;
    [self.refreshLayer setNeedsDisplay];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.refreshLayer = [RefreshLayer layer];
    self.refreshLayer.frame = self.bounds;
    self.refreshLayer.contentsScale = [UIScreen mainScreen].scale;
    self.refreshLayer.progress = 0.0;
    [self.refreshLayer setNeedsDisplay];
    [self.layer addSublayer:self.refreshLayer];
}

@end
