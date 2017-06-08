//
//  ViewController.m
//  把图片裁剪成小图片用CATiledLayer加载
//
//  Created by yifan on 15/8/31.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CATiledLayer *tileLayer = [CATiledLayer layer];
    tileLayer.frame = CGRectMake(0, 0, 2048, 2048);
    tileLayer.delegate = self;
    [self.scrollView.layer addSublayer:tileLayer];
    self.scrollView.contentSize = tileLayer.frame.size;
    tileLayer.contentsScale = [UIScreen mainScreen].scale;
    //draw layer
    [tileLayer setNeedsDisplay];
    
}

#pragma mark 代理方法
-(void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    CGFloat scale = [UIScreen mainScreen].scale;
    NSInteger x = floor(bounds.origin.x / layer.tileSize.width * scale);
    NSInteger y = floor(bounds.origin.y / layer.tileSize.height * scale);
    
    NSString *imageName = [NSString stringWithFormat: @"Snowman_%02li_%02li", (long)x, (long)y];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *tileImage = [UIImage imageWithContentsOfFile:imagePath];
    
    //draw tile
    UIGraphicsPushContext(ctx);
    [tileImage drawInRect:bounds];
    UIGraphicsPopContext();
    
}

- (IBAction)cutPicture:(id)sender {
    
}

- (IBAction)loadPictureSlip:(id)sender {
}

@end
