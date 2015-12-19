//
//  UrlImageButton.m
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UrlImageView.h"
#import "NSURLAdditions.h"
#import "SDWebImageManager.h"

@interface UIImage (scale)  

-(UIImage*)scaleToSize:(CGSize)size;  

@end  

@implementation UIImage (scale)  

-(UIImage*)scaleToSize:(CGSize)size  
{  
    // 创建一个bitmap的context  
    // 并把它设置成为当前正在使用的context  
    UIGraphicsBeginImageContext(size);  
	
    // 绘制改变大小的图片  
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];  
	
    // 从当前context中创建一个改变大小后的图片  
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();  
	
    // 使当前的context出堆栈  
    UIGraphicsEndImageContext();  
	
    // 返回新的改变大小后的图片  
    return scaledImage;  
}  

@end  

@implementation UrlImageView

@synthesize iconIndex;
@synthesize _animated;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		iconIndex = -1;
        
		isScale= NO;
		_animated = NO;
		scaleSize = CGSizeZero;
        self.contentMode=UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor whiteColor];
	}
    return self;
}



-(UIImage*) getDefaultImage
{
    return [UIImage imageNamed:@"background.jpg"];
	
}


- (void) setImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;
{       	
    
	_animated = NO;
	
	NSURL* tempUrl = [NSURL URLWithString:iconUrl];
    
    
	NSURL* finallyUrl = nil;
	if([NSURL isWebURL:tempUrl])
	{
		finallyUrl = tempUrl;
	}
	else {
		finallyUrl = [NSURL URLWithString:iconUrl];
	}
    
	
	[self setImageWithURL:finallyUrl placeholderImage:[self getDefaultImage]];
	
}	

- (void)setImageWithURL:(NSURL *)url
{
	[self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
	SDWebImageManager *manager = [SDWebImageManager sharedManager];
	
    // Remove in progress downloader from queue
//    [manager cancelForDelegate:self];
//    
//	
    self.image = [self getDefaultImage];
//	_animated=NO;
//    if (url)
//    {
//        [manager downloadWithURL:url delegate:self];
//    }
//#warning 改
    [manager downloadImageWithURL:url options:SDWebImageLowPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        self.image = image;
    }];
	
}

- (void)cancelCurrentImageLoad
{
//#warning 改
	//[[SDWebImageManager sharedManager] cancelForDelegate:self];
}

-(void)scaleToSize:(CGSize)size 
{
	isScale= YES;
	scaleSize =size;
	UIImage* newImage = [self.image scaleToSize:size];
	self.image = newImage;
}


- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.alpha = 0.;
    [UIView transitionWithView:self duration:0.0  
                       options:UIViewAnimationOptionTransitionNone    //UIViewAnimationOptionTransitionCurlDown  
                    animations:^ { [self setAlpha:1.0f]; }  
                    completion:nil];
    self.image = image;
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error
{
    
}


@end
