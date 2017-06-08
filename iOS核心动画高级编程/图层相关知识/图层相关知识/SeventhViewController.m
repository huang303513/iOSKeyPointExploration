//
//  SeventhViewController.m
//  
//
//  Created by maiyun on 15/6/15.
//
//

#import "SeventhViewController.h"

@interface SeventhViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SeventhViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageView.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"Cone.png"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    //mask指定了父layer的可见区域
    self.imageView.layer.mask = maskLayer;
    
}


@end
