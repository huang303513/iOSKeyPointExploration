//
//  UrlImageButton.h
//  test image
//
//  Created by Xuyan Yang on 8/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageCompat.h"
#import "SDWebImageManagerDelegate.h"

@interface UrlImageButton : UIButton <SDWebImageManagerDelegate> {	
    NSInteger iconIndex;

	CGSize scaleSize;
	BOOL    isScale;
	
	BOOL    _animated;
	BOOL    _isBackgroundImage;
}

@property (nonatomic, assign) NSInteger iconIndex;

-(UIImage*) getDefaultImage;

- (void) setImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;
- (void) setBackgroundImageFromUrl:(BOOL)animated withUrl:(NSString *)iconUrl;

- (void)setImageWithURL:(NSURL *)url;
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)cancelCurrentImageLoad;

@end
