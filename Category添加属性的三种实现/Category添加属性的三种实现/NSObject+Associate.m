//
//  NSObject+Associate.m
//  Category添加属性的三种实现
//
//  Created by 黄成都 on 16/3/12.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import "NSObject+Associate.h"
#import <UIKit/UIKit.h>
@implementation NSObject (Associat)
static NSString *_name = nil;
-(void)setName:(NSString *)name{
    if (_name != name) {
        _name = [name copy];
    }
}
-(NSString *)name{
    return _name;
}
@end
