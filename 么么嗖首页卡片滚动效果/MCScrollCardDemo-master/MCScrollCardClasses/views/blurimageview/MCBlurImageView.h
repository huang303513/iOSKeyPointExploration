//
//  MCBlurImageView.h
//  imooc
//
//  Created by GJ on 15/10/26.
//  Copyright © 2015年 imooc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCBlurImageView : UIImageView

@end

@interface MCBlurImageView(iOS7)
- (UIImage*) blur:(UIImage*)theImage;
@end
