//
//  UIImageView+HCDWebCache.h
//  Cell异步图片加载优化、缓存机制详解
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^downImageBlock)(UIImage *image);

@interface UIImageView (HCDWebCache)

-(void)downImageWithString:(NSString *)string placeHolder:(UIImage *)laceHolder complete:(downImageBlock)complete;
@end
