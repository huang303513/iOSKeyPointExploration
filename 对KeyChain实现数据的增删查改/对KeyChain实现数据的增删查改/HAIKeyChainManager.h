//
//  HAIKeyChainTool.h
//  haitao
//
//  Created by huangchengdu on 16/1/14.
//  Copyright © 2016年 上海市配夸网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingleTool.h"

@interface HAIKeyChainManager : NSObject

singleton_interface(HAIKeyChainManager)

-(BOOL)addKeyChainWithKey:(NSString *)key value:(NSString *)value;
-(BOOL)updateKeyChainWithKey:(NSString *)key value:(NSString *)value;
-(BOOL)deleteKeyChainWithKey:(NSString *)key;
-(id)getKeyChainValueWithKey:(NSString *)key;
@end
