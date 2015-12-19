//
//  HAIBigPictureView.h
//  大图浏览
//
//  Created by 黄成都 on 15/12/19.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAIBigPictureView : UIView
-(instancetype)initWithBigPictureArray:(NSArray *)pictureArray currentIndex:(NSInteger)currentIndex;

-(void)startLoad;
//-(instancetype)initWithSmallPictureArray(NSArray *)pictureArray;
@end
