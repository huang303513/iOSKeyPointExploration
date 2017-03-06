//
//  MyView.h
//  Memory Graph解决闭包引用
//
//  Created by huangchengdu on 17/3/6.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^Action)();

@interface MyView : UIView
@property(nonatomic,strong)Action action;
-initWithBlock:(Action)action;
@end
