//
//  AnimationType.h
//  图层相关知识
//
//  Created by 黄成都 on 15/6/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationType : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detailTitle;
-(AnimationType *)initWithTitle:(NSString *)titile detailTitle:(NSString *)detailTitle;

@end
