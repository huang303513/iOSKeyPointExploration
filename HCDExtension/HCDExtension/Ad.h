//
//  Ad.h
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ad : NSObject
/** 广告图片 */
@property (copy, nonatomic) NSString *image;
/** 广告url */
@property (strong, nonatomic) NSURL *url;
@end
