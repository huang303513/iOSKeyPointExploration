//
//  MCCardBoard.h
//  MCScrollCard
//
//  Created by mac on 15/9/15.
//  Copyright © 2015年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCCardBoardTouchClickDelegate.h"
@interface MCCardBoard : UIView
@property (nonatomic,strong,nonnull) id model;
-(void)onShow;
-(void)changeHeightWithPadding:(float)padding;
-(void)normal;
@property (nonatomic,assign,nonnull) id<MCCardBoardTouchClickDelegate> delegate;

/**
 * 更新主题名称
 */
-(void)updateTitle:(nullable NSString *)title;

/**
 * 更新课程总数
 */
-(void)updateCourseNumsWithCoursNum:(nullable NSString*)coursNumStr;

/**
 * 更新课程学习人数
 */
-(void)updateStudyNumsWithStudyNumStr:(nullable NSString*)studyNumStr;

/**
 * 更新主题主图
 */
-(void)updateImgWithImgStr:(nullable NSString*)imgUrl;
@end
