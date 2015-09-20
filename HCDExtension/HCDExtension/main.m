//
//  main.m
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#warning 博文参考地址：http://www.jianshu.com/p/d2ecef03f19e

#import <Foundation/Foundation.h>
#import "HCDUser.h"
#import "NSObject+Property.h"
#import "NSObject+HCDKeyValueObject.h"
#import "HCDStatus.h"
#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import "Ad.h"
#import "IDAndDescription.h"
#pragma mark --函数声明
void execute(void (*fun)());
void keyValue2object();
void keyValues2object1();
void keyValues2object2();
void keyValues2object3();
void keyValues2object4();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        
//         NSString *jsonString = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
//        HCDUser *user = [HCDUser objectWithKeyValues:jsonString];
//        
//        NSLog(@"name=%@, icon=%@, age=%zd, height=%@, money=%@, sex=%d, gay=%d", user.name, user.icon, user.age, user.height, user.money, user.sex, user.gay);
        
        
        execute(keyValues2object2);
        
        //execute(keyValues2object3);
        
        //execute(keyValues2object4);
    }
    return 0;
}

void execute(void (*fun)()){
    fun();
    return;
}

/**
 *  复杂的字典 -> 模型 (模型里面包含了模型)
 */
void keyValues2object2()
{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"text" : @"是啊，今天天气确实不错！",
                           @"user" : @{
                                   @"name" : @"Jack",
                                   @"icon" : @"lufy.png"
                                   },
                           @"retweetedHCDStatus" : @{
                                   @"text" : @"今天天气真不错！",
                                   @"user" : @{
                                           @"name" : @"Rose",
                                           @"icon" : @"nami.png"
                                           }
                                   }
                           };
    // 2.将字典转为HCDStatus模型
    HCDStatus *status = [HCDStatus objectWithKeyValues:dict];
    // 3.打印HCDStatus的属性
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *icon = status.user.icon;
    NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    // 4.打印status.retweetedStatus的属性
    NSString *text2 = status.retweetedHCDStatus.text;
    NSString *name2 = status.retweetedHCDStatus.user.name;
    NSString *icon2 = status.retweetedHCDStatus.user.icon;
    NSLog(@"text2=%@, name2=%@, icon2=%@", text2, name2, icon2);
//    2015-09-20 21:07:23.730 HCDExtension[3239:194336] HCDStatus调用了properties方法
//    2015-09-20 21:07:23.731 HCDExtension[3239:194336] HCDUser调用了properties方法
//    2015-09-20 21:07:23.732 HCDExtension[3239:194336] text=是啊，今天天气确实不错！, name=Jack, icon=lufy.png
//    2015-09-20 21:07:23.732 HCDExtension[3239:194336] text2=今天天气真不错！, name2=Rose, icon2=nami.png
}

/**
 *  复杂的字典 -> 模型 (模型的数组属性里面又装着模型)
 */
void keyValues2object3()
{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"}
                                       },
                                   @{
                                       @"text" : @"明天去旅游了",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"}
                                       }
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.小码哥ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.小码哥ad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    
    
    // 2.将字典转为StatusResult模型
    StatusResult *result = [StatusResult objectWithKeyValues:dict];
    
    
    
    // 3.打印StatusResult模型的简单属性
    //NSLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
    
    // 4.打印statuses数组中的模型属性
    for (Status *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        //NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
    for (Ad *ad in result.ads) {
       // NSLog(@"image=%@, url=%@", ad.image, ad.url);
    }
}

void keyValues2object4(){
    
    NSDictionary *dict = @{
                           @"id" : @"Jack",
                           @"description" : @"lufy.png",
                           };
    
    IDAndDescription *result = [IDAndDescription objectWithKeyValues:dict];
    
       // NSLog(@"%@,%@",result.ID,result.Description);
    
}
