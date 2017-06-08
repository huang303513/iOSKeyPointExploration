//
//  MainViewControllerView.m
//  
//
//  Created by maiyun on 15/6/17.
//
//

#import "MainViewControllerView.h"

@implementation MainViewControllerView


-(void)drawRect:(CGRect)rect{
    //[self pingyiView];
    //[self suofangView];
    [self xuanzhuanView];
}

//平移视图
-(void)pingyiView{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
    //移动视图
    CGAffineTransform transform = CGAffineTransformMakeTranslation(100.0f, 0.0f);
    
    CGPathAddRect(path, &transform, rectangle);
    
    CGContextRef curremtCpmtext = UIGraphicsGetCurrentContext();
    CGContextAddPath(curremtCpmtext, path);
    
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    
    [[UIColor brownColor] setStroke];
    
    CGContextSetLineWidth(curremtCpmtext, 5.0f);
    
    CGContextDrawPath(curremtCpmtext, kCGPathFillStroke);
    
    CGPathRelease(path);
}

//缩放视图
-(void)suofangView{
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
//    CGPathAddRect(path, NULL, rectangle);
//    
//    CGContextRef curremtCpmtext = UIGraphicsGetCurrentContext();
//    CGContextScaleCTM(curremtCpmtext, 0.5f, 0.5f);
//    CGContextAddPath(curremtCpmtext, path);
//    
//    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
//    
//    [[UIColor brownColor] setStroke];
//    
//    CGContextSetLineWidth(curremtCpmtext, 5.0f);
//    
//    CGContextDrawPath(curremtCpmtext, kCGPathFillStroke);
//    
//    CGPathRelease(path);
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
    //缩放视图
    CGAffineTransform transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    CGPathAddRect(path, &transform, rectangle);
    
    CGContextRef curremtCpmtext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(curremtCpmtext, path);
    
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    
    [[UIColor brownColor] setStroke];
    
    CGContextSetLineWidth(curremtCpmtext, 5.0f);
    
    CGContextDrawPath(curremtCpmtext, kCGPathFillStroke);
    
    CGPathRelease(path);

}


//旋转视图
-(void)xuanzhuanView{
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(10.0f, 10.0f, 200.0f, 300.0f);
    //缩放视图
    CGAffineTransform transform = CGAffineTransformMakeRotation((45*M_PI)/180.f);
    CGPathAddRect(path, &transform, rectangle);
    
    CGContextRef curremtCpmtext = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(curremtCpmtext, path);
    
    [[UIColor colorWithRed:0.20f green:0.60f blue:0.80f alpha:1.0f] setFill];
    
    [[UIColor brownColor] setStroke];
    
    CGContextSetLineWidth(curremtCpmtext, 5.0f);
    
    CGContextDrawPath(curremtCpmtext, kCGPathFillStroke);
    
    CGPathRelease(path);
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
