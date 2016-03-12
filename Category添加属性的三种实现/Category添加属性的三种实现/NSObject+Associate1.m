//
//  NSObject+Associate1.m
//  Category添加属性的三种实现
//
//  Created by 黄成都 on 16/3/12.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import "NSObject+Associate1.h"
#import <UIKit/UIKit.h>
@implementation NSObject (Associate1)
static NSMutableDictionary *_dic;
static NSString *const addressID = @"addressID";

+(void)load{
    _dic = [NSMutableDictionary dictionary];
}

-(void)setAddress:(NSString *)address{
    [_dic setObject:address forKey:addressID];
}
-(NSString *)address{
    return [_dic objectForKey:addressID];
}
@end
