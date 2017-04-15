//
//  ViewController.m
//  UIViewController和UIView生命周期加载和卸载
//
//  Created by huangchengdu on 17/4/14.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import "XibView.h"
#import "CodeView.h"
#import "XIBViewController.h"
#import "SBViewController.h"
#import "CodeViewController.h"
#import "CoderViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)loadControllerFromXIB:(id)sender {
    XIBViewController *xibVC = [[XIBViewController alloc]initWithNibName:@"XIBViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:xibVC animated:YES];
}


- (IBAction)laodControllerFromSB:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]];
    SBViewController *sbVC = [sb instantiateViewControllerWithIdentifier:@"SBViewController"];
    [self.navigationController pushViewController:sbVC animated:YES];
}

- (IBAction)loadControllerFromCoder:(id)sender {
    CoderViewController *coderVC = [[CoderViewController alloc]initWithCoder:nil];
    [self.navigationController pushViewController:coderVC animated:YES];
}


- (IBAction)loadControllerWithNone:(id)sender {
    CodeViewController *codeVC = [[CodeViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:codeVC animated:YES];
    
}

- (IBAction)loadViewFromXib:(id)sender {
    XibView *xibView = [[[NSBundle mainBundle]loadNibNamed:@"XIBView" owner:self options:nil] lastObject];
    [self.view addSubview:xibView];
}


- (IBAction)loadViewWithNone:(id)sender {
    CodeView *codeView = [[CodeView alloc]init];
    codeView.backgroundColor = [UIColor greenColor];
    codeView.frame = CGRectMake(0, 500, 100, 50);
    [self.view addSubview:codeView];
}





@end
