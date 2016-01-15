//
//  TableHeaderRefreshView.m
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/1.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import "TableHeaderRefreshView.h"
#import "RefreshView.h"
#import "RefreshLabelView.h"

#define kRefreshViewWidth  200
#define kRefreshViewHeight 80

#define kMaxPullDownDistance   84

typedef void(^RefreshingBlock)(void);

@interface TableHeaderRefreshView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) RefreshView *refreshView;
@property (nonatomic, strong) RefreshLabelView *refreshLBView;

@property (nonatomic, assign) CGFloat originOffset;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL notTracking;
@property (nonatomic, copy) RefreshingBlock refreshingBlock;

@end

@implementation TableHeaderRefreshView

- (instancetype)initWithScrollView:(UIScrollView *)scrollView hasNavigationBar:(BOOL)hasNavigationBar {
    self = [super initWithFrame:CGRectMake((CGRectGetWidth(scrollView.frame) - kRefreshViewWidth)/2, -kRefreshViewHeight, kRefreshViewWidth, kRefreshViewHeight)];
    if (self) {
        if (hasNavigationBar) {
            self.originOffset = 64.0;
        }else {
            self.originOffset = 0.0;
        }
        [self setUI];
        self.scrollView = scrollView;
        [self.scrollView insertSubview:self atIndex:0];
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)setUI {
    self.refreshView = [[RefreshView alloc] initWithFrame:CGRectMake(20, 0, 40, CGRectGetHeight(self.frame))];
    [self insertSubview:self.refreshView atIndex:0];
    
    CGFloat lbX = self.refreshView.frame.origin.x + CGRectGetWidth(self.refreshView.frame) + 10;
    CGFloat lbWidth = kRefreshViewWidth - lbX - 30;
    self.refreshLBView = [[RefreshLabelView alloc] initWithFrame:CGRectMake(lbX, 0, lbWidth, CGRectGetHeight(self.frame))];
    [self insertSubview:self.refreshLBView aboveSubview:self.refreshView];
}

- (void)setProgress:(CGFloat)progress {
    if (!self.scrollView.tracking) {
        self.refreshLBView.isLoading = YES;
    }
    
    if (!self.isLoading) {
        self.refreshView.progress = progress;
        self.refreshLBView.progress = progress;
    }

    CGFloat overDistance = fabs(self.originOffset + self.scrollView.contentOffset.y) - kMaxPullDownDistance + 10;
    if (overDistance > 0) {
        if (!self.scrollView.tracking) {
            if (!self.notTracking) {
                self.notTracking = YES;
                self.isLoading = YES;
                
                [self startLoading:self.refreshView];
                
                // 0.3s animation time is the best experience
                [UIView animateWithDuration:0.3 animations:^{
                    self.scrollView.contentInset = UIEdgeInsetsMake(kMaxPullDownDistance + self.originOffset, 0, 0, 0);
                } completion:^(BOOL finished) {
                    if (self.refreshingBlock) {
                        self.refreshingBlock();
                    }
                }];
            }
        }
        
        if (!self.isLoading) {
            self.refreshView.transform = CGAffineTransformMakeRotation(overDistance/40);
        }
    }else {
        self.refreshLBView.isLoading = NO;
        self.refreshView.transform = CGAffineTransformIdentity;
    }
}

- (void)startLoading:(UIView *)view {
    CABasicAnimation *rotationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationZ.fromValue = @(0);
    rotationZ.toValue = @(M_PI*2);
    rotationZ.repeatDuration = HUGE_VAL;
    rotationZ.duration = 1.0;
    rotationZ.cumulative = YES;
   [view.layer addAnimation:rotationZ forKey:@"headerRotationZ"];
}

- (void)stopLoading:(UIView *)view {
    [view.layer removeAllAnimations];
}

- (void)doRefresh {
    [self.scrollView setContentOffset:CGPointMake(0, - kMaxPullDownDistance) animated:YES];
}

- (void)stopRefresh {
    self.progress = 1.0;
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
        self.scrollView.contentInset = UIEdgeInsetsMake(self.originOffset + 0.1, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.alpha = 1.0;
        self.isLoading = NO;
        self.notTracking = NO;
        self.refreshLBView.isLoading = NO;
        [self stopLoading:self.refreshView];
    }];
}

- (void)addRefreshingBlock:(void (^)())block {
    self.refreshingBlock = block;
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (self.originOffset + contentOffset.y <= 0) {
            self.progress = MAX(0.0, MIN(fabs((self.originOffset + contentOffset.y)/kMaxPullDownDistance), 1.0));
        }
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
