//
//  FirstViewController.m
//  
//
//  Created by maiyun on 15/6/15.
//
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self drawHuoChaiRen];
    [self drawJuxin];
}

#pragma mark 画出一个三遍圆角的矩形
-(void)drawJuxin{
    CGRect rect = CGRectMake(50, 150, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight|UIRectCornerBottomRight|UIRectCornerBottomLeft;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    
    //创建一个shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //边框颜色
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //填充颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //边框宽度
    //shapeLayer.lineWidth = 5;
    //接头的模式
    //shapeLayer.lineJoin = kCALineJoinRound;
    //shapeLayer.lineCap = kCALineCapRound;
    //shape layer添加一个路径
    shapeLayer.path = path.CGPath;
    
    [self.containerView.layer addSublayer:shapeLayer];

}


#pragma mark 画出一个火柴人
-(void)drawHuoChaiRen{
    UIBezierPath *path = [[UIBezierPath alloc]init];
    //移动到一个点
    [path moveToPoint:CGPointMake(175, 100)];
    //移动到一个中心点，画圆。。。。
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    //已上面那个点为起点，已下面那个点为终点，画一条线。
    [path addLineToPoint:CGPointMake(150, 175)];
    //画一条横线
    [path addLineToPoint:CGPointMake(125, 225)];
    //移到一个点
    [path moveToPoint:CGPointMake(150, 175)];
    //画出右斜线
    [path addLineToPoint:CGPointMake(175, 225)];
    
    [path moveToPoint:CGPointMake(100, 150)];
    
    [path addLineToPoint:CGPointMake(200, 150)];
    
    
    //创建一个shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //边框颜色
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //填充颜色
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //边框宽度
    shapeLayer.lineWidth = 5;
    //接头的模式
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    //shape layer添加一个路径
    shapeLayer.path = path.CGPath;
    
    [self.containerView.layer addSublayer:shapeLayer];
}


@end
