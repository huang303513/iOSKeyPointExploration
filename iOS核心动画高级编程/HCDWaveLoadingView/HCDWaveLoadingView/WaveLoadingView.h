//
//  WaveLoadingView.h
//  HCDWaveLoadingView
//
//  Created by 黄成都 on 16/3/13.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import <UIKit/UIKit.h>

static double π = M_PI;

typedef NS_OPTIONS(NSUInteger, ShapeModel){
    shapeModelCircle,
    shapeModelRect
};

@interface WaveLoadingView : UIView
//X坐标起点, the x origin of wave
@property(nonatomic,assign)CGFloat originX;
//波幅最小值
@property(nonatomic,assign)CGFloat amplitude_min;
//波幅可调节幅度
@property(nonatomic,assign)CGFloat amplitude_span;
//循环次数, num of circulation
@property(nonatomic,assign)CGFloat cycle;
//周期（在代码中重新计算）, recalculate in layoutSubviews
@property(nonatomic,assign)CGFloat term;



@end
