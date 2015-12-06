//
//  CustomLayer.m
//  CALayer 和 UIView的区别和联系
//
//  Created by 黄成都 on 15/12/6.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer
+ (Class)layerClass
{
    NSLog(@"CustomLayer(Class)layerClass");
    return [CustomLayer class];
}

- (void)setFrame:(CGRect)frame
{
    NSLog(@"CustomLayersetFrame:(CGRect)frame");
    [super setFrame:frame];
}

- (void)setPosition:(CGPoint)position
{
    NSLog(@"CustomLayersetPosition:(CGPoint)position");
    [super setPosition:position];
}

- (void)setBounds:(CGRect)bounds
{
    NSLog(@"CustomLayersetBounds:(CGRect)bounds");
    [super setBounds:bounds];
}
@end
