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
    //[self drawX];
    
    //[self drawRectangle];
    
   // [self drawMutableRectangle];
    
    [self drawRectAtTopOfScreen];
    [self drawRectAtBottowOfScreen];
    
    
//    [self drawRooftopAtTopPointOf:CGPointMake(160.0f, 40.0f) textToDisplay:@"Miter" lineJoin:kCGLineJoinMiter];
//    
//    [self drawRooftopAtTopPointOf:CGPointMake(160.0f, 180.0f) textToDisplay:@"Bevel" lineJoin:kCGLineJoinBevel];
//    
//    [self drawRooftopAtTopPointOf:CGPointMake(160.0f, 320.0f) textToDisplay:@"Round" lineJoin:kCGLineJoinRound];

}

//设置阴影
-(void)drawRectAtTopOfScreen{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect firstRect = CGRectMake(55.0f, 60.0f, 150.0f, 150.0f);
    //把矩形框添加到path
    CGPathAddRect(path, NULL, firstRect);
    //得到当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //保存当前的上下文状态
    CGContextSaveGState(currentContext);
    //设置阴影
    CGContextSetShadowWithColor(currentContext, CGSizeMake(10.0f, 10.0f), 20.0f, [[UIColor grayColor] CGColor]);
    CGContextAddPath(currentContext, path);
    //15012262268
    //设置填充颜色
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    //设置边框颜色
    //[[UIColor brownColor] setStroke];
    //设置line的宽度
   // CGContextSetLineWidth(currentContext, 5.0f);
    CGContextDrawPath(currentContext, kCGPathFill);
    CGPathRelease(path);
    
    //去掉我们对当前上下文的所有设置
    CGContextRestoreGState(currentContext);
}

-(void)drawRectAtBottowOfScreen{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect secondRect = CGRectMake(150.0f, 250.0f, 100.0f, 100.0f);
    //把矩形框添加到path
    CGPathAddRect(path, NULL, secondRect);
    //得到当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置阴影
    //CGContextSetShadowWithColor(currentContext, CGSizeMake(10.0f, 10.0f), 20.0f, [[UIColor grayColor] CGColor]);
    
    
    CGContextAddPath(currentContext, path);
    //15012262268
    //设置填充颜色
    [[UIColor colorWithRed:0.40f green:0.90f blue:0.80f alpha:1.0f] setFill];
    //设置边框颜色
    //[[UIColor brownColor] setStroke];
    //设置line的宽度
    //CGContextSetLineWidth(currentContext, 5.0f);
    CGContextDrawPath(currentContext, kCGPathFill);
    CGPathRelease(path);
}



//绘制矩形
-(void)drawRectangle{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
    //把矩形框添加到path
    CGPathAddRect(path, NULL, rectangle);
    //得到当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    
    CGContextAddPath(currentContext, path);
    //15012262268
    //设置填充颜色
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    //设置边框颜色
    [[UIColor brownColor] setStroke];
    //设置line的宽度
    CGContextSetLineWidth(currentContext, 5.0f);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);
}

//绘制多个矩形
-(void)drawMutableRectangle{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
    CGRect rectangle2 = CGRectMake(40.0f, 100.0f, 90.0f, 300.0f);
    
    CGRect rectamgles[2] = {rectangle,rectangle2};
    
    //把矩形框添加到path
    //CGPathAddRect(path, NULL, rectangle);
    CGPathAddRects(path, NULL,(const CGRect *)&rectamgles, 2);
    //得到当前上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    
    CGContextAddPath(currentContext, path);
    //15012262268
    //设置填充颜色
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    //设置边框颜色
    [[UIColor brownColor] setStroke];
    //设置line的宽度
    CGContextSetLineWidth(currentContext, 5.0f);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    CGPathRelease(path);

}


//绘制X
-(void)drawX{
    //创建一个路径变量
    CGMutablePathRef path = CGPathCreateMutable();
    //
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    //从左上角开始
    CGPathMoveToPoint(path,NULL, screenBounds.origin.x, screenBounds.origin.y);
    //画一条从左上角到右下角的线；
    CGPathAddLineToPoint(path, NULL, screenBounds.size.width, screenBounds.size.height);
    //移动到右上角
    CGPathMoveToPoint(path, NULL, screenBounds.size.width, screenBounds.origin.y);
    //画一条斜线
    CGPathAddLineToPoint(path, NULL, screenBounds.origin.x, screenBounds.size.height);
    //得到path已经画了的上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //把path添加到上下文
    CGContextAddPath(currentContext, path);
    //设置颜色
    [[UIColor blueColor]setStroke];
    //画线
    CGContextDrawPath(currentContext, kCGPathStroke);
    
    CGPathRelease(path);
}

-(void)drawRooftopAtTopPointOf:(CGPoint)paramTopPoint textToDisplay:(NSString *)paramText lineJoin:(CGLineJoin)paramLineJoin{
    
    [[UIColor brownColor] set];
    //得到上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置拐点处的样式
    CGContextSetLineJoin(currentContext, paramLineJoin);
    //设置线条宽度
    CGContextSetLineWidth(currentContext, 20.0f);
    CGContextMoveToPoint(currentContext, paramTopPoint.x - 140, paramTopPoint.y + 100);
    CGContextAddLineToPoint(currentContext, paramTopPoint.x, paramTopPoint.y);
    CGContextAddLineToPoint(currentContext, paramTopPoint.x + 140, paramTopPoint.y + 100);
    CGContextStrokePath(currentContext);
    [[UIColor blackColor]set];
    
    //设置文字
    [paramText drawAtPoint:CGPointMake(paramTopPoint.x - 40.0f, paramTopPoint.y + 60.0f) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:30.0f]}];
    
}

@end
