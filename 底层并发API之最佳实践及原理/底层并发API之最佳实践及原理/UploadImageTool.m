//
//  UploadImageTool.m
//  mtNew
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 MYun. All rights reserved.
//

#import "UploadImageTool.h"
#import "QNUploadManager.h"



@implementation UploadImageTool

-(void)uploadImageDataArray:(NSArray *)imageDataArray complistBlock:(uploadImageArrayFinishiBlock)complistBlock{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queque = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSMutableArray *pathArray = [NSMutableArray array];
    for (NSData *data in imageDataArray) {
        dispatch_group_async(group, queque, ^{
            QNUploadManager *upManager = [[QNUploadManager alloc] init];
            NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", [self getDateTimeString], [self randomStringWithLength:8]];
            __block NSString *path;
            [upManager putData:data key:fileName
                         token:qiniutoken
                      complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                          path = resp[@"key"];
                          NSString *imagepath = [NSString stringWithFormat:@"%@/%@",MYAPIHeader2,path];
                          [pathArray addObject:imagepath];
                          NSLog(@"上传完了一个：%@",imagepath);
                          dispatch_group_leave(group);
                      }option:nil];
        });
        NSLog(@"开始上传");
        dispatch_group_enter(group);
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部上传完毕");
        complistBlock(pathArray);
    });
   
}


- (NSString *)getDateTimeString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}


- (NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

@end
