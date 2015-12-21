//
//  ImageControl.m
//  自定义控件的原理以及实现
//
//  Created by huangchengdu on 15/12/21.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import "ImageControl.h"

@implementation ImageControl{
    UILabel *_label;
    UIImageView *_imageView;
}
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;

        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        
        [self addSubview:({
            
            _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
            _imageView.image = image;
            _imageView;
        })];
        
        
        [self addSubview:({
            _label = [[UILabel alloc] initWithFrame:(CGRect){0.0f, height - 30.0f, width, 30.0f}];
            _label.textAlignment = NSTextAlignmentCenter;
            _label.textColor = [UIColor whiteColor];
            _label.text = title;
            _label;
        })];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    return CGRectContainsPoint(bounds, point);
}

/*
对于一个给定的事件，UIControl会调用sendAction:to:forEvent:来将行为消息转发到UIApplication对象，再由UIApplication对象调用其sendAction:to:fromSender:forEvent:方法来将消息分发到指定的target上，而如果我们没有指定target，则会将事件分发到响应链上第一个想处理消息的对象上。而如果子类想监控或修改这种行为的话，则可以重写这个方法。

在我们的实例中，做了个小小的处理，将外部添加的Target-Action放在控件内部来处理事件，因此，我们的代码实现如下：
 */
-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    //自己来处理点击事件
    [super sendAction:@selector(handleAction:) to:self forEvent:event];
}
- (void)handleAction:(id)sender {
    
    NSLog(@"handle Action");
    
    NSLog(@"target-actoin: %@", self.allTargets);
}


- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    
    NSLog(@"Begin %d", self.tracking);
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    
    NSLog(@"Continue %d %@", self.tracking, (self.touchInside ? @"YES" : @"NO"));
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    
    CGPoint position = [touch locationInView:self];
    
    if (CGRectContainsPoint(_label.frame, position)) {
        
        // 在此触发一个UIControlEventTouchUpInside事件行为
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    
    NSLog(@"End %d", self.tracking);
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];
    
    NSLog(@"Cancel");
}

@end
