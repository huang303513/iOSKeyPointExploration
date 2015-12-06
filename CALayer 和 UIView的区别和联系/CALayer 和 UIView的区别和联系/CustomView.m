//
//  CustomView.m
//  CALayer 和 UIView的区别和联系
//
//  Created by 黄成都 on 15/12/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "CustomView.h"
#import "CustomLayer.h"

@implementation CustomView

-(instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"CustomView init");
    }
    return self;
}

+ (Class)layerClass
{
    NSLog(@"(Class)layerClass");
    return [CustomLayer class];
}

- (void)setFrame:(CGRect)frame
{
     NSLog(@"setFrame:(CGRect)frame");
    [super setFrame:frame];
}

- (void)setCenter:(CGPoint)center
{
     NSLog(@"setCenter:(CGPoint)center");
    [super setCenter:center];
}

- (void)setBounds:(CGRect)bounds
{
     NSLog(@"setBounds:(CGRect)bounds");
    [super setBounds:bounds];
}

@end
