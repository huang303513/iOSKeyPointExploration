//
//  HAIKeyChainTool.m
//  haitao
//
//  Created by huangchengdu on 16/1/14.
//  Copyright © 2016年 上海市配夸网络科技有限公司. All rights reserved.
//

#import "HAIKeyChainManager.h"

@implementation HAIKeyChainManager

singleton_implementation(HAIKeyChainManager)

-(BOOL)addKeyChainWithKey:(NSString *)key value:(NSString *)value{
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *secItem = @{
                              (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                              (__bridge id)kSecAttrService : service,
                              (__bridge id)kSecAttrAccount : key,
                              (__bridge id)kSecValueData : valueData,
                              };
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)secItem, &result);
    
    if (status == errSecSuccess){
        NSLog(@"添加成功：%@---%@",key,value);
        return true;
        
    } else {
        NSLog(@"添加失败");
        return false;
        
    }
    return false;

}
-(BOOL)deleteKeyChainWithKey:(NSString *)key{

    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : service,
                            (__bridge id)kSecAttrAccount : key
                            };
    
    OSStatus foundExisting =
    SecItemCopyMatching((__bridge CFDictionaryRef)query, NULL);
    
    if (foundExisting == errSecSuccess){
        OSStatus deleted = SecItemDelete((__bridge CFDictionaryRef)query);
        if (deleted == errSecSuccess){
             NSLog(@"删除成功：%@",key);
            true;
            //NSLog(@"Successfully deleted the item");
        } else {
            NSLog(@"删除失败");
            false;
            //NSLog(@"Failed to delete the item.");
        }
    } else {
        NSLog(@"删除失败");
        false;
        //NSLog(@"Did not find the existing value.");
    }

    
    
    return false;
}


-(BOOL)updateKeyChainWithKey:(NSString *)key value:(NSString *)value{
    
    
    NSString *keyToSearchFor = key;
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : service,
                            (__bridge id)kSecAttrAccount : keyToSearchFor,
                            };
    
    OSStatus found = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                         NULL);
    
    if (found == errSecSuccess){
        
        NSData *newData = [value
                           dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *update = @{
                                 (__bridge id)kSecValueData : newData,
                                 (__bridge id)kSecAttrComment : keyToSearchFor,
                                 };
        
        OSStatus updated = SecItemUpdate((__bridge CFDictionaryRef)query,
                                         (__bridge CFDictionaryRef)update);
        
        if (updated == errSecSuccess){
            NSLog(@"更新成功.新值是：");
            [self getKeyChainValueWithKey:key];
            return true;
           // [self readExistingValue];
        } else {
            NSLog(@"更新失败");
            return false;
            //NSLog(@"Failed to update the value. Error = %ld", (long)updated);
        }
        
        
    } else {
        NSLog(@"更新失败");
        return false;
        //NSLog(@"Error happened with code: %ld", (long)found);
    }

    
    
    
    return true;
}

-(id)getKeyChainValueWithKey:(NSString *)key{
    
    NSString *keyToSearchFor = key;
    NSString *service = [[NSBundle mainBundle] bundleIdentifier];
    
    NSDictionary *query = @{
                            (__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrService : service,
                            (__bridge id)kSecAttrAccount : keyToSearchFor,
                            (__bridge id)kSecReturnData : (__bridge id)kCFBooleanTrue,
                            (__bridge id)kSecMatchLimit : (__bridge id)kSecMatchLimitAll
                            };
    
    CFArrayRef allCfMatches = NULL;
    OSStatus results = SecItemCopyMatching((__bridge CFDictionaryRef)query,
                                           (CFTypeRef *)&allCfMatches);
    
    if (results == errSecSuccess){
        
        NSArray *allMatches = (__bridge_transfer NSArray *)allCfMatches;
        
        for (NSData *itemData in allMatches){
            NSString *value = [[NSString alloc]
                               initWithData:itemData
                               encoding:NSUTF8StringEncoding];
            NSLog(@"获取成：%@-- %@",key, value);
            return value;
        }
        
    } else {
        NSLog(@"获取失败");
        return nil;
        //NSLog(@"Error happened with code: %ld", (long)results);
    }
    return nil;
}
@end
