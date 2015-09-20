//
//  StatusResult.m
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "StatusResult.h"

@implementation StatusResult
/**
 *  用于指定array中的对象类型
 *
 *  @return 返回一个字典。值是对应的类型
 */
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"statuses" : @"Status",//statuses数组里面的类型是Status
             @"ads" : @"Ad"
             };
}
@end
