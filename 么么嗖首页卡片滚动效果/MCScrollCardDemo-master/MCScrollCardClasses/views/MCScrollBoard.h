//
//  MCScrollBoard.h
//  MCScrollCard
//
//  Created by mac on 15/9/15.
//  Copyright © 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCardBoardTouchClickDelegate.h"
typedef NS_ENUM(NSInteger,CardBoardStatus){
    CardBoardNone,
    CardBoardFromLeft = -1,
    CardBoardFromRight = 1
};

@class MCPlanModel;

@protocol MCScrollBoardDelegate <NSObject>
-(void)changeBackgroundImg:(nonnull id)data;

@end

@interface MCScrollBoard : UIScrollView<UIScrollViewDelegate>{
    NSMutableArray *_boards;
    CardBoardStatus _cardBoardStauts;
    UIView      *_srvBoard;         ///<  撑开scrollviewcontentsize
    CGFloat _scrollviewSpeed;
    CGPoint _willScroContentOffset;
    NSInteger _befIndex;
    NSArray<MCPlanModel*> *_dataArr;
}
-(void)setDataArr:(nonnull NSArray<MCPlanModel*> *)dataArr responseClickDelegate:(nullable id<MCCardBoardTouchClickDelegate>)delegate;
@property (nonatomic,assign,nonnull) id<MCScrollBoardDelegate> mdelegate;
@end
