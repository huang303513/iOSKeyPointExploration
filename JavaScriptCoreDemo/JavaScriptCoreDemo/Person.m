//
//  Person.m
//  JavaScriptCoreDemo
//
//  Created by huangchengdu on 16/3/24.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#import "Person.h"

@implementation Person
- (NSString *)getFullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

+ (instancetype) createWithFirstName:(NSString *)firstName lastName:(NSString *)lastName {
    Person *person = [[Person alloc] init];
    person.firstName = firstName;
    person.lastName = lastName;
    return person;
}
@end
