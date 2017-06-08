//
//  EightViewController.m
//  图层旋转摆放扭曲等
//
//  Created by maiyun on 15/6/24.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "EightViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface EightViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation EightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *str = [@"http://www.hytvu.com.cn/Public/Uploads/video/1409326789.mp4" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Ship" withExtension:@"mp4"];
    
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playerLayer];
    
    [player play];
    
    
}



@end
