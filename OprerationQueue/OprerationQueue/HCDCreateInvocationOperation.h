//
//  HCDCreateInvocationOperation.h
//  OprerationQueue
//
//  Created by 黄成都 on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDCreateInvocationOperation : NSObject
- (NSInvocationOperation *)invocationOperationWithData:(id)data;
- (NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInPut;
@end
