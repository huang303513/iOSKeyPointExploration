//
//  FifthViewController.m
//  图层相关知识
//
//  Created by maiyun on 15/6/15.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "FifthViewController.h"

@interface FifthViewController ()
@property(nonatomic,strong)UIView *layerView;
@property(nonatomic,strong)CALayer *blueLayer;
@end

@implementation FifthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    UIView *layerView = [[UIView alloc]init];
    layerView.backgroundColor = [UIColor whiteColor];
    layerView.bounds = CGRectMake(0, 0, 200, 200);
    layerView.center = self.view.center;
    [self.view addSubview:layerView];
    self.layerView = layerView;


    self.blueLayer = [CALayer layer];
    self.blueLayer.frame = CGRectMake(50, 50, 100, 100);
    self.blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.blueLayer];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //转换到白色视图上的位置
//    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
//    if ([self.layerView.layer containsPoint:point]) {
//        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
//        if ([self.blueLayer containsPoint:point]) {
//            [[[UIAlertView alloc]initWithTitle:@"inside blue layer" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
//        }else{
//            [[[UIAlertView alloc]initWithTitle:@"inside white layer" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
//        }
//    }
    
    //======================通过hitTest来实现=============================
    CALayer *layer = [self.layerView.layer hitTest:point];
    if (layer == self.blueLayer) {
        [[[UIAlertView alloc]initWithTitle:@"绿色" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    }else if(layer == self.layerView.layer){
        [[[UIAlertView alloc]initWithTitle:@"白色" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    }

}








@end
