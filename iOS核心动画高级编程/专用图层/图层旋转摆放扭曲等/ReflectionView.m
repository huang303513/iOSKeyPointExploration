//
//  ReflectionView.m
//  
//
//  Created by maiyun on 15/6/24.
//
//

#import "ReflectionView.h"

@implementation ReflectionView

+(Class)layerClass{
    return [CAReplicatorLayer  class];
}

-(void)setUp{
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    //移动
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    //转换
    transform = CATransform3DScale(transform, -1, -1, 0);
    //instanceTransform指定了一个CATransform3D3D变换
    layer.instanceTransform = transform;
    
    //透明度
    layer.instanceAlphaOffset = -0.6;
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

@end
