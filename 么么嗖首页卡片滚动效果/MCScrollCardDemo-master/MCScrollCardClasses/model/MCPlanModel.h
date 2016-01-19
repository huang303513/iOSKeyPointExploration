//
//  MCPlanModel.h
//  imooc
//
//  Created by mac on 15/9/29.
//  Copyright © 2015年 imooc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *计划 model
 * eg:前端工程师
 */

@interface MCPlanModel : NSObject
/**模型Id**/
@property (nonatomic,assign) NSInteger Id;
/**标题**/
@property (nonatomic,strong,nonnull) NSString * title;
/**求职路线介绍**/
@property (nonatomic,strong,nonnull) NSString * desc;
/**图片**/
@property (nonatomic,strong,nonnull) NSString * img;
/**课程总数**/
@property (nonatomic,assign)         NSInteger        coursenums;
/**学习人数**/
@property (nonatomic,assign)         NSInteger        studynums;
@end
