//
//  TableFooterRefreshView.h
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/2.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableFooterRefreshView : UIView

/**
 *  Init method
 *
 *  @param scrollView       The associated scorll view
 *  @param hasNavigationBar If there is a navigation bar
 *
 *  @return self
 */
- (instancetype)initWithScrollView:(UIScrollView *)scrollView hasNavigationBar:(BOOL)hasNavigationBar;

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
