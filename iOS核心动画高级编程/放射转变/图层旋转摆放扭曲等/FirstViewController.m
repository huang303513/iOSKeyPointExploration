//
//  FirstViewController.m
//  
//
//  Created by maiyun on 15/6/15.
//
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *layerView;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    if (self.type == 0) {
        [self rotate45];
    }else if(self.type == 1){
        [self commonAnimation];
    }else if (self.type == 2){
        [self the3Dstransform];
    }

}

-(void)the3Dstransform{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/500.0;
    
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
}



//旋转45度
-(void)rotate45{
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerView.layer.affineTransform = transform;
}


//缩小50%，旋转30，右移200个像素
-(void)commonAnimation{
    CGAffineTransform transform = CGAffineTransformIdentity;
    //缩小50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    // 旋转30度
    transform = CGAffineTransformRotate(transform, M_PI/180.0 * 30.0);
    //右移200像素
    transform = CGAffineTransformTranslate(transform, 200, 0);
    self.layerView.layer.affineTransform = transform;
}

@end
