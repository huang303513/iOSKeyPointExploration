//
//  LayerLable.m
//  
//
//  Created by maiyun on 15/6/24.
//
//

#import "LayerLable.h"

@implementation LayerLable

#pragma mark 这个方法会返回视图对应的图层的类。每次新建一个对象都会调用这个方法,创建一个CATextLayer来替代uilabel默认的layer。
+(Class)layerClass{
    return [CATextLayer class];
}

-(CATextLayer *)textLayer{
    return (CATextLayer *)self.layer;
}

-(void)setUp{
    //调用set方法设置属性
    self.text = self.text;
    self.textColor = self.textColor;
    self.font  = self.font;
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib{
    [self setUp];
}


#pragma mark 重写设置文字方法
-(void)setText:(NSString *)text{
    super.text = text;
    [self textLayer].string = text;
}

-(void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    [self textLayer].foregroundColor = textColor.CGColor;
}

-(void)setFont:(UIFont *)font{
    super.font = font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

@end
