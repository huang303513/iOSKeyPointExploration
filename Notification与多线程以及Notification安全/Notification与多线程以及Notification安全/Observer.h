//
//  Observer.h
//  Notification与多线程以及Notification安全
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>



@class Poster;
@interface Observer : NSObject
{
    Poster  *_poster;
}

@property (nonatomic, assign) NSInteger i;
@end
