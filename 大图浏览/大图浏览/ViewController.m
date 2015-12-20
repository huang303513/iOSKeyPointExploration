//
//  ViewController.m
//  大图浏览
//
//  Created by 黄成都 on 15/12/19.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "HAIBigPictureView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)clickButton:(id)sender {
    NSArray *advertiseArray = [NSArray arrayWithObjects:
        @"http://image.peikua.com/static/upload/pic/f/1/20150720171206456734978_190.jpg",
        @"http://image.peikua.com/static/upload/pic/0/d/20150725181355199109982.png",
        @"http://image.peikua.com/static/upload/pic/6/2/20150720135414910343724_190.jpg",
        @"http://image.peikua.com/static/upload/pic/2/b/20150720133200303994798_80.jpg",
        @"http://image.peikua.com/static/upload/pic/e/0/20150820172558775366229.png",nil];
    HAIBigPictureView *pictureView = [[HAIBigPictureView alloc]initWithBigPictureArray:advertiseArray currentIndex:3];
    [pictureView startLoad];
    
}

- (IBAction)clickMutablePictureArray:(id)sender {
   // NSArray *smallTitleArray = [NSArray arrayWithObjects:@"红色",@"蓝色",@"绿色",@"蓝色",@"棕色", nil];
    
    NSArray *smallImageArray = [NSArray arrayWithObjects:
        @"http://image.peikua.com/static/upload/pic/f/1/20150720171206456734978_190.jpg",
        @"http://image.peikua.com/static/upload/pic/0/d/20150725181355199109982.png",
        @"http://image.peikua.com/static/upload/pic/6/2/20150720135414910343724_190.jpg",
        @"http://image.peikua.com/static/upload/pic/2/b/20150720133200303994798_80.jpg",
        @"http://image.peikua.com/static/upload/pic/e/0/20150820172558775366229.png",nil];
    NSArray *bigImageArray = [NSArray arrayWithObjects:smallImageArray,smallImageArray,smallImageArray,smallImageArray,smallImageArray, nil];
    HAIBigPictureView *pictureView = [[HAIBigPictureView alloc]initWithSmallPictureArray:smallImageArray bigPictrueArray:bigImageArray currentIndex:3 smallIndex:0];
    [pictureView startLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
