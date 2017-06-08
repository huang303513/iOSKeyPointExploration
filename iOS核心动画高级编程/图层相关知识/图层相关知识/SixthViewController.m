//
//  SixthViewController.m
//  
//
//  Created by maiyun on 15/6/15.
//
//

#import "SixthViewController.h"

@interface SixthViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *layerView1;
@property (weak, nonatomic) IBOutlet UIImageView *layerView2;

@end

@implementation SixthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //设置阴影的水平和竖直大小
    //self.layerView1.layer.shadowOffset = CGSizeMake(0, 15);
    //设置阴影的模糊度
    //self.layerView1.layer.shadowRadius = 1;
    
    //边框阴影透明度
    self.layerView1.layer.shadowOpacity = 0.8f;
    self.layerView2.layer.shadowOpacity = 0.8f;
    
    CGMutablePathRef squarePath = CGPathCreateMutable();
    //一个方形的阴影
    CGPathAddRect(squarePath, NULL, self.layerView1.bounds);
    self.layerView1.layer.shadowPath = squarePath;
    CGPathRelease(squarePath);
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    //一个圆形的阴影
    CGPathAddEllipseInRect(circlePath, NULL, self.layerView2.bounds);
    self.layerView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
    
}



@end
