//
//  NSObject+Associate2.m
//  Category添加属性的三种实现
//
//  Created by 黄成都 on 16/3/12.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import "NSObject+Associate2.h"
#import <objc/runtime.h>
@implementation NSObject (Associate2)
static char const *phoneKey;

-(void)setPhone:(NSString *)phone{
    objc_setAssociatedObject(self,phoneKey,phone,OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)phone{
    return objc_getAssociatedObject(self, phoneKey);
}
@end


