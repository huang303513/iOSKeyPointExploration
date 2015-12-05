//
//  ViewController.m
//  自定义并发Operation实现对大文件的下载
//
//  Created by 黄成都 on 15/12/5.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#warning 参考博客地址：http://www.jianshu.com/p/ebb3e42049fd

#import "ViewController.h"
#import "HCDHttpDownOperation.h"

NSString * const URL_STRING = @"http://sanjosetransit.com/extras/SJTransit_Icons.zip";

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property(nonatomic,strong)HCDHttpDownOperation *operationOne;

@property(nonatomic,strong)HCDHttpDownOperation *operationTwo;

@property (weak, nonatomic) IBOutlet UIProgressView *progressViewOne;
@property (weak, nonatomic) IBOutlet UIProgressView *progressViewTwo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 3;

    self.progressViewOne.progress = 0.f;
    self.progressViewTwo.progress = 0.f;
}


- (IBAction)clickDownLoad1:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"down1"]) {
        [sender setTitle:@"Cancel" forState:UIControlStateNormal];
        self.progressViewOne.progress = 0.f;
        
        NSURL *URL = [NSURL URLWithString:URL_STRING];
        self.operationOne = [[HCDHttpDownOperation alloc] initWithRequestURL:URL progress:^(float percent) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressViewOne.progress = percent;
            });
        } completion:^(id response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"down1" forState:UIControlStateNormal];
                if (error) self.progressViewOne.progress = 0.f;
            });
        }];
        
        
        [self.operationQueue addOperation:self.operationOne];
        [self.operationQueue addOperationWithBlock:^{
            NSLog(@"next operation 1");
        }];
    }
    else {
        [sender setTitle:@"down1" forState:UIControlStateNormal];
        self.progressViewOne.progress = 0.f;
        [self.operationOne cancel];
    }

    
}
- (IBAction)clickDownLoad2:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"down2"]) {
        [sender setTitle:@"Cancel" forState:UIControlStateNormal];
        self.progressViewTwo.progress = 0.f;
        
        NSURL *URL = [NSURL URLWithString:URL_STRING];
        self.operationTwo = [[HCDHttpDownOperation alloc] initWithRequestURL:URL progress:^(float percent) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.progressViewTwo.progress = percent;
            });
        } completion:^(id response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"down2" forState:UIControlStateNormal];
                if (error) self.progressViewTwo.progress = 0.f;
            });
        }];
        
        
        [self.operationQueue addOperation:self.operationTwo];
        [self.operationQueue addOperationWithBlock:^{
            NSLog(@"next operation 2");
        }];
    }
    else {
        [sender setTitle:@"down2" forState:UIControlStateNormal];
        self.progressViewTwo.progress = 0.f;
        [self.operationTwo cancel];
    }

    
}




@end
