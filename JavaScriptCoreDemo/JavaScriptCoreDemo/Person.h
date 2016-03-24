//
//  Person.h
//  JavaScriptCoreDemo
//
//  Created by huangchengdu on 16/3/24.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@class Person;
@protocol PersonJSExports <JSExport>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property NSInteger ageToday;

- (NSString *)getFullName;

// create and return a new Person instance with `firstName` and `lastName`
+ (instancetype)createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName;
@end

@interface Person : NSObject<PersonJSExports>
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property NSInteger ageToday;
@end
