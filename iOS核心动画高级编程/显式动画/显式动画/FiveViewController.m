//
//  FiveViewController.m
//  
//
//  Created by maiyun on 15/6/26.
//
//

#import "FiveViewController.h"
#import "FiveTest1ViewController.h"
#import "FiveTest2ViewController.h"

@interface FiveViewController ()<UITabBarControllerDelegate>

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *fourVC  = [[FiveTest1ViewController alloc]init];
    UIViewController *fiveVC = [[FiveTest2ViewController alloc]init];
    self.viewControllers = @[fourVC,fiveVC];
    self.delegate = self;
    
    
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    CATransition *transtion = [CATransition animation];
    transtion.type = kCATransitionFade;
    [self.tabBarController.view.layer addAnimation:transtion forKey:nil];
}

@end
