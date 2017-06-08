//
//  GraphicsViewControllerView.m
//  
//
//  Created by maiyun on 15/6/16.
//
//

#import "GraphicsViewControllerView.h"

@implementation GraphicsViewControllerView

-(instancetype)init{
    self = [super init];
    if (self) {
        //self.backgroundColor = [UIColor greenColor];
    }
    return self;
}



-(void)drawRect:(CGRect)rect{
    
    //===========把一张图片绘制到屏幕上===================
    //UIImage *xcodeIcon = [UIImage imageNamed:@"Xcode.png"];
//    //按照原始大小在给定的点绘制图片
//    [xcodeIcon drawAtPoint:CGPointMake(0.0f, 20.0f)];
//    //在给定的区域内绘制图像
//    [xcodeIcon drawInRect:CGRectMake(50.0f, 10.0f, 40.0f, 35.0f)];
    //=============在屏幕上绘制一条线============================
    [[UIColor brownColor] set];
    //得到当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置会线条的宽度
    CGContextSetLineWidth(currentContext, 5.0f);
    //指定起点
    CGContextMoveToPoint(currentContext, 50.0f, 10.0f);
    //绘制一条线，以参数为重点
    CGContextAddLineToPoint(currentContext, 100.0f, 200.0f);
    //绘制第二条线
    CGContextAddLineToPoint(currentContext, 300.0f, 100.0f);
    
    
    //通过上下文绘制
    CGContextStrokePath(currentContext);
    
    //=======================================================
    
    
    //=============在屏幕上的40 180这个点上绘制一个字符串;
//    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0];
//    NSString *myString1 = @"Some String 1";
//    UIColor *magentaColor = [UIColor redColor];
//    //把这个颜色设置为当前绘图的上下文中。
//    [magentaColor set];
//    [myString1 drawAtPoint:CGPointMake(40, 180) withFont:helveticaBold];
    
    //=========================================================
//    NSString *myString2 = @"Some String 2";
//    
//    NSDictionary *drawDic = @{
//                              NSFontAttributeName:helveticaBold,
//                              NSForegroundColorAttributeName:[UIColor greenColor]
//                              };
//    //把文字绘制到屏幕上
//    [myString2 drawAtPoint:CGPointMake(40, 250) withAttributes:drawDic];
    
    //=============================================================
//    UIFont *helveticaBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0];
//    NSString *myString1 = @"I learn Really Fast";
//    UIColor *magentaColor = [UIColor redColor];
//    //把这个颜色设置为当前绘图的上下文中。
//    [magentaColor set];
//    NSDictionary *drawDic = @{
//                              NSFontAttributeName:helveticaBold
//                              };
//    [myString1 drawInRect:CGRectMake(100, 120, 100, 200) withAttributes:drawDic];
//
//    [self getColorCompount];
}


//-(void)getColorCompount{
//    UIColor *steelBlueColor = [UIColor colorWithRed:0.3f green:0.4f blue:0.6f alpha:1.0f];
//    CGColorRef colorRef = [steelBlueColor CGColor];
//    //获取颜色对象的各个分量
//    const CGFloat *components = CGColorGetComponents(colorRef);
//    //得到组成部分的个数
//    NSUInteger componentsCount = CGColorGetNumberOfComponents(colorRef);
//    NSUInteger counter = 0;
//    for (counter = 0; counter < componentsCount; counter++) {
//        NSLog(@"compnnent %u = %.02f",counter + 1,components[counter]);
//    }
//}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
