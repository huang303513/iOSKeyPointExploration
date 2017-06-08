//
//  FiveViewController.m
//  
//
//  Created by maiyun on 15/6/24.
//
//

#import "FiveViewController.h"

@interface FiveViewController ()
@property (weak, nonatomic) IBOutlet UILabel *containerView;

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    
    
}


@end
