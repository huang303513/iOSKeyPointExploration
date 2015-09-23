//
//  UploadImageTool.h
//  mtNew
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 MYun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MYAPIHeader2 @"http://7xidnq.com1.z0.glb.clouddn.com"

#define qiniutoken @"yPwTOJsk52Ggl3eG_cHngHsdfasdfdfghjtydefgdsfgsdfsghsfghdfs0_MfLCK1bn2pFbdBpoGyzOeeU=:eyJzY29wZSI6ImFwcGltYWdlcyIsImRlYWRsaW5lIjozMjA1OTU4MTE0fQ=="

typedef void(^uploadImageArrayFinishiBlock)(NSArray *imageURLArray);
@interface UploadImageTool : NSObject
-(void)uploadImageDataArray:(NSArray *)imageDataArray complistBlock:(uploadImageArrayFinishiBlock)complistBlock;
@end
