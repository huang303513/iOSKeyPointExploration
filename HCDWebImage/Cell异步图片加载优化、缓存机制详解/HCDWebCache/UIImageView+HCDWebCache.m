//
//  UIImageView+HCDWebCache.m
//  Cell异步图片加载优化、缓存机制详解
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "UIImageView+HCDWebCache.h"
#import "HCDImageManager.h"
#import "WebImageDecoder.h"
#define HCDImageCacheFile(url) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]]

@implementation UIImageView (HCDWebCache)
-(void)downImageWithString:(NSString *)string placeHolder:(UIImage *)laceHolder complete:(downImageBlock)complete{
    NSURL *picurl;
    if ([string isKindOfClass:[NSURL class]]) {
        picurl = (NSURL *)string;
    }else if([string isKindOfClass:[NSString class]] || [string isMemberOfClass:[NSString class]]){
        picurl = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }else{
        picurl = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    HCDImageManager *manager = [HCDImageManager sharedManager];
    UIImage *cachedImage = [manager.images objectForKey:picurl];
    if (cachedImage) {//内存中有缓存
         self.image = cachedImage;
        complete(cachedImage);
        NSLog(@"内存缓存找到了");
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *filePath = HCDImageCacheFile(picurl);
            UIImage *fileImage = [UIImage imageWithContentsOfFile:filePath];
            if (fileImage) { // 本地磁盘缓存中有图片
                UIImage *decodedImage = [UIImage decodedImageWithImage:fileImage];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [manager.images setObject:decodedImage forKey:picurl];
                    complete(decodedImage);
                    NSLog(@"磁盘缓存找到了");
                });
            }else{//从网络下载
                self.image = laceHolder;//显示站位图
                //到子线程执行下载操作
                //取出当前URL对应的下载下载操作
                NSBlockOperation *operation = manager.operations[picurl];
                __weak typeof(self) weakSelf = self;
                if (nil == operation) {
                    if (!weakSelf) {
                        return;
                    }
                    NSLog(@"从网络加载");
                    operation = [NSBlockOperation blockOperationWithBlock:^{
                        NSData* data =  [NSData dataWithContentsOfURL:picurl];
                        UIImage* netimage = [UIImage imageWithData:data];
                        netimage = [UIImage decodedImageWithImage:netimage];
                        
                        //回到主线程刷新表格
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            
                            // 从字典中移除下载操作 (防止operations越来越大，保证下载失败后，能重新下载)
                            [manager.operations removeObjectForKey:picurl];
                            if (!weakSelf) {
                                return;
                            }
                            weakSelf.image = netimage;
                            complete(netimage);
                        }];
                        
                        //下载完成的图片放入缓存字典中
                        if (netimage) { //防止下载失败为空赋值造成崩溃
                            [manager.images setObject:netimage forKey:picurl];
                            //下载完成的图片存入沙盒中
                            [data writeToFile:HCDImageCacheFile(picurl) atomically:YES];
                        }

                    }];
                    //添加操作到队列中
                    [manager.queue addOperation:operation];
                    //添加到字典中
                    manager.operations[picurl] = operation;
                    
                }
            }

        });
    }
}
@end
