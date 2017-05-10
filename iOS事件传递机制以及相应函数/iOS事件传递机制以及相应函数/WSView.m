//
//  WSView.m
//  iOS事件传递机制以及相应函数
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "WSView.h"

@implementation WSView

//用户点击屏幕后产生的一个触摸事件，经过一系列的传递过程后，会找到最合适的视图控件来处理这个事件2>找到最合适的视图控件后，就会调用控件的touches方法来作具体的事件处理touchesBegan…touchesMoved…touchedEnded…3>这些touches方法的默认做法是将事件顺着响应者链条向上传递（也就是touch方法默认不处理事件，只传递事件），将事件交给上一个响应者进行处理
//在事件的响应中，如果某个控件实现了touches...方法，则这个事件将由该控件来接受，如果调用了[supertouches….];就会将事件顺着响应者链条往上传递，传递给上一个响应者；接着就会调用上一个响应者的touches….方法



// UIView是UIResponder的子类，可以覆盖下列4个方法处理不同的触摸事件
// 一根或者多根手指开始触摸view，系统会自动调用view的下面方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"摸我干啥");
}

// 一根或者多根手指在view上移动，系统会自动调用view的下面方法（随着手指的移动，会持续调用该方法）
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"哎呀，不要拽人家");
    // 想让控件随着手指移动而移动,监听手指移动
    // 获取UITouch对象
    UITouch *touch = [touches anyObject];
    // 获取当前点的位置
    CGPoint curP = [touch locationInView:self];
    // 获取上一个点的位置
    CGPoint preP = [touch previousLocationInView:self];
    // 获取它们x轴的偏移量,每次都是相对上一次
    CGFloat offsetX = curP.x - preP.x;
    // 获取y轴的偏移量
    CGFloat offsetY = curP.y - preP.y;
    // 修改控件的形变或者frame,center,就可以控制控件的位置
    // 形变也是相对上一次形变(平移)
    // CGAffineTransformMakeTranslation:会把之前形变给清空,重新开始设置形变参数
    // make:相对于最原始的位置形变
    // CGAffineTransform t:相对这个t的形变的基础上再去形变
    // 如果相对哪个形变再次形变,就传入它的形变
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}
// 触摸结束前，某个系统事件(例如电话呼入)会打断触摸过程，系统会自动调用view的下面方法
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
// 一根或者多根手指离开view，系统会自动调用view的下面方法
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"放开手还能继续玩耍");
}


// 什么时候调用:只要事件一传递给一个控件，那么这个控件就会调用自己的这个方法
// 作用:寻找并返回最合适的view
// UIApplication -> [UIWindow hitTest:withEvent:]寻找最合适的view告诉系统
// point:当前手指触摸的点
// point:是方法调用者坐标系上的点
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
    // 2.判断下点在不在窗口上
    // 不在窗口上
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    // 4.没有找到更合适的view，也就是没有比自己更合适的view
    return self;
}
// 作用:判断下传入过来的点在不在方法调用者的坐标系上
// point:是方法调用者坐标系上的点
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
// return NO;
//}

@end
