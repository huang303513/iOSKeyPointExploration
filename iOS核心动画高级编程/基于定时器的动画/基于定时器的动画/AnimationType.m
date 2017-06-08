//
//  AnimationType.m
//  图层相关知识
//
//  Created by 黄成都 on 15/6/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "AnimationType.h"

@implementation AnimationType
-(AnimationType *)initWithTitle:(NSString *)titile detailTitle:(NSString *)detailTitle{
    self = [super init];
    if (self) {
        self.title = titile;
        self.detailTitle = detailTitle;
    }
    return self;
}
@end
