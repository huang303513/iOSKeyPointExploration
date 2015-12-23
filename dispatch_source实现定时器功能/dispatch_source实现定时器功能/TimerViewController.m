//
//  TimerViewController.m
//  dispatch_source实现定时器功能
//
//  Created by huangchengdu on 15/12/23.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import "TimerViewController.h"
#import "HCDTimer.h"
@interface TimerViewController ()
@property(nonatomic,strong)HCDTimer *timer;
@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakself = self;
    self.timer = [HCDTimer repeatingTimerWithTimeInterval:2 block:^{
        NSLog(@"定时器执行");
        weakself.view.backgroundColor = [UIColor greenColor];
    }];
    
}


-(void)dealloc{
    NSLog(@"定时器控制器被卸载了");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
