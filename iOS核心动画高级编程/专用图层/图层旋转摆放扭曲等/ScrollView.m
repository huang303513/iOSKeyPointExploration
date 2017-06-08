//
//  ScrollView.m
//  图层旋转摆放扭曲等
//
//  Created by maiyun on 15/6/24.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ScrollView.h"

@implementation ScrollView


+(nonnull Class)layerClass{
    return [CAScrollLayer class];
}

-(void)setUp{
    self.layer.masksToBounds = YES;
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}


-(nonnull instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib{
    [self setUp];
}

-(void)pan:(UIPanGestureRecognizer *)recognizer{
    CGPoint offset  = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    [recognizer setTranslation:CGPointZero inView:self];
}


@end
