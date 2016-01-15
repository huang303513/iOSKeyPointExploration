//
//  RefreshLabelView.h
//  TableRefreshDemo
//
//  Created by 宫城 on 16/1/1.
//  Copyright © 2016年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DIRECTION) {
    UP,
    DOWN
};

@interface RefreshLabelView : UIView

/**
 *  Rate of progress,from 0 to 1
 */
@property (nonatomic, assign) CGFloat progress;

/**
 *  The direction of the pull
 */
@property (nonatomic, assign) DIRECTION direction;

/**
 *  Whether is loading
 */
@property (nonatomic, assign) BOOL isLoading;

@end
