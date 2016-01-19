//
//  MCMastorBoard.h
//  MCScrollCard
//
//  Created by mac on 15/9/18.
//  Copyright © 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCardBoardTouchClickDelegate.h"
@interface MCMastorBoard : UIView
-(void)setDataArr:(nonnull NSArray *)dataArr responseClickDelegate:(nullable id<MCCardBoardTouchClickDelegate>)delegate;
/**
 * 滚动视图的contentoffset
 */
-(CGPoint)contentOffset;
@end
