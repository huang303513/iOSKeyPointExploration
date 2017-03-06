//
//  ViewController.m
//  Memory Graph解决闭包引用
//
//  Created by huangchengdu on 17/3/6.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
@interface ViewController ()
@property(nonatomic,strong)MyView *myview;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

//#define normaltype false

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    //使用weakself和self看不同情况
    self.myview = [[MyView alloc]initWithBlock:^{
        //主要是防止block延迟执行的时候，self已经被卸载导致crash。
    
#ifdef normaltype
    if (!weakSelf) {
        return;
    }
    //主要是防止self执行过程中被卸载引起奔溃。具体查看appdelegate的warming链接
    __strong typeof(weakSelf) strongSelf = weakSelf;
    [strongSelf testMethod];
#else
        [self testMethod];
#endif

    }];
}

- (IBAction)changeTitle:(id)sender {
    self.myview.action();
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.myview.action();
//    });

}


-(void)testMethod{
    NSLog(@"sdfsdfsdf");
    self.label.text = @"哈哈";
}

-(void)dealloc{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
