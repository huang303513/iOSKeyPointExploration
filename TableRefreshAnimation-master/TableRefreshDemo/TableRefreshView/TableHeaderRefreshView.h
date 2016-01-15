//
//  TableHeaderRefreshView.h
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/1.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableHeaderRefreshView : UIView

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
 *  Do refresh
 */
- (void)doRefresh;

/**
 *  Stop refresh
 */
- (void)stopRefresh;

@end
