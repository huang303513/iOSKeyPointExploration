//
//  HCDRefreshFooterView.h
//  自定义刷新控件轮子
//
//  Created by 黄成都 on 16/1/16.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCDRefreshFooterView : UIView
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

/**
 *  Add refresh block to handle something when refreshing
 *
 *  @param block Refresh block
 */
- (void)addRefreshingBlock:(void(^)())block;

/**
 *  Stop Refresh
 */
- (void)stopRefresh;
@end
