//
//  SingleTool.h
//  对KeyChain实现数据的增删查改
//
//  Created by huangchengdu on 16/1/14.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#ifndef SingleTool_h
#define SingleTool_h

#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}



#endif /* SingleTool_h */
