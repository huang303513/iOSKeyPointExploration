//
//  MyView.m
//  Memory Graph解决闭包引用
//
//  Created by huangchengdu on 17/3/6.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithBlock:(Action)action{
    self = [super init];
    if (self) {
        self.action = action;
    }
    return self;
}

-(void)dealloc{

}

@end
