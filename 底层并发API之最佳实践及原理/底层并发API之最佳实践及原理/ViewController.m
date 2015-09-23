//
//  ViewController.m
//  底层并发API之最佳实践及原理
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "UploadImageTool.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)mutablePictrueAsyncUpload:(id)sender {
    
    UploadImageTool *tool = [[UploadImageTool alloc]init];
    
    NSString *path   = [[NSBundle mainBundle] pathForResource:@"sold_out.png" ofType:nil];
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];
    [array addObject:imageData];

    //__weak typeof(self) weakself = self;
    //上传多张图片、全部上传成功以后返回回调地址
    //请先把UploadImageTool中用到的token改为你自己的token。否则不能成功上传图片
    [tool uploadImageDataArray:array complistBlock:^(NSArray *imageURLArray) {
        NSLog(@"%@",imageURLArray);
        //[weakself  doUpload:imageURLArray];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
