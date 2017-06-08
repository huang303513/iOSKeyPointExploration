//
//  ViewController.m
//  HCDWaveLoadingView
//
//  Created by 黄成都 on 16/3/13.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "WaveLoadingView.h"
@interface ViewController ()
//波浪视图
@property (weak, nonatomic) IBOutlet WaveLoadingView *waveLoadingView;
//进度条
@property (weak, nonatomic) IBOutlet UISlider *progressSliderBar;

@property (weak, nonatomic) IBOutlet UISlider *amplitudeSliderBar;
@property (weak, nonatomic) IBOutlet UISlider *borderWidthSliderBar;

@property (weak, nonatomic) IBOutlet UIButton *isShowTipButton;
@property (weak, nonatomic) IBOutlet UIButton *changeShapeButton;
@property (weak, nonatomic) IBOutlet UIButton *exampleButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShowTipButton.layer.cornerRadius = self.isShowTipButton.bounds.size.height/2;
    self.isShowTipButton.layer.masksToBounds = true;
    self.changeShapeButton.layer.cornerRadius = self.changeShapeButton.bounds.size.height/2;
    self.changeShapeButton.layer.masksToBounds = true;
    self.exampleButton.layer.cornerRadius = self.exampleButton.bounds.size.height/2;
    self.exampleButton.layer.masksToBounds = true;
    
    
    
}
#pragma mark 是否显示tip的按钮
- (IBAction)clickIsShowTipButton:(UIButton *)sender {
    
    
}
#pragma mark 改变形状的按钮
- (IBAction)clickChangeShapeButton:(UIButton *)sender {
    
    
}
#pragma mark 点击example按钮
- (IBAction)clickExampleButton:(UIButton *)sender {
    
    
}

@end
